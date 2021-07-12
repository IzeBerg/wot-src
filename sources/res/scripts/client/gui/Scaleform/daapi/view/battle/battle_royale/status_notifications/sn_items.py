import BigWorld
from AvatarInputHandler import AvatarInputHandler
from helpers import dependency
from constants import VEHICLE_MISC_STATUS, LootAction, LOOT_TYPE, ATTACK_REASONS, ATTACK_REASON
from gui.Scaleform.daapi.view.battle.battle_royale.status_notifications.components import StatusNotificationItem
from gui.Scaleform.daapi.view.common.battle_royale.br_helpers import getSmokeDataByPredicate, getEquipmentById
from gui.Scaleform.genConsts.BATTLE_NOTIFICATIONS_TIMER_TYPES import BATTLE_NOTIFICATIONS_TIMER_TYPES
from gui.battle_control import avatar_getter
from gui.battle_control.battle_constants import VEHICLE_VIEW_STATE
from gui.battle_royale.constants import SteelHunterEquipmentNames
from gui.impl import backport
from gui.impl.gen import R
from skeletons.gui.battle_session import IBattleSessionProvider

class _VehicleStateSN(StatusNotificationItem):
    _sessionProvider = dependency.descriptor(IBattleSessionProvider)
    _HIDE_STATES_TRIGGERS = (
     VEHICLE_VIEW_STATE.DESTROYED, VEHICLE_VIEW_STATE.CREW_DEACTIVATED, VEHICLE_VIEW_STATE.SWITCHING)

    def __init__(self, updateCallback):
        super(_VehicleStateSN, self).__init__(updateCallback)
        ctrl = self._sessionProvider.shared.vehicleState
        if ctrl is not None:
            ctrl.onVehicleStateUpdated += self.__onVehicleStateUpdated
        handler = avatar_getter.getInputHandler()
        if handler is not None:
            if isinstance(handler, AvatarInputHandler):
                handler.onCameraChanged += self.__onCameraChanged
        return

    def _subscribeOnVehControlling(self):
        ctrl = self._sessionProvider.shared.vehicleState
        ctrl.onVehicleControlling += self._onVehicleControlling
        vehicle = ctrl.getControllingVehicle()
        if vehicle is not None:
            self._onVehicleControlling(vehicle)
        return

    def destroy(self):
        ctrl = self._sessionProvider.shared.vehicleState
        if ctrl is not None:
            ctrl.onVehicleStateUpdated -= self.__onVehicleStateUpdated
            ctrl.onVehicleControlling -= self._onVehicleControlling
        handler = avatar_getter.getInputHandler()
        if handler is not None:
            if isinstance(handler, AvatarInputHandler):
                handler.onCameraChanged -= self.__onCameraChanged
        super(_VehicleStateSN, self).destroy()
        return

    def _update(self, value):
        pass

    def __onCameraChanged(self, ctrlMode, vehicleID=None):
        if ctrlMode == 'video':
            self._hide()

    def __onVehicleStateUpdated(self, state, value):
        if state in self._HIDE_STATES_TRIGGERS:
            self._hide()
        elif state == self.getItemID():
            self._update(value)

    def _onVehicleControlling(self, vehicle):
        ctrl = self._sessionProvider.shared.vehicleState
        stateValue = ctrl.getStateValue(self.getItemID())
        if stateValue:
            self._update(stateValue)


class FireSN(_VehicleStateSN):

    def __init__(self, updateCallback):
        super(FireSN, self).__init__(updateCallback)
        self._subscribeOnVehControlling()

    def getItemID(self):
        return VEHICLE_VIEW_STATE.FIRE

    def getViewTypeID(self):
        return BATTLE_NOTIFICATIONS_TIMER_TYPES.FIRE

    def _update(self, isInFire):
        self._setVisible(isInFire)


class TimeSnapshotHandler(object):

    def __init__(self, updateHandler):
        self._updateHandler = updateHandler
        self._startTime = 0

    def setTimeParams(self, totalTime, finishTime):
        if finishTime:
            self._startTime = finishTime - totalTime
        else:
            self._startTime = BigWorld.serverTime()

    def getCurrentTimeSnapshot(self):
        return BigWorld.serverTime() - self._startTime

    def destroy(self):
        self._updateHandler = None
        return


class SimpleSnapshotHandler(TimeSnapshotHandler):

    def setTimeParams(self, totalTime, finishTime):
        super(SimpleSnapshotHandler, self).setTimeParams(totalTime, finishTime)
        self._updateHandler(self.getCurrentTimeSnapshot(), totalTime)


class TimerSN(_VehicleStateSN):

    def __init__(self, updateCallback):
        super(TimerSN, self).__init__(updateCallback)
        self.__timeHandler = SimpleSnapshotHandler(self.__applySnapshot)

    def setTimeHandler(self, clazz):
        self.__destroyHandler()
        self.__timeHandler = clazz(self.__applySnapshot)

    def destroy(self):
        self.__destroyHandler()
        super(TimerSN, self).destroy()

    def _updateTimeParams(self, totalTime, finishTime):
        self.__timeHandler.setTimeParams(totalTime, finishTime)

    def __applySnapshot(self, currTime, totalTime, isVisible=None, isUpdateRequired=False):
        self._vo['currentTime'] = currTime
        self._vo['totalTime'] = totalTime
        if isVisible is not None:
            pass
        if isUpdateRequired:
            self._sendUpdate()
        return

    def getVO(self):
        vo = super(TimerSN, self).getVO()
        self._vo['currentTime'] = self.__timeHandler.getCurrentTimeSnapshot()
        return vo

    def __destroyHandler(self):
        if self.__timeHandler:
            self.__timeHandler.destroy()
        self.__timeHandler = None
        return


class StunSN(TimerSN):

    def __init__(self, updateCallback):
        super(StunSN, self).__init__(updateCallback)
        self._vo['title'] = backport.text(R.strings.ingame_gui.stun.indicator())
        self._subscribeOnVehControlling()

    def getItemID(self):
        return VEHICLE_VIEW_STATE.STUN

    def getViewTypeID(self):
        return BATTLE_NOTIFICATIONS_TIMER_TYPES.STUN

    def _update(self, value):
        if value.duration > 0.0:
            self._updateTimeParams(value.totalTime, value.endTime)
            self._isVisible = True
            self._sendUpdate()
        else:
            self._setVisible(False)


class _DestroyTimerSN(TimerSN):
    _ANY_SUPPORTED_LEVEL = 'anySupportedLevel'

    def __init__(self, updateCallback):
        super(_DestroyTimerSN, self).__init__(updateCallback)
        self._subscribeOnVehControlling()

    def _getSupportedLevel(self):
        raise NotImplementedError


class _DeathZoneSN(_DestroyTimerSN):

    def getItemID(self):
        return VEHICLE_VIEW_STATE.DEATHZONE_TIMER

    def _canBeShown(self, value):
        return self._getSupportedLevel() == value.level

    def _update(self, value):
        if self._canBeShown(value):
            self._isVisible = True
            self._updateTimeParams(value.totalTime, value.finishTime)
            self._sendUpdate()
            return
        self._setVisible(False)


class DeathZoneDamagingSN(_DeathZoneSN):

    def __init__(self, updateCallback):
        super(DeathZoneDamagingSN, self).__init__(updateCallback)
        self._vo['description'] = backport.text(R.strings.battle_royale.timersPanel.deathZone())

    def getViewTypeID(self):
        return BATTLE_NOTIFICATIONS_TIMER_TYPES.DAMAGING_ZONE

    def _canBeShown(self, value):
        if super(DeathZoneDamagingSN, self)._canBeShown(value):
            vehicle = self._sessionProvider.shared.vehicleState.getControllingVehicle()
            isAlive = vehicle is not None and vehicle.isAlive()
            return value.isCausingDamage and isAlive
        else:
            return False

    def _getSupportedLevel(self):
        return


class DeathZoneDangerSN(_DeathZoneSN):

    def __init__(self, updateCallback):
        super(DeathZoneDangerSN, self).__init__(updateCallback)
        self._vo['description'] = backport.text(R.strings.battle_royale.timersPanel.deathZone())

    def getViewTypeID(self):
        return BATTLE_NOTIFICATIONS_TIMER_TYPES.DEATH_ZONE

    def _canBeShown(self, value):
        if super(DeathZoneDangerSN, self)._canBeShown(value):
            return value.needToShow()
        return False

    def _getSupportedLevel(self):
        return 'critical'


class DeathZoneWarningSN(_DeathZoneSN):

    def __init__(self, updateCallback):
        super(DeathZoneWarningSN, self).__init__(updateCallback)
        self._vo['description'] = backport.text(R.strings.battle_royale.timersPanel.orangeZone())

    def getViewTypeID(self):
        return BATTLE_NOTIFICATIONS_TIMER_TYPES.ORANGE_ZONE

    def _canBeShown(self, value):
        if super(DeathZoneWarningSN, self)._canBeShown(value):
            return value.needToShow()
        return False

    def _getSupportedLevel(self):
        return 'warning'


class _DestroyMiscTimerSN(_DestroyTimerSN):

    def getItemID(self):
        return VEHICLE_VIEW_STATE.DESTROY_TIMER

    def _getSupportedMiscStatus(self):
        raise NotImplementedError

    def _update(self, value):
        level = value.level
        supportedLevel = self._getSupportedLevel()
        if self._getSupportedMiscStatus() == value.code:
            if value.needToCloseTimer():
                self._setVisible(False)
            elif supportedLevel == self._ANY_SUPPORTED_LEVEL or supportedLevel == level:
                if not value.needToCloseTimer():
                    self._isVisible = True
                    self._updateTimeParams(value.totalTime, 0)
                    self._sendUpdate()
                    return
                self._setVisible(False)


class _OverturnedBaseSN(_DestroyMiscTimerSN):

    def _getSupportedMiscStatus(self):
        return VEHICLE_MISC_STATUS.VEHICLE_IS_OVERTURNED


class OverturnedSN(_OverturnedBaseSN):

    def getViewTypeID(self):
        return BATTLE_NOTIFICATIONS_TIMER_TYPES.OVERTURNED

    def _getSupportedLevel(self):
        return 'critical'


class HalfOverturnedSN(_OverturnedBaseSN):

    def __init__(self, updateCallback):
        super(HalfOverturnedSN, self).__init__(updateCallback)
        self._vo['description'] = backport.text(R.strings.battle_royale.timersPanel.halfOverturned())

    def getViewTypeID(self):
        return BATTLE_NOTIFICATIONS_TIMER_TYPES.HALF_OVERTURNED

    def _getSupportedLevel(self):
        return 'warning'


class DrownSN(_DestroyMiscTimerSN):

    def getViewTypeID(self):
        return BATTLE_NOTIFICATIONS_TIMER_TYPES.DROWN

    def _getSupportedLevel(self):
        return self._ANY_SUPPORTED_LEVEL

    def _getSupportedMiscStatus(self):
        return VEHICLE_MISC_STATUS.VEHICLE_DROWN_WARNING


class LootPickUpSN(TimerSN):

    def __init__(self, updateCallback):
        super(LootPickUpSN, self).__init__(updateCallback)
        self.__loots = {}
        self.__vehicle = None
        self._subscribeOnVehControlling()
        return

    def destroy(self):
        self.__loots = None
        super(LootPickUpSN, self).destroy()
        return

    def getItemID(self):
        return VEHICLE_VIEW_STATE.LOOT

    def getViewTypeID(self):
        return BATTLE_NOTIFICATIONS_TIMER_TYPES.LOOT_PICKUP

    def _update(self, value):
        lootID, lootType, action, serverTime = value
        if action == LootAction.PICKUP_STARTED:
            self.__showLootTimer(lootID, lootType, serverTime)
        else:
            self.__hideLootTimer(lootID)

    def _onVehicleControlling(self, vehicle):
        if self.__vehicle != vehicle:
            self.__vehicle = vehicle
            self.__loots.clear()
            super(LootPickUpSN, self)._onVehicleControlling(vehicle)

    def __showLootTimer(self, lootID, lootTypeID, pickupTime):
        time = BigWorld.serverTime()
        if not self.__loots:
            self._isVisible = True
        self.__loots[lootID] = (lootTypeID, time + pickupTime)
        timeLeft = max(loot_time for _, loot_time in self.__loots.values())
        timeLeft -= time
        self.__updateText()
        self._updateTimeParams(timeLeft, 0)
        self._sendUpdate()

    def __hideLootTimer(self, lootID):
        if lootID in self.__loots:
            del self.__loots[lootID]
            self.__updateText()
            self._sendUpdate()
        if not self.__loots:
            self._setVisible(False)

    def __updateText(self):
        self._vo['title'] = backport.text(R.strings.battle_royale.timersPanel.lootPickup(), lootType=self.__getLootType())

    def __getLootType(self):
        count = len(self.__loots)
        if count > 1:
            return backport.text(R.strings.battle_royale.loot.multiple(), count=count)
        if count > 0:
            lootType, _ = self.__loots.values()[0]
            if lootType == LOOT_TYPE.BASIC:
                return backport.text(R.strings.battle_royale.loot.basic())
            if lootType == LOOT_TYPE.ADVANCED:
                return backport.text(R.strings.battle_royale.loot.advanced())
            if lootType == LOOT_TYPE.AIRDROP:
                return backport.text(R.strings.battle_royale.loot.airdrop())
            if lootType == LOOT_TYPE.CORPSE:
                return backport.text(R.strings.battle_royale.loot.corpse())
        return ''


class _BuffSN(TimerSN):

    def _getInActivationState(self):
        raise NotImplementedError

    def _constructTitle(self, value):
        return ''

    def _update(self, value):
        isInactivation = value.get('isInactivation')
        if isInactivation is not None and self._getInActivationState() == isInactivation:
            self._isVisible = True
            self._updateTimeParams(value.get('duration'), value.get('endTime'))
            self._vo['title'] = self._constructTitle(value)
            self._sendUpdate()
            return
        else:
            self._setVisible(False)
            return


class _BaseHealingSN(_BuffSN):

    def getItemID(self):
        return VEHICLE_VIEW_STATE.HEALING


class HealingSN(_BaseHealingSN):

    def getViewTypeID(self):
        return BATTLE_NOTIFICATIONS_TIMER_TYPES.HEALING

    def _getInActivationState(self):
        return False

    def _constructTitle(self, value):
        healingString = R.strings.battle_royale.equipment.healPoint.healing
        beingHealedString = R.strings.battle_royale.equipment.healPoint.healed
        isSourceVehicle = value.get('isSourceVehicle', False)
        if isSourceVehicle:
            return backport.text(healingString())
        return backport.text(beingHealedString())


class HealingCooldownSN(_BaseHealingSN):

    def getViewTypeID(self):
        return BATTLE_NOTIFICATIONS_TIMER_TYPES.HEALING_CD

    def _getInActivationState(self):
        return True

    def _constructTitle(self, value):
        return backport.text(R.strings.battle_royale.equipment.healPoint.healed())


class _BaseRepairingSN(_BuffSN):

    def _constructTitle(self, value):
        return backport.text(R.strings.battle_royale.equipment.repairPoint())

    def getItemID(self):
        return VEHICLE_VIEW_STATE.REPAIR_POINT


class RepairingSN(_BaseRepairingSN):

    def getViewTypeID(self):
        return BATTLE_NOTIFICATIONS_TIMER_TYPES.REPAIRING

    def _getInActivationState(self):
        return False


class RepairingCooldownSN(_BaseRepairingSN):

    def getViewTypeID(self):
        return BATTLE_NOTIFICATIONS_TIMER_TYPES.REPAIRING_CD

    def _getInActivationState(self):
        return True


class _InspireBaseSN(_BuffSN):

    def __init__(self, updateCallback):
        super(_InspireBaseSN, self).__init__(updateCallback)
        self._subscribeOnVehControlling()

    def _constructTitle(self, value):
        return backport.text(R.strings.battle_royale.timersPanel.inspired())

    def getItemID(self):
        return VEHICLE_VIEW_STATE.INSPIRE

    def _update(self, value):
        self._setVisible(False)
        equipmentID = value.get('equipmentID')
        if equipmentID is not None:
            itemName = self._sessionProvider.shared.equipments.getEquipmentNameByID(equipmentID)
            isBerserk = itemName == SteelHunterEquipmentNames.BERSERKER if itemName is not None else False
            if isBerserk:
                return
        isInactivation = value.get('isInactivation')
        primary = value.get('primary', True)
        if isInactivation is not None and primary:
            super(_InspireBaseSN, self)._update(value)
        return


class InspireSN(_InspireBaseSN):

    def getViewTypeID(self):
        return BATTLE_NOTIFICATIONS_TIMER_TYPES.INSPIRE

    def _getInActivationState(self):
        return False


class InspireCooldownSN(_InspireBaseSN):

    def getViewTypeID(self):
        return BATTLE_NOTIFICATIONS_TIMER_TYPES.INSPIRE_CD

    def _getInActivationState(self):
        return True


class BerserkerSN(TimerSN):

    def __init__(self, updateCallback):
        super(BerserkerSN, self).__init__(updateCallback)
        self._vo['title'] = backport.text(R.strings.battle_royale.equipment.berserk.active())

    def getItemID(self):
        return VEHICLE_VIEW_STATE.DOT_EFFECT

    def getViewTypeID(self):
        return BATTLE_NOTIFICATIONS_TIMER_TYPES.BERSERKER

    def _update(self, dotInfo):
        isVisible = False
        if dotInfo is not None:
            if dotInfo.attackReasonID != ATTACK_REASONS.index(ATTACK_REASON.BERSERKER):
                return
            isVisible = True
            totalTime = dotInfo.endTime - BigWorld.serverTime()
            self._updateTimeParams(totalTime, dotInfo.endTime)
        self._setVisible(isVisible)
        return


class _SmokeBase(TimerSN):

    def __init__(self, updateCallback):
        super(_SmokeBase, self).__init__(updateCallback)
        self._subscribeOnVehControlling()

    def destroy(self):
        self._smokeEquipment = None
        super(_SmokeBase, self).destroy()
        return

    def getItemID(self):
        return VEHICLE_VIEW_STATE.SMOKE

    def _isFitByEquipmentId(self, equipmentId):
        raise NotImplementedError

    def _update(self, smokesInfo):
        endTime, equipment = getSmokeDataByPredicate(smokesInfo, self._isFitByEquipmentId)
        if endTime is None:
            if self._isVisible:
                self._setVisible(False)
            return
        self._updateTimeParams(equipment.totalDuration, endTime)
        self._sendUpdate()
        self._setVisible(True)
        return


class SmokeSN(_SmokeBase):

    def __init__(self, updateCallback):
        super(SmokeSN, self).__init__(updateCallback)
        self._vo['title'] = backport.text(R.strings.epic_battle.smoke.In_smoke())

    def _isFitByEquipmentId(self, equipmentId):
        equipment = getEquipmentById(equipmentId)
        if equipment:
            return equipment.dotParams is None
        else:
            return False

    def getViewTypeID(self):
        return BATTLE_NOTIFICATIONS_TIMER_TYPES.SMOKE


class DamagingSmokeSN(_SmokeBase):

    def __init__(self, updateCallback):
        super(DamagingSmokeSN, self).__init__(updateCallback)
        self._vo['title'] = backport.text(R.strings.battle_royale.timersPanel.damagingSmoke())

    def _isFitByEquipmentId(self, equipmentId):
        equipment = getEquipmentById(equipmentId)
        if equipment:
            return equipment.dotParams is not None
        else:
            return False

    def getViewTypeID(self):
        return BATTLE_NOTIFICATIONS_TIMER_TYPES.DAMAGING_SMOKE