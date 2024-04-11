import BigWorld, SoundGroups
from constants import EQUIPMENT_STAGES
from items import vehicles
from gui.battle_control import avatar_getter
from gui.battle_control.controllers.consumables.equipment_ctrl import InCooldownError, _TriggerItem, _OrderItem, EquipmentsController, EquipmentsReplayPlayer, _ReplayItem, _ActivationError
from historical_battles.gui.sounds.sound_constants import HBDeathZoneEvent, HBUISound
from gui.shared.system_factory import registerEquipmentItem

class _HBBufItem(_TriggerItem):

    @property
    def becomeActive(self):
        return self._prevStage == EQUIPMENT_STAGES.READY and self._stage in (EQUIPMENT_STAGES.ACTIVE, EQUIPMENT_STAGES.COOLDOWN, EQUIPMENT_STAGES.EXHAUSTED)

    def update(self, quantity, stage, timeRemaining, totalTime):
        super(_HBBufItem, self).update(quantity, stage, timeRemaining, totalTime)
        if stage in (EQUIPMENT_STAGES.COOLDOWN, EQUIPMENT_STAGES.READY):
            self._totalTime = self._descriptor.cooldownSeconds
        elif stage == EQUIPMENT_STAGES.ACTIVE:
            self._totalTime = timeRemaining
        elif stage == EQUIPMENT_STAGES.PREPARING:
            self._totalTime = 0

    def _soundUpdate(self, prevQuantity, quantity):
        if not BigWorld.player().isObserver() or BigWorld.player().isObserverFPV:
            equipment = vehicles.g_cache.equipments().get(self.getEquipmentID(), None)
            if not equipment:
                return
            if self.becomeReady:
                SoundGroups.g_instance.playSound2D(HBUISound.READY_SOUND)
                if hasattr(equipment, 'soundNotificationActive'):
                    avatar_getter.getSoundNotifications().play(equipment.soundNotificationActive)
            elif self.becomeActive:
                if equipment.soundNotification:
                    avatar_getter.getSoundNotifications().play(equipment.soundNotification)
        return


class _HBAbilityItem(_OrderItem):

    @property
    def becomeAppointed(self):
        return self._prevStage in (EQUIPMENT_STAGES.READY, EQUIPMENT_STAGES.PREPARING) and self._needActivateMapCase() and self._stage in (EQUIPMENT_STAGES.ACTIVE, EQUIPMENT_STAGES.COOLDOWN, EQUIPMENT_STAGES.EXHAUSTED)

    def _soundUpdate(self, prevQuantity, quantity):
        if not BigWorld.player().isObserver() or BigWorld.player().isObserverFPV:
            equipment = vehicles.g_cache.equipments()[self.getEquipmentID()]
            if not equipment:
                return
            if self.becomeReady:
                SoundGroups.g_instance.playSound2D(HBUISound.READY_SOUND)
                if hasattr(equipment, 'soundNotification'):
                    avatar_getter.getSoundNotifications().play(equipment.soundNotification)
            elif self.becomeAppointed:
                SoundGroups.g_instance.playSound2D(self.getAppointmentUISound())
                if hasattr(equipment, 'wwsoundFiring') and equipment.wwsoundFiring:
                    SoundGroups.g_instance.playSound2D(equipment.wwsoundFiring)
                if equipment.wwsoundEquipmentUsed:
                    avatar_getter.getSoundNotifications().play(equipment.wwsoundEquipmentUsed)

    def getAppointmentUISound(self):
        return HBUISound.EMPTY_SOUND


class _AoeArcadeArtileryItem(_HBAbilityItem):

    def _getErrorMsg(self):
        if self._quantity:
            return InCooldownError(self._descriptor.userString)
        else:
            return

    def getAimingControlMode(self):
        from historical_battles.avatar_input_handler.hb_map_case_mode import AoeArcadeMapCaseControlMode
        return AoeArcadeMapCaseControlMode


class HBDynamicActiveStageCooldownItem(_HBBufItem):

    def update(self, quantity, stage, timeRemaining, totalTime):
        super(HBDynamicActiveStageCooldownItem, self).update(quantity, stage, timeRemaining, totalTime)
        if stage in (EQUIPMENT_STAGES.COOLDOWN, EQUIPMENT_STAGES.READY):
            self._totalTime = self._descriptor.cooldownSeconds
        elif stage == EQUIPMENT_STAGES.ACTIVE:
            self._totalTime = timeRemaining
        elif stage == EQUIPMENT_STAGES.PREPARING:
            self._totalTime = 0

    def getEntitiesIterator(self, avatar=None):
        return []

    def canDeactivate(self):
        return False


class HBAfterburningBuffItem(_HBBufItem):
    pass


class HBDeathZoneItem(_HBAbilityItem):

    def getMarker(self):
        return 'death'

    def _soundUpdate(self, prevQuantity, quantity):
        SoundGroups.g_instance.playSound2D(HBDeathZoneEvent.SOUND)


class HBArtileryItem(_HBAbilityItem):

    def getMarker(self):
        return 'artillery_green'

    def _getErrorMsg(self):
        if self._quantity:
            return InCooldownError(self._descriptor.userString)
        else:
            return

    def getAppointmentUISound(self):
        return HBUISound.ARTILERY_APPOINTED_SOUND

    def canActivate(self, entityName=None, avatar=None):
        if self._stage == EQUIPMENT_STAGES.UNAVAILABLE:
            return (False,
             _ActivationError('combatEquipmentNotReady', {'equipmentName': self._descriptor.userString}))
        return super(HBArtileryItem, self).canActivate(entityName, avatar)


class HBTacticalMineItem(HBArtileryItem):

    def getMarker(self):
        return 'minefield'

    def getAppointmentUISound(self):
        return HBUISound.TACTICAL_MINEFIELD_APPOINTED_SOUND


class HBBomberItem(HBArtileryItem):

    def getMarker(self):
        return 'bomber'


class HBBomberCasItem(HBBomberItem):

    def getMarker(self):
        return 'bomberCas'


class HBMinefieldItem(_AoeArcadeArtileryItem):

    def getMarker(self):
        return 'minefield'

    def getAppointmentUISound(self):
        return HBUISound.ARTILERY_APPOINTED_SOUND


class HBArcadeMinefieldItem(_AoeArcadeArtileryItem):

    def getMarker(self):
        return 'minefield'

    def getAppointmentUISound(self):
        return HBUISound.MINEFIELD_APPOINTED_SOUND


class HBAoeArcadeTeamRepairKitItem(_AoeArcadeArtileryItem):
    pass


class HBEquipmentController(EquipmentsController):
    __slots__ = ()

    def _doChangeSetting(self, item, entityName=None, avatar=None):
        result, error = super(HBEquipmentController, self)._doChangeSetting(item, entityName, avatar)
        if isinstance(item, (_HBAbilityItem, _HBBufItem)):
            SoundGroups.g_instance.playSound2D(HBUISound.PRESSED_SOUND if result else HBUISound.NOT_READY_SOUND)
        return (result, error)


class HBReplayEquipmentController(EquipmentsReplayPlayer):
    __slots__ = ()


class HBAfterburning(_HBBufItem):
    pass


class HBHealPoint(_HBBufItem):

    def canActivate(self, entityName=None, avatar=None):
        if self._stage == EQUIPMENT_STAGES.NOT_RUNNING:
            return (False,
             _ActivationError('combatEquipmentNotReady', {'equipmentName': self._descriptor.userString}))
        return super(HBHealPoint, self).canActivate(entityName, avatar)


def registerHBEquipmentCtrls():
    registerEquipmentItem('afterburning_hb', HBAfterburning, _ReplayItem)
    registerEquipmentItem('healpoint_hb', HBHealPoint, _ReplayItem)