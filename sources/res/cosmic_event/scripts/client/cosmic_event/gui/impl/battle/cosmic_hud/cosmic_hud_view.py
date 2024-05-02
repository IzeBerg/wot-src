import logging, weakref
from functools import partial
import typing, BigWorld, CommandMapping, GUI
from constants import SERVER_TICK_LENGTH, ARENA_PERIOD, EQUIPMENT_STAGES
from cosmic_event.gui.battle_control.controllers.consumables.equipment_ctrl import ExtraEquipmentTags
from cosmic_event.gui.impl.battle.cosmic_hud import getArenaScoreComponent, getVictimToKillerInfo, isMyKiller
from cosmic_event.gui.impl.battle.cosmic_hud.vehicle_markers_manager import VehicleMarkersManager
from cosmic_event.gui.impl.gen.view_models.views.battle.cosmic_hud.ability_model import AbilityModel, AbilityTypeEnum
from cosmic_event.gui.impl.gen.view_models.views.battle.cosmic_hud.cosmic_hud_view_model import CosmicHudViewModel, PhaseTypesEnum
from cosmic_event.gui.impl.gen.view_models.views.battle.cosmic_hud.player_record_model import PlayerRecordModel
from cosmic_event.gui.impl.gen.view_models.views.lobby.cosmic_lobby_view.scoring_model import ScoringTypeEnum
from cosmic_event.gui.shared.events import ProgressBarEvent, ZoneEvent
from cosmic_event_common.cosmic_constants import BATTLE_EVENT_TYPE, COSMIC_EVENT_ROCKET_BOOSTER, COSMIC_EVENT_SHIELD, COSMIC_EVENT_VORTEX, COSMIC_EVENT_REPULSOR, COSMIC_EVENT_JUMP, COSMIC_EVENT_MINES, PhaseTypes, ZoneTypes
from cosmic_sound import CosmicBattleSounds
from frameworks.wulf import ViewFlags, ViewSettings
from gui.battle_control import avatar_getter
from gui.battle_control.arena_info.interfaces import IArenaVehiclesController
from gui.battle_control.battle_constants import FEEDBACK_EVENT_ID
from gui.battle_control.battle_constants import VEHICLE_VIEW_STATE
from gui.impl.gen import R
from gui.impl.pub import ViewImpl
from gui.shared import EVENT_BUS_SCOPE, EventPriority
from gui.shared.utils.key_mapping import getReadableKey
from helpers import dependency, time_utils
from helpers.CallbackDelayer import CallbackDelayer
from skeletons.account_helpers.settings_core import ISettingsCore
from skeletons.gui.battle_session import IBattleSessionProvider, IArenaDataProvider
from cosmic_event import getFragmentManager, getVehicleFragments, getDeliveryZones
UPDATE_TICK_LENGTH = SERVER_TICK_LENGTH
_logger = logging.getLogger(__name__)
if typing.TYPE_CHECKING:
    from typing import Iterator, Sequence, Tuple, TypeVar, Callable, Optional, Any, Dict, Set
    from Event import Event
    from gui.battle_control.controllers.consumables.equipment_ctrl import _VisualScriptItem
    from cosmic_event.gui.battle_control.controllers.consumables.equipment_ctrl import CosmicEquipmentsController
    from cosmic_event.gui.impl.gen.view_models.views.battle.cosmic_hud.marker_model import MarkerModel
    from gui.battle_control.controllers.consumables.ammo_ctrl import ReloadingTimeSnapshot, AmmoController
    from gui.battle_control.arena_info.arena_vos import VehicleArenaInfoVO
    from gui.battle_control.controllers.interfaces import IBattleController
    from gui.battle_control.controllers.vehicle_state_ctrl import VehicleStateController
    from gui.battle_control.controllers.feedback_adaptor import BattleFeedbackAdaptor
    from gui.battle_control.controllers.feedback_events import PlayerFeedbackEvent
    from gui.shared.events import HasCtxEvent
    from hints.battle.schemas.base import CHMType
    from cosmic_event.gui.battle_hints.battle_hints_schema import CosmicHintPropsModel, CosmicEventHintTextModel
    from FragmentManager import FragmentManager
    BattleControllerType = TypeVar('BattleControllerType', bound=IBattleController)
SCORE_EVENT_IDS = {BATTLE_EVENT_TYPE.COSMIC_SHOT: ScoringTypeEnum.SHOT, 
   BATTLE_EVENT_TYPE.COSMIC_ABILITY_HIT: ScoringTypeEnum.ABILITYHIT, 
   BATTLE_EVENT_TYPE.COSMIC_PICKUP_ABILITY: ScoringTypeEnum.ABILITYPICKUP, 
   BATTLE_EVENT_TYPE.COSMIC_KILL: ScoringTypeEnum.KILL, 
   BATTLE_EVENT_TYPE.COSMIC_RAMMING: ScoringTypeEnum.RAM, 
   BATTLE_EVENT_TYPE.COSMIC_FRAGMENT_PICKUP: ScoringTypeEnum.FRAGMENTPICKUP, 
   BATTLE_EVENT_TYPE.COSMIC_FRAGMENT_CARRYING: ScoringTypeEnum.FRAGMENTCARRYING, 
   BATTLE_EVENT_TYPE.COSMIC_FRAGMENT_DELIVERING: ScoringTypeEnum.FRAGMENTDELIVERING, 
   BATTLE_EVENT_TYPE.COSMIC_KILL_ASSIST: ScoringTypeEnum.KILLASSIST, 
   BATTLE_EVENT_TYPE.COSMIC_FRAGMENT_HOLDER_KILL: ScoringTypeEnum.FRAGMENTHOLDERKILL, 
   BATTLE_EVENT_TYPE.COSMIC_EVACUATION: ScoringTypeEnum.EVACUATION}
_ABILITY_TYPE_BY_EQUIP_NAME = {COSMIC_EVENT_ROCKET_BOOSTER: AbilityTypeEnum.ACCELERATION, 
   COSMIC_EVENT_SHIELD: AbilityTypeEnum.SHIELD, 
   COSMIC_EVENT_VORTEX: AbilityTypeEnum.VORTEX, 
   COSMIC_EVENT_REPULSOR: AbilityTypeEnum.REPULSOR, 
   COSMIC_EVENT_JUMP: AbilityTypeEnum.JUMP, 
   COSMIC_EVENT_MINES: AbilityTypeEnum.MINES}
PHASE_TYPE_TO_ENUM = {PhaseTypes.IDLE: PhaseTypesEnum.IDLE, 
   PhaseTypes.DELIVERY: PhaseTypesEnum.DELIVERY, 
   PhaseTypes.PREBATTLE: PhaseTypesEnum.PREBATTLE, 
   PhaseTypes.EVACUATION: PhaseTypesEnum.EVACUATION}
_AMMO_START_IDX = 0
_AMMO_COUNT = 1
_EQUIPMENT_START_IDX = _AMMO_START_IDX + _AMMO_COUNT
_EQUIPMENT_COUNT = 2
_PICKUP_START_IDX = _EQUIPMENT_START_IDX + _EQUIPMENT_COUNT
_PICKUP_COUNT = 1
_TOTAL_ABILITIES = _AMMO_COUNT + _EQUIPMENT_COUNT + _PICKUP_COUNT
_DEFAULT_ANNOUNCEMENT_TIMER = -1
_NO_BINDING = ''

class CosmicHudView(ViewImpl, IArenaVehiclesController):
    __slots__ = ('__callbackDelayer', '_vehMarkersMan', '_markersCtrl', '_announcementTimer',
                 '_fragmentManager')
    sessionProvider = dependency.descriptor(IBattleSessionProvider)
    settingsCore = dependency.descriptor(ISettingsCore)

    def __init__(self):
        settings = ViewSettings(R.views.cosmic_event.battle.cosmic_hud.CosmicReactHudView(), ViewFlags.VIEW, CosmicHudViewModel())
        super(CosmicHudView, self).__init__(settings)
        self.__callbackDelayer = CallbackDelayer()
        self._markersCtrl = GUI.WGMarkerPositionController()
        self._vehMarkersMan = VehicleMarkersManager(self.viewModel.getVehicleMarkers(), weakref.proxy(self._markersCtrl))
        self._fragmentManager = getFragmentManager()
        self._announcementTimer = 0

    @property
    def viewModel(self):
        return super(CosmicHudView, self).getViewModel()

    @property
    def vehicleID(self):
        return avatar_getter.getPlayerVehicleID()

    def invalidateVehicleStatus(self, flags, vo, arenaDP):
        self._refreshPlayerListModel()

    def updateVehiclesInfo(self, updated, arenaDP):
        self._refreshPlayerListModel()

    def _initialize(self, *args, **kwargs):
        self._fragmentManager.onFragmentsUpdate += self._onFragmentsCountChanged

    def _onLoading(self, *args, **kwargs):
        super(CosmicHudView, self)._onLoading(*args, **kwargs)
        self.sessionProvider.addArenaCtrl(self)
        crosshair = self.sessionProvider.shared.crosshair
        aimPos = crosshair.getPosition()
        self._onCrosshairPositionChanged(aimPos[0], aimPos[1])
        self._onScaleSettingsChanged(self.settingsCore.interfaceScale.get())
        self._vehMarkersMan.start()
        gunMarkersSetInfo = crosshair.getGunMarkersSetInfo()
        self._markersCtrl.add(self.viewModel.crosshair.proxy, gunMarkersSetInfo.clientMarkerDataProvider.positionMatrixProvider)
        arenaDP = self.sessionProvider.getArenaDP()
        playerVehicleInfo = arenaDP.getVehicleInfo()
        playerName = playerVehicleInfo.player.name
        self.viewModel.setPlayerName(playerName if playerName is not None else '')
        self._refreshPlayerListModel()
        if self._fragmentManager:
            self._onFragmentsCountChanged(self._fragmentManager.getVehiclesWithFragments())
        zones = getDeliveryZones()
        for zone in zones:
            event = ZoneEvent(ZoneEvent.ZONE_CREATED, zone.id)
            self._onZoneCreated(event)

        abilitiesArray = self.viewModel.getAbilities()
        abilitiesArray.reserve(_TOTAL_ABILITIES)
        for i in range(_TOTAL_ABILITIES):
            model = AbilityModel()
            self._clearSlot(model)
            model.setKeyBind(self._getKeyString(i))
            abilitiesArray.addViewModel(model)

        _logger.info('HUD: onLoading')
        return

    def _finalize(self):
        self.sessionProvider.removeArenaCtrl(self)
        self.__stopPeriodTimer()
        self._fragmentManager.onFragmentsUpdate -= self._onZoneMarkerVisibilityChange
        self._fragmentManager.onFragmentsUpdate -= self._onFragmentsCountChanged
        self._markersCtrl.clear()
        self._vehMarkersMan.stop()
        super(CosmicHudView, self)._finalize()

    def _getListeners(self):
        listeners = [
         (
          ProgressBarEvent.PHASE_CHANGED,
          self._onGamePhaseChanged,
          EVENT_BUS_SCOPE.BATTLE,
          EventPriority.HIGH),
         (
          ProgressBarEvent.PHASE_COUNT_CHANGED,
          self._onPhaseCountChanged,
          EVENT_BUS_SCOPE.BATTLE,
          EventPriority.HIGH),
         (
          ZoneEvent.ZONE_CREATED,
          self._onZoneCreated,
          EVENT_BUS_SCOPE.BATTLE,
          EventPriority.HIGH),
         (
          ZoneEvent.ZONE_DESTROYED,
          self._onZoneDestroyed,
          EVENT_BUS_SCOPE.BATTLE,
          EventPriority.HIGH)]
        return listeners

    def _getEvents(self):
        events = [
         (
          CommandMapping.g_instance.onMappingChanged, self._onMappingChanged)]
        eqCtrl = self.sessionProvider.shared.equipments
        if eqCtrl is not None:
            events.extend((
             (
              eqCtrl.onEquipmentCooldownTime, self._onEquipmentReloadTimeSet),
             (
              eqCtrl.onEquipmentAdded, self._onEquipmentAdded),
             (
              eqCtrl.onEquipmentRemoved, self._onEquipmentRemoved),
             (
              eqCtrl.onEquipmentUpdated, self._onEquipmentUpdated),
             (
              eqCtrl.onEquipmentsCleared, self._onClearEquipment)))
        ammoCtrl = self.sessionProvider.shared.ammo
        if ammoCtrl is not None:
            events.extend((
             (
              ammoCtrl.onGunReloadTimeSet, self._onGunReloadTimeSet),
             (
              ammoCtrl.onShellsAdded, self._onShellsAdded)))
        crosshair = self.sessionProvider.shared.crosshair
        if crosshair is not None:
            events.append((crosshair.onCrosshairPositionChanged, self._onCrosshairPositionChanged))
        arenScoreComp = getArenaScoreComponent()
        if arenScoreComp:
            events.append((arenScoreComp.onArenaScoreUpdated, self.__onArenaScoreChanged))
            events.append((arenScoreComp.onVictimToKillerInfoUpdated, self.__onVictimToKillerInfoUpdated))
        respawnCtrl = self.sessionProvider.dynamic.respawn
        if respawnCtrl is not None:
            events.append((respawnCtrl.onVehicleDeployed, self.__onVehicleDeployed))
        vehicleCtrl = self.sessionProvider.shared.vehicleState
        if vehicleCtrl is not None:
            events.append((vehicleCtrl.onVehicleStateUpdated, self._onVehicleStateUpdated))
        feedbackCtrl = self.sessionProvider.shared.feedback
        if feedbackCtrl is not None:
            events.append((feedbackCtrl.onPlayerFeedbackReceived, self._onPlayerFeedbackReceived))
            events.append((feedbackCtrl.onVehicleFeedbackReceived, self._onVehicleFeedbackReceived))
            events.append((feedbackCtrl.onVehicleMarkerRemoved, self._onVehicleMarkerRemoved))
        events.append((self.settingsCore.interfaceScale.onScaleChanged, self._onScaleSettingsChanged))
        return events

    def _refreshPlayerListModel(self):
        self._updatePlayerListModel(self.__getArenaScore(), getVictimToKillerInfo())

    def _updatePlayerListModel(self, totalScore, victimToKiller):
        arenaDP = self.sessionProvider.getArenaDP()
        vehicles = {vInfo.player.name:vInfo for vInfo in arenaDP.getVehiclesInfoIterator()}
        rebuild = True
        modelPL = self.viewModel.getPlayerList()
        scoreList = []
        if len(modelPL) == len(vehicles):
            rebuild = False
            for playerRecord in modelPL:
                prName = playerRecord.getName()
                vehInfo = vehicles.get(prName)
                if vehInfo is not None:
                    scoreList.append((
                     totalScore.get(vehInfo.vehicleID, 0),
                     (
                      prName, vehInfo.player.clanAbbrev),
                     isMyKiller(self.vehicleID, vehInfo.vehicleID, victimToKiller),
                     vehInfo.isAlive()))
                else:
                    _logger.warning("Couldn't find vehicle in DataProvider by name=%s. DataProvider vehicles=%s. Rebuild list!", prName, vehicles.keys())
                    scoreList = None
                    rebuild = True
                    break

        if rebuild:
            scoreList = [ (totalScore.get(vInfo.vehicleID, 0), (vInfo.player.name, vInfo.player.clanAbbrev), isMyKiller(self.vehicleID, vInfo.vehicleID, victimToKiller), vInfo.isAlive()) for vInfo in vehicles.itervalues()
                        ]
        scoreList.sort(key=lambda x: x[0], reverse=True)
        with self.viewModel.transaction() as (model):
            playerList = model.getPlayerList()
            playerList.clear()
            playerList.reserve(len(scoreList))
            for i, scoreItem in enumerate(scoreList):
                model = PlayerRecordModel()
                model.setName(scoreItem[1][0] if scoreItem[1] else '')
                model.setClanAbbrev(scoreItem[1][1] if scoreItem[1] else '')
                model.setIsLastOffender(scoreItem[2])
                model.setScore(scoreItem[0])
                model.setIsAlive(scoreItem[3])
                model.setIsLeader(i == 0)
                playerList.addViewModel(model)

            playerList.invalidate()
        return

    def __onSecond(self):
        with self.viewModel.transaction() as (model):
            self._updateArenaTimer(model)
            self._updateAnnoucementTimer(model)
        return time_utils.ONE_SECOND

    def _updateArenaTimer(self, transaction):
        periodCtrl = self.sessionProvider.shared.arenaPeriod
        remainingTime = periodCtrl.getEndTime() - BigWorld.serverTime()
        period = periodCtrl.getPeriod()
        if period == ARENA_PERIOD.BATTLE:
            transaction.setArenaTimeLeft(remainingTime)

    def _updateAnnoucementTimer(self, transaction):
        if self._announcementTimer > 0:
            transaction.setAnnouncementSecondsToEvent(self._announcementTimer)
            CosmicBattleSounds.Announcements.playStep()
            self._announcementTimer -= time_utils.ONE_SECOND

    def setPeriod(self, period):
        if period == ARENA_PERIOD.PREBATTLE:
            self.__startPeriodTimer()
        elif period == ARENA_PERIOD.BATTLE:
            self.__startPeriodTimer()
        elif period == ARENA_PERIOD.AFTERBATTLE:
            self.__stopPeriodTimer()
        else:
            self.__stopPeriodTimer()

    def showTextHint(self, hintModel, params):
        textModel = hintModel.text
        propsModel = hintModel.props
        self.viewModel.setAnnouncementCustomTitle(textModel.message)
        if propsModel.showCountdown:
            overrideShowTime = int(float(params.get('overrideShowTime', 0)))
            showTime = overrideShowTime or int(hintModel.lifecycle.showTime)
            self._announcementTimer = showTime
            self.viewModel.setAnnouncementSecondsToEvent(showTime)

    def hideTextHint(self):
        self.viewModel.setAnnouncementCustomTitle('')
        if self.viewModel.getAnnouncementSecondsToEvent() > _DEFAULT_ANNOUNCEMENT_TIMER:
            CosmicBattleSounds.Announcements.playFinish()
        self.viewModel.setAnnouncementSecondsToEvent(_DEFAULT_ANNOUNCEMENT_TIMER)
        self._announcementTimer = 0

    def showVoiceHint(self, hintModel, params):
        _logger.info('Show voice hint %s %s', hintModel, params)
        self.viewModel.setIsAnnouncerVisible(True)

    def hideVoiceHint(self):
        _logger.info('Hide voice hint')
        self.viewModel.setIsAnnouncerVisible(False)

    def __startPeriodTimer(self):
        if not self.__callbackDelayer.hasDelayedCallback(self.__onSecond):
            self.__onSecond()
            self.__callbackDelayer.delayCallback(time_utils.ONE_SECOND, self.__onSecond)

    def __stopPeriodTimer(self):
        self.__callbackDelayer.stopCallback(self.__onSecond)

    def _onCrosshairPositionChanged(self, posx, posy):
        aimModel = self.viewModel.aim
        with aimModel.transaction() as (model):
            model.setPosx(posx)
            model.setPosy(posy)

    def _onScaleSettingsChanged(self, scale):
        aimModel = self.viewModel.aim
        with aimModel.transaction() as (model):
            model.setScale(scale)

    def _onShellsAdded(self, intCD, descriptor, *args):
        _logger.debug('Shell added: %s, %s', str(intCD), descriptor)
        idx = self._getAmmoIdx(intCD)
        if idx is None:
            return
        else:

            def addShell(model):
                model.setReloadTime(0)
                model.setType(AbilityTypeEnum.SHELL)
                model.setReloadTimeLeft(0)
                model.setIsActive(False)
                model.setKeyBind('')

            self._updateAbilityModel(idx, addShell)
            return

    def _onGunReloadTimeSet(self, intCD, state, skipAutoLoader):
        _logger.debug('Reload: %s, %s, %d', str(intCD), str(state), skipAutoLoader)
        timeLeft = state.getTimeLeft()
        reloadTime = state.getBaseValue()
        idx = self._getAmmoIdx(intCD)
        if idx is None:
            return
        else:
            with self.viewModel.transaction() as (model):
                model.setReloadTimeLeft(timeLeft)
                model.setReloadTime(reloadTime)
                abilityArray = model.getAbilities()
                abilityModel = abilityArray[idx]
                abilityModel.setReloadTime(reloadTime)
                abilityModel.setReloadTimeLeft(timeLeft)
            return

    def _onEquipmentReloadTimeSet(self, intCD, timeLeft, isBaseTime, isFinish):
        _logger.debug('Reload equipment: %s, %s, %d, %d', str(intCD), timeLeft, isBaseTime, isFinish)
        idx = self._getEquipmentIdx(intCD)
        if idx is None:
            return
        else:

            def updateReload(model):
                if isBaseTime:
                    model.setReloadTime(timeLeft)
                    model.setReloadTimeLeft(0)
                else:
                    model.setReloadTimeLeft(timeLeft)

            self._updateAbilityModel(idx, updateReload)
            return

    def _onEquipmentUpdated(self, intCD, item):
        timeLeft = item.getTimeRemaining()
        maxTime = item.getTotalTime()
        stage = item.getStage()
        _logger.debug('Equipment updated: intCD: %s, name: %s, timeLeft: %s, maxtime: %s, stage: %s, quantity: %s', str(intCD), item.getDescriptor().name, timeLeft, maxTime, stage, item.getQuantity())
        idx = self._getEquipmentIdx(intCD)
        if idx is None:
            return
        else:
            if ExtraEquipmentTags.TARGETING in item.getTags():
                self.viewModel.setIsTargeting(stage == EQUIPMENT_STAGES.PREPARING)

            def updateReload(model):
                model.setIsActive(stage == EQUIPMENT_STAGES.ACTIVE)
                if stage == EQUIPMENT_STAGES.COOLDOWN:
                    model.setReloadTimeLeft(timeLeft)
                    model.setReloadTime(maxTime)
                if stage == EQUIPMENT_STAGES.READY:
                    model.setReloadTimeLeft(0)

            self._updateAbilityModel(idx, updateReload)
            return

    def _onEquipmentAdded(self, intCD, item):
        equipmentName = item.getDescriptor().name
        _logger.debug('Equipment added: intCD %s, name: %s, quantity: %s, totalTime: %s, stage: %s', str(intCD), equipmentName, item.getQuantity(), item.getTotalTime(), item.getStage())
        idx = self._getEquipmentIdx(intCD)
        if idx is None:
            return
        else:

            def addEquipment(model):
                model.setReloadTime(item.getTotalTime())
                model.setType(_ABILITY_TYPE_BY_EQUIP_NAME[equipmentName])
                model.setReloadTimeLeft(0)
                model.setIsActive(False)

            self._updateAbilityModel(idx, addEquipment)
            return

    def _onMappingChanged(self, *args):
        _logger.debug('Consumable panel: Updating key bindings.')
        with self.viewModel.transaction() as (model):
            abilities = model.getAbilities()
            for i, ability in enumerate(abilities):
                ability.setKeyBind(self._getKeyString(i))

            abilities.invalidate()

    def _getKeyString(self, idx):
        if _AMMO_START_IDX <= idx < _EQUIPMENT_START_IDX:
            _logger.debug('Index is of an ammo slot, ammo slots should not have keybindings.')
            return _NO_BINDING
        relativeEquipmentIndex = idx - _EQUIPMENT_START_IDX
        command = CommandMapping.CMD_AMMO_CHOICE_1 + relativeEquipmentIndex
        if command > CommandMapping.CMD_AMMO_CHOICE_0:
            _logger.warning('No free command slots. Command: %s', command)
            return _NO_BINDING
        return getReadableKey(command)

    def _onEquipmentRemoved(self, intCD, item):
        _logger.debug('Equipment removed: %s, %s, %s', str(intCD), item.getDescriptor().name, item.getQuantity())
        abilityType = _ABILITY_TYPE_BY_EQUIP_NAME[item.getDescriptor().name]
        abilityArray = self.viewModel.getAbilities()
        for model in reversed(abilityArray):
            if model.getType() == abilityType:
                self._clearSlot(model)
                break

        abilityArray.invalidate()

    def _clearSlot(self, model):
        model.setType(AbilityTypeEnum.NONE)
        model.setReloadTimeLeft(0)

    def _onClearEquipment(self):
        _logger.debug('clearing equipment from panel.')
        abilityArray = self.viewModel.getAbilities()
        for model in abilityArray:
            self._clearSlot(model)

        abilityArray.invalidate()

    def _getEquipmentIdx(self, intCD):
        eqCtrl = self.sessionProvider.shared.equipments
        idx = eqCtrl.getOrdinal(intCD)
        if idx is None:
            return
        else:
            idx += _EQUIPMENT_START_IDX
            if idx >= _TOTAL_ABILITIES:
                _logger.warning('Equipment %d at index %d. The index is out of the expected range. Equipment indices start at %d, total equipment slots %d', intCD, idx, _EQUIPMENT_START_IDX, _TOTAL_ABILITIES)
                return
            return idx

    def _getAmmoIdx(self, intCD):
        ammoCtrl = self.sessionProvider.shared.ammo
        if intCD not in ammoCtrl.getShellsOrderIter():
            _logger.warning('Shell %d cannot be found in ammo controller. Ammo list %s', intCD, ammoCtrl.getShellsLayout())
            return None
        else:
            idx = list(ammoCtrl.getShellsOrderIter()).index(intCD)
            idx += _AMMO_START_IDX
            if idx >= _EQUIPMENT_START_IDX:
                _logger.info('Additional shell %d cannot be displayed in model. Model only displays %d shell(s).', intCD, _AMMO_COUNT)
                return None
            return idx

    def _updateAbilityModel(self, idx, updateFunc):
        abilityArray = self.viewModel.getAbilities()
        if idx >= len(abilityArray):
            _logger.warning('Index is out of range for the abilities array. Array length: %s, Expected number of abilities %s', len(abilityArray), _TOTAL_ABILITIES)
            return
        abilityModel = abilityArray[idx]
        with abilityModel.transaction() as (model):
            updateFunc(model)
        abilityArray.invalidate()

    @staticmethod
    def __getArenaScore():
        arenScoreComp = getArenaScoreComponent()
        if arenScoreComp is None:
            return {}
        else:
            return arenScoreComp.totalScore

    def __onVehicleDeployed(self):
        with self.viewModel.transaction() as (model):
            model.setIsTargeting(False)

    def _onVehicleStateUpdated(self, state, value):
        if state == VEHICLE_VIEW_STATE.DESTROY_TIMER:
            self.viewModel.setVehicleOverturned(avatar_getter.isVehicleOverturned())
        elif state == VEHICLE_VIEW_STATE.DEATH_INFO:
            self._refreshPlayerListModel()
        elif state == VEHICLE_VIEW_STATE.DESTROYED or state == VEHICLE_VIEW_STATE.CREW_DEACTIVATED:
            self.viewModel.setIsRespawning(True)
        elif state == VEHICLE_VIEW_STATE.SWITCHING:
            self.viewModel.setIsRespawning(False)

    def __onArenaScoreChanged(self, totalScore):
        self._updatePlayerListModel(totalScore, getVictimToKillerInfo())

    def __onVictimToKillerInfoUpdated(self, victimToKiller):
        self._updatePlayerListModel(self.__getArenaScore(), victimToKiller)

    def _onVehicleFeedbackReceived(self, eventID, vehicleID, _):
        if eventID == FEEDBACK_EVENT_ID.ENTITY_IN_FOCUS:
            vehicle = BigWorld.entity(vehicleID)
            if vehicle is not None:
                vehicle.removeEdge()
        return

    def _onPlayerFeedbackReceived(self, events):
        newMessages = []
        for event in events:
            eventType = event.getBattleEventType()
            if eventType in SCORE_EVENT_IDS:
                messageModel = self.viewModel.getMessagesType()()
                messageModel.setType(SCORE_EVENT_IDS.get(eventType))
                messageModel.setEventPoints(event.getExtra())
                if eventType in (BATTLE_EVENT_TYPE.COSMIC_EVACUATION, BATTLE_EVENT_TYPE.COSMIC_FRAGMENT_DELIVERING):
                    messageModel.setCount(event.getCount())
                newMessages.append(messageModel)
                if eventType == BATTLE_EVENT_TYPE.COSMIC_SHOT:
                    self._onPlayerHit()
                if eventType == BATTLE_EVENT_TYPE.COSMIC_PICKUP_ABILITY:
                    CosmicBattleSounds.playAbilityPickup()

        with self.viewModel.transaction() as (model):
            messages = model.getMessages()
            messages.reserve(len(messages) + len(newMessages))
            for message in newMessages:
                messages.addViewModel(message)

            messages.invalidate()

    def _onVehicleMarkerRemoved(self, vehicleID):
        self._vehMarkersMan.setVehicleMarkerDisabled(vehicleID, True)

    def _updateMarkerVisibility(self, shouldShow):
        isMarkerVisible = self.viewModel.getShowPoiMarker()
        if isMarkerVisible and not shouldShow:
            self.viewModel.setShowPoiMarker(False)
        if not isMarkerVisible and shouldShow:
            self.viewModel.setShowPoiMarker(True)

    def _onPlayerHit(self):
        self.viewModel.setIsShotHit(True)
        self.__callbackDelayer.delayCallback(time_utils.ONE_SECOND, partial(self.viewModel.setIsShotHit, False))

    def _onGamePhaseChanged(self, event):
        with self.viewModel.transaction() as (transaction):
            phaseType = event.ctx.get('phaseType')
            transaction.setCurrentPhaseIdx(event.ctx.get('phaseIdx', 0))
            transaction.setCurrentPhaseDuration(event.ctx.get('phaseDuration', 0))
            transaction.setCurrentPhaseTimeLeft(event.ctx.get('phaseTimeLeft', 0))
            transaction.setCurrentPhaseType(PHASE_TYPE_TO_ENUM.get(phaseType, PhaseTypesEnum.PREBATTLE))
            if phaseType == PhaseTypes.EVACUATION:
                transaction.setIsHideOnEvacuation(True)

    def _onPhaseCountChanged(self, event):
        self.viewModel.setPhaseCount(event.ctx.get('phaseCount', 0))

    def _onZoneCreated(self, event):
        zoneEntityId = event.zoneEntityId
        zoneEntity = BigWorld.entities.get(zoneEntityId, None)
        if zoneEntity:
            _logger.debug('Adding poi marker for zone entity (id=%s)!', zoneEntityId)
            self._markersCtrl.add(self.viewModel.poiMarker.proxy, zoneEntity.matrix)
            if zoneEntity.zoneTypeName == ZoneTypes.EVACUATION:
                self._updateMarkerVisibility(shouldShow=True)
                return
            self._fragmentManager.onFragmentsUpdate += self._onZoneMarkerVisibilityChange
            self._onZoneMarkerVisibilityChange(self._fragmentManager.getVehiclesWithFragments())
        else:
            _logger.error('Could not show poi marker because the zone entity (id=%s) was not found!', zoneEntityId)
        return

    def _onZoneDestroyed(self, event):
        zoneEntityId = event.zoneEntityId
        self._updateMarkerVisibility(shouldShow=False)
        self._markersCtrl.remove(self.viewModel.poiMarker.proxy)
        self._fragmentManager.onFragmentsUpdate -= self._onZoneMarkerVisibilityChange
        _logger.debug('Removing poi marker for zone entity (id=%s)!', zoneEntityId)

    def _onZoneMarkerVisibilityChange(self, vehicleIDs):
        if self.vehicleID in vehicleIDs:
            vehicleFragments = getVehicleFragments(self.vehicleID)
            self._updateMarkerVisibility(shouldShow=bool(vehicleFragments))

    def _onFragmentsCountChanged(self, vehicleIDs):
        if self.vehicleID in vehicleIDs:
            self.viewModel.setFragmentsCollected(self._fragmentManager.getFragmentsByVehicleID(self.vehicleID))