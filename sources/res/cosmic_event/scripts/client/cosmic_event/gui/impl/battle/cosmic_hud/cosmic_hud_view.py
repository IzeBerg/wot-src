import logging, typing, BigWorld, CommandMapping
from cosmic_event.gui.impl.battle.cosmic_hud.announcements import AnnouncementGoal, _AnnouncementRespawn, getAnnouncementType
from cosmic_event.gui.impl.battle.cosmic_hud.vehicle_markers_manager import VehicleMarkersManager
from cosmic_event.gui.impl.gen.view_models.views.battle.cosmic_hud.ability_model import AbilityModel, AbilityTypeEnum
from cosmic_event.gui.impl.gen.view_models.views.battle.cosmic_hud.cosmic_hud_view_model import CosmicHudViewModel, AnnouncementTypeEnum, ArenaPhaseEnum
from cosmic_event.gui.impl.gen.view_models.views.battle.cosmic_hud.player_record_model import PlayerRecordModel
from constants import SERVER_TICK_LENGTH, ARENA_PERIOD, EQUIPMENT_STAGES
from cosmic_event.gui.impl.gen.view_models.views.lobby.cosmic_lobby_view.scoring_model import ScoringTypeEnum
from cosmic_event.gui.shared.events import ArtifactScanningEvent
from cosmic_event.settings import HINTS
from cosmic_event_common.cosmic_constants import BATTLE_EVENT_TYPE, COSMIC_EVENT_ROCKET_BOOSTER, COSMIC_EVENT_RAPIDSHELLING, COSMIC_EVENT_BLACKHOLE, COSMIC_EVENT_OVERCHARGE, COSMIC_EVENT_SHIELD
from cosmic_sound import CosmicBattleSounds
from frameworks.wulf import ViewFlags, ViewSettings
from gui.battle_control import avatar_getter
from gui.battle_control.battle_constants import VEHICLE_VIEW_STATE
from gui.impl.gen import R
from gui.impl.pub import ViewImpl
from gui.shared import EVENT_BUS_SCOPE, EventPriority
from gui.shared.utils.key_mapping import getReadableKey
from gui.battle_control.battle_constants import FEEDBACK_EVENT_ID
from helpers.CallbackDelayer import CallbackDelayer
from helpers import dependency, time_utils
from skeletons.gui.battle_session import IBattleSessionProvider, IArenaDataProvider
from skeletons.gui.impl import IGuiLoader
from cosmic_event.gui.battle_control.controllers.consumables.equipment_ctrl import ExtraEquipmentTags
UPDATE_TICK_LENGTH = SERVER_TICK_LENGTH
_logger = logging.getLogger(__name__)
if typing.TYPE_CHECKING:
    from typing import Iterator, Sequence, Tuple, TypeVar, Callable, Optional, Any, Dict
    from Event import Event
    from gui.battle_control.controllers.consumables.equipment_ctrl import _VisualScriptItem
    from cosmic_event.gui.battle_control.controllers.consumables.equipment_ctrl import CosmicEquipmentsController
    from gui.battle_control.controllers.consumables.ammo_ctrl import ReloadingTimeSnapshot, AmmoController
    from gui.battle_control.arena_info.arena_vos import VehicleArenaInfoVO
    from gui.battle_control.controllers.interfaces import IBattleController
    from gui.battle_control.controllers.vehicle_state_ctrl import VehicleStateController
    from gui.battle_control.controllers.feedback_adaptor import BattleFeedbackAdaptor
    from gui.battle_control.controllers.feedback_events import PlayerFeedbackEvent
    from cosmic_event.gui.impl.gen.view_models.views.battle.cosmic_hud.artefact_scanning import ArtefactScanning
    from cosmic_event.settings import Goal
    BattleControllerType = TypeVar('BattleControllerType', bound=IBattleController)
SCORE_EVENT_IDS = {BATTLE_EVENT_TYPE.COSMIC_SHOT: ScoringTypeEnum.SHOT, 
   BATTLE_EVENT_TYPE.COSMIC_ABILITY_HIT: ScoringTypeEnum.ABILITYHIT, 
   BATTLE_EVENT_TYPE.COSMIC_PICKUP_ABILITY: ScoringTypeEnum.PICKUP, 
   BATTLE_EVENT_TYPE.COSMIC_ARTIFACT_SCAN: ScoringTypeEnum.SCAN, 
   BATTLE_EVENT_TYPE.COSMIC_KILL: ScoringTypeEnum.KILL, 
   BATTLE_EVENT_TYPE.COSMIC_RAMMING: ScoringTypeEnum.RAM}
_ABILITY_TYPE_BY_EQUIP_NAME = {COSMIC_EVENT_ROCKET_BOOSTER: AbilityTypeEnum.ACCELERATION, 
   COSMIC_EVENT_SHIELD: AbilityTypeEnum.SHIELD, 
   COSMIC_EVENT_RAPIDSHELLING: AbilityTypeEnum.RAPIDSHELLING, 
   COSMIC_EVENT_BLACKHOLE: AbilityTypeEnum.BLACKHOLE, 
   COSMIC_EVENT_OVERCHARGE: AbilityTypeEnum.OVERCHARGE}
_AMMO_START_IDX = 0
_AMMO_COUNT = 1
_EQUIPMENT_START_IDX = _AMMO_START_IDX + _AMMO_COUNT
_EQUIPMENT_COUNT = 2
_PICKUP_START_IDX = _EQUIPMENT_START_IDX + _EQUIPMENT_COUNT
_PICKUP_COUNT = 1
_TOTAL_ABILITIES = _AMMO_COUNT + _EQUIPMENT_COUNT + _PICKUP_COUNT
_NO_BINDING = ''

def _getArenaScoreComponent():
    player = BigWorld.player()
    if player and player.arena is not None:
        arenaInfo = player.arena.arenaInfo
        if arenaInfo:
            return arenaInfo.dynamicComponents.get('ArenaInfoScoreSystemComponent', None)
    return


class CosmicHudView(ViewImpl):
    __slots__ = ('__callbackDelayer', '_vehMarkersMan', '_currentGoal', '_respawnAnnouncement',
                 '_scanningEvent', '_shootingAbilityCD', '_isShootingAbilityActive')
    sessionProvider = dependency.descriptor(IBattleSessionProvider)
    guiLoader = dependency.descriptor(IGuiLoader)

    def __init__(self):
        settings = ViewSettings(R.views.cosmic_event.battle.cosmic_hud.CosmicReactHudView(), ViewFlags.COMPONENT, CosmicHudViewModel())
        super(CosmicHudView, self).__init__(settings)
        self.__callbackDelayer = CallbackDelayer()
        self._vehMarkersMan = VehicleMarkersManager(self.viewModel.getVehicleMarkers())
        self._currentGoal = None
        self._respawnAnnouncement = None
        self._scanningEvent = None
        self._shootingAbilityCD = None
        self._isShootingAbilityActive = False
        return

    @property
    def viewModel(self):
        return super(CosmicHudView, self).getViewModel()

    @property
    def currentGoal(self):
        if self._respawnAnnouncement is not None:
            return self._respawnAnnouncement
        else:
            return self._currentGoal

    @property
    def vehicleID(self):
        player = BigWorld.player()
        return player.playerVehicleID

    def _onLoading(self, *args, **kwargs):
        super(CosmicHudView, self)._onLoading(*args, **kwargs)
        CosmicBattleSounds.ScanningZone.switchInactiveState()
        crosshair = self.sessionProvider.shared.crosshair
        aimPos = crosshair.getPosition()
        self._onCrosshairPositionChanged(aimPos[0], aimPos[1])
        self._vehMarkersMan.start()
        gunMarkersSetInfo = crosshair.getGunMarkersSetInfo()
        self.guiLoader.markers.addMarkerDynamic(self.viewModel.crosshair.proxy, gunMarkersSetInfo.clientMarkerDataProvider.positionMatrixProvider)
        arenaDP = self.sessionProvider.getArenaDP()
        playerVehicleInfo = arenaDP.getVehicleInfo()
        playerName = playerVehicleInfo.player.name
        self.viewModel.setPlayerName(playerName if playerName is not None else '')
        totalScore = self.__getArenaScore()
        self._updatePlayerListModel(totalScore)
        self._currentGoal = AnnouncementGoal(HINTS.get(AnnouncementTypeEnum.AWAITINGPLAYERS.value), {})
        self.viewModel.setAnnouncementType(AnnouncementTypeEnum.AWAITINGPLAYERS)
        self.viewModel.setArenaPhase(ArenaPhaseEnum.PREBATTLE)
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
        self.__stopPeriodTimer()
        self.guiLoader.markers.removeMarker(self.viewModel.crosshair.proxy)
        self.guiLoader.markers.removeMarker(self.viewModel.poiMarker.proxy)
        self._vehMarkersMan.stop()
        super(CosmicHudView, self)._finalize()

    def _getListeners(self):
        listeners = [
         (
          ArtifactScanningEvent.VEHICLES_IN_ZONE_CHANGED,
          self._onScanningVehiclesChanged,
          EVENT_BUS_SCOPE.BATTLE,
          EventPriority.HIGH),
         (
          ArtifactScanningEvent.ANNOUNCEMENT_CREATED,
          self._onArtifactAnnouncementCreated,
          EVENT_BUS_SCOPE.BATTLE),
         (
          ArtifactScanningEvent.ARTIFACT_SCANNING_READY,
          self._onArtifactCreated,
          EVENT_BUS_SCOPE.BATTLE),
         (
          ArtifactScanningEvent.ARTIFACT_DESTROYED,
          self._onArtifactDestroyed,
          EVENT_BUS_SCOPE.BATTLE)]
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
        arenScoreComp = _getArenaScoreComponent()
        if arenScoreComp:
            events.append((arenScoreComp.onArenaScoreUpdated, self.__onArenaScoreChanged))
        respawnCtrl = self.sessionProvider.dynamic.respawn
        if respawnCtrl is not None:
            events.append((respawnCtrl.onVehicleDeployed, self.__onVehicleDeployed))
        vehicleCtrl = self.sessionProvider.shared.vehicleState
        if vehicleCtrl is not None:
            events.append((vehicleCtrl.onVehicleStateUpdated, self._onVehicleStateUpdated))
        feedbackCtrl = self.sessionProvider.shared.feedback
        if feedbackCtrl is not None:
            events.append((feedbackCtrl.onPlayerFeedbackReceived, self._onPlayerFeedbackReceived))
            events.append((feedbackCtrl.onVehicleFeedbackReceived, self.__onVehicleFeedbackReceived))
        return events

    def _updatePlayerListModel(self, totalScore):
        arenaDP = self.sessionProvider.getArenaDP()
        vehicles = arenaDP.getVehiclesInfoIterator()
        scoreList = [ (totalScore.get(vInfo.vehicleID, 0), (vInfo.player.name, vInfo.player.clanAbbrev)) for vInfo in vehicles
                    ]
        scoreList.sort(reverse=True)
        with self.viewModel.transaction() as (model):
            playerList = model.getPlayerList()
            playerList.clear()
            playerList.reserve(len(scoreList))
            for scoreItem in scoreList:
                model = PlayerRecordModel()
                model.setName(scoreItem[1][0] if scoreItem[1] else '')
                model.setClanAbbrev(scoreItem[1][1] if scoreItem[1] else '')
                model.setScore(scoreItem[0])
                playerList.addViewModel(model)

            playerList.invalidate()

    def __onSecond(self):
        with self.viewModel.transaction() as (model):
            self._updateArenaTimer(model)
            self._updateAnnouncement(model)
            self._updateScanning(model)
        return time_utils.ONE_SECOND

    def _updateArenaTimer(self, transaction):
        periodCtrl = self.sessionProvider.shared.arenaPeriod
        remainingTime = periodCtrl.getEndTime() - BigWorld.serverTime()
        period = periodCtrl.getPeriod()
        if period == ARENA_PERIOD.BATTLE:
            transaction.setArenaTimeLeft(remainingTime)

    def _updateAnnouncement(self, transaction):
        if self.currentGoal is not None:
            self.currentGoal.updateAnnouncement(transaction)
        return

    def _updateScanning(self, transaction):
        if self._scanningEvent is not None:
            remTime = self._scanningEvent.get('endLifeTime') - BigWorld.serverTime()
            transaction.artefactScanning.setTimeLeft(remTime)
        return

    def _clearCurrentGoal(self, transaction=None):
        if self._currentGoal is None:
            return
        else:
            self._currentGoal.endAnnouncement(transaction)
            self._currentGoal = None
            return

    def setPeriod(self, period):
        if period == ARENA_PERIOD.PREBATTLE:
            self._currentGoal = AnnouncementGoal(HINTS.get(AnnouncementTypeEnum.PREBATTLE.value), {'param2': 'True'})
            self.__startPeriodTimer()
        elif period == ARENA_PERIOD.BATTLE:
            CosmicBattleSounds.startBattlePeriodMusic()
            with self.viewModel.transaction() as (transaction):
                transaction.setArenaPhase(ArenaPhaseEnum.PHASE1)
                self._clearCurrentGoal(transaction=transaction)
                self.__startPeriodTimer()
        elif period == ARENA_PERIOD.AFTERBATTLE:
            CosmicBattleSounds.startAfterBattlePeriodMusic()
            self.__stopPeriodTimer()
            with self.viewModel.transaction() as (transaction):
                self._clearCurrentGoal(transaction=transaction)
                transaction.setAnnouncementType(AnnouncementTypeEnum.MISSIONCOMPLETED)
        else:
            self.__stopPeriodTimer()

    def showHint(self, hint, data=None):
        if self._currentGoal is not None and self._currentGoal.type in [
         AnnouncementTypeEnum.SCANNING,
         AnnouncementTypeEnum.SCANAVAILABLE,
         AnnouncementTypeEnum.SCANNING] and not self._currentGoal.ended:
            _logger.warning('Tried to show hint while scanning event is in progress.')
            return
        else:
            self._currentGoal = getAnnouncementType(hint, data)
            return

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
                if self._isShootingAbilityActive:
                    abilityModel.setReloadTimeLeft(0)
                    shootingIdx = self._getEquipmentIdx(self._shootingAbilityCD)
                    shootingModel = abilityArray[shootingIdx]
                    shootingModel.setReloadTime(reloadTime)
                    shootingModel.setReloadTimeLeft(timeLeft)
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
            if self._isShootingAbility(intCD) and stage == EQUIPMENT_STAGES.ACTIVE:
                self._isShootingAbilityActive = True
                abilityModel = self.viewModel.getAbilities()[_AMMO_START_IDX]
                abilityModel.setIsEnabled(False)
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

    def _isShootingAbility(self, intCD):
        return intCD == self._shootingAbilityCD

    def _onEquipmentAdded(self, intCD, item):
        equipmentName = item.getDescriptor().name
        _logger.debug('Equipment added: intCD %s, name: %s, quantity: %s, totalTime: %s, stage: %s', str(intCD), equipmentName, item.getQuantity(), item.getTotalTime(), item.getStage())
        if equipmentName == COSMIC_EVENT_RAPIDSHELLING:
            self._shootingAbilityCD = intCD
            self.viewModel.setOverchargeDuration(item.getDescriptor().duration)
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
        if self._isShootingAbility(intCD):
            self._isShootingAbilityActive = False
            abilityModel = self.viewModel.getAbilities()[_AMMO_START_IDX]
            abilityModel.setIsEnabled(True)
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
        self._isShootingAbilityActive = False
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
        arenScoreComp = _getArenaScoreComponent()
        if arenScoreComp is None:
            return {}
        else:
            return arenScoreComp.totalScore

    def __onVehicleDeployed(self):
        self._respawnAnnouncement = None
        with self.viewModel.transaction() as (model):
            model.setIsTargeting(False)
            if self._currentGoal is not None and self._currentGoal.type == AnnouncementTypeEnum.AWAITINGPLAYERS:
                return
            model.setAnnouncementType(AnnouncementTypeEnum.NONE)
            model.setAnnouncementSecondsToEvent(-1)
        return

    def _onVehicleStateUpdated(self, state, value):
        if state == VEHICLE_VIEW_STATE.DESTROY_TIMER:
            self.viewModel.setVehicleOverturned(avatar_getter.isVehicleOverturned())
        elif state == VEHICLE_VIEW_STATE.DEATH_INFO:
            self._respawnAnnouncement = _AnnouncementRespawn()
            with self.viewModel.transaction() as (tx):
                self._updateAnnouncement(tx)
        elif state == VEHICLE_VIEW_STATE.DESTROYED or state == VEHICLE_VIEW_STATE.CREW_DEACTIVATED:
            self.viewModel.setIsRespawning(True)
        elif state == VEHICLE_VIEW_STATE.SWITCHING:
            self.viewModel.setIsRespawning(False)

    def __onArenaScoreChanged(self, totalScore):
        self._updatePlayerListModel(totalScore)

    def __onVehicleFeedbackReceived(self, eventID, vehicleID, _):
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
                messageModel.setMarsPoints(event.getExtra())
                newMessages.append(messageModel)
                CosmicBattleSounds.playScoreNotification()
                if eventType == BATTLE_EVENT_TYPE.COSMIC_PICKUP_ABILITY:
                    CosmicBattleSounds.playAbilityPickup()

        with self.viewModel.transaction() as (model):
            messages = model.getMessages()
            messages.reserve(len(messages) + len(newMessages))
            for message in newMessages:
                messages.addViewModel(message)

            messages.invalidate()

    def _onScanningVehiclesChanged(self, event):
        self._setScanningVehicles(event)
        self._updateMarkerVisibility(event)

    def _setScanningVehicles(self, event):
        vehicles = event.ctx.get('vehicles')
        self.viewModel.artefactScanning.setActivePlayers(len(vehicles))

    def _updateMarkerVisibility(self, event):
        vehicles = event.ctx.get('vehicles')
        isMarkerVisible = self.viewModel.getShowPoiMarker()
        if self.vehicleID in vehicles and isMarkerVisible:
            self.viewModel.setShowPoiMarker(False)
        elif self.vehicleID not in vehicles and not isMarkerVisible:
            self.viewModel.setShowPoiMarker(True)

    def _onArtifactAnnouncementCreated(self, event):
        self.guiLoader.markers.addMarkerStatic(self.viewModel.poiMarker.proxy, event.ctx.get('position'))
        self.viewModel.setShowPoiMarker(True)

    def _onArtifactCreated(self, event):
        self._scanningEvent = event.ctx
        CosmicBattleSounds.ScanningZone.setActive(self._scanningEvent.get('isLastOne', False))
        with self.viewModel.artefactScanning.transaction() as (tx):
            tx.setTotalTime(event.ctx.get('duration'))
            tx.setTimeLeft(event.ctx.get('endLifeTime') - BigWorld.serverTime())

    def _onArtifactDestroyed(self, event):
        isLast = self._scanningEvent.get('isLastOne', False) if self._scanningEvent else False
        CosmicBattleSounds.ScanningZone.setInactive(isLast)
        self._scanningEvent = None
        self.guiLoader.markers.removeMarker(self.viewModel.poiMarker.proxy)
        with self.viewModel.transaction() as (tx):
            tx.setShowPoiMarker(False)
            artifact = tx.artefactScanning
            artifact.setTotalTime(0)
            artifact.setTimeLeft(0)
            artifact.setActivePlayers(0)
        return