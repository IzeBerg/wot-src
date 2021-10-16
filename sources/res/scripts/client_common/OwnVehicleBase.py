from collections import namedtuple
from functools import partial
import BigWorld
from constants import VEHICLE_SETTING, DAMAGE_INFO_CODES, DAMAGE_INFO_INDICES
from items import vehicles, ITEM_TYPES
from math_common import roundToPower10
from time_converters import time2decisec
from wotdecorators import noexcept
from helpers_common import unpackDeviceRepairProgress
Cooldowns = namedtuple('Cooldows', ['id', 'leftTime', 'baseTime'])
_DO_LOG = False

class OwnVehicleBase(BigWorld.DynamicScriptComponent):

    def __init__(self):
        super(OwnVehicleBase, self).__init__()
        self._doLog(('OwnVehicleBase __init__ {}').format(self.entity.id))
        self.__isInitialUpdated = False
        self.__isAttachingToVehicle = False
        self.initialUpdate()

    def onDestroy(self):
        self._doLog(('onDestroy {}').format(self.entity.id))
        self.__onDestroy()

    def onLeaveWorld(self):
        self._doLog(('onLeaveWorld {}').format(self.entity.id))
        self.__onDestroy()

    def __onDestroy(self):
        self.__dict__.clear()

    @noexcept
    def update_vehicleAmmoList(self, ammoList):
        avatar = self._avatar()
        for vehicleAmmo in ammoList:
            timeRemainig = vehicleAmmo.endTime
            if timeRemainig > 0:
                timeRemainig = max(vehicleAmmo.endTime - self._serverTime(), 0)
            avatar.updateVehicleAmmo(self.entity.id, vehicleAmmo.compactDescr, vehicleAmmo.quantity, vehicleAmmo.quantityInClip, vehicleAmmo.previousStage, timeRemainig, vehicleAmmo.totalTime)

    @noexcept
    def update_syncVehicleAttrs(self, syncVehicleAttrs):
        self._avatar().syncVehicleAttrs(syncVehicleAttrs)

    @noexcept
    def update_vehicleGunReloadTime(self, prop):
        timeLeft, timeBase = self.__getTimeLeftBaseTime(prop)
        self._avatar().updateVehicleGunReloadTime(self.entity.id, timeLeft, timeBase)

    @noexcept
    def update_vehicleClipReloadTime(self, prop):
        timeLeft, timeBase = self.__getTimeLeftBaseTime(prop)
        self._avatar().updateVehicleClipReloadTime(self.entity.id, timeLeft, timeBase, prop.firstTime, prop.stunned, prop.isBoostApplicable)

    @noexcept
    def update_vehicleSettings(self, prop):
        self._avatar().updateVehicleSettings(prop)

    @noexcept
    def update_destroyedDevicesIsRepairing(self, deviceList):
        avatar = self._avatar()
        for device in deviceList:
            timeLeft = self.__getTimeLeft(device)
            progress, isLimited = unpackDeviceRepairProgress(device.progressData)
            avatar.updateDestroyedDevicesIsRepairing(self.entity.id, device.extraIndex, progress, timeLeft, isLimited)

    @noexcept
    def update_vehicleDamageInfoList(self, damageInfoList):
        if not damageInfoList:
            return
        avatar = self._avatar()
        for damage in damageInfoList:
            damageIndex = damage.damageIndex
            if self.__isAttachingToVehicle:
                if DAMAGE_INFO_CODES[damageIndex].startswith('DEVICE_CRITICAL'):
                    damageIndex = DAMAGE_INFO_INDICES['DEVICE_CRITICAL']
                if DAMAGE_INFO_CODES[damageIndex] == 'DEVICE_REPAIRED_TO_CRITICAL':
                    damageIndex = DAMAGE_INFO_INDICES['DEVICE_CRITICAL']
                if DAMAGE_INFO_CODES[damageIndex].startswith('ENGINE_CRITICAL'):
                    damageIndex = DAMAGE_INFO_INDICES['DEVICE_CRITICAL']
                if DAMAGE_INFO_CODES[damageIndex].startswith('DEVICE_DESTROYED'):
                    damageIndex = DAMAGE_INFO_INDICES['DEVICE_DESTROYED']
            avatar.showVehicleDamageInfo(self.entity.id, damageIndex, damage.extraIndex, damage.entityID, damage.equipmentID)

    @noexcept
    def update_vehicleOptionalDeviceStatusList(self, deviceList):
        avatar = self._avatar()
        for optDevStatus in deviceList:
            avatar.updateVehicleOptionalDeviceStatus(self.entity.id, optDevStatus.deviceID, optDevStatus.isOn)

    @noexcept
    def update_dualGunState(self, dualGunState):
        if dualGunState is None:
            return
        else:
            avatar = self._avatar()
            cooldowns = []
            useEndTime = self.__isAttachingToVehicle
            for cd in dualGunState.cooldowns:
                if cd.endTime > 0 and useEndTime:
                    cooldowns.append(Cooldowns(cd.id, max(0.0, time2decisec(cd.endTime / 10.0 - self._serverTime())), cd.baseTime))
                else:
                    cooldowns.append(Cooldowns(cd.id, cd.leftTime, cd.baseTime))

            avatar.updateDualGunState(self.entity.id, dualGunState.activeGun, dualGunState.gunStates, cooldowns)
            return

    @noexcept
    def update_dualGunStatus(self, dualGunStatus):
        avatar = self._avatar()
        if not dualGunStatus or not avatar.userSeesWorld():
            return
        times = dualGunStatus.times
        timeLeft = self.__getTimeLeft(times)
        avatar.updateDualGunStatus(self.entity.id, dualGunStatus.status, (roundToPower10(times.baseTime, -2), timeLeft))

    @noexcept
    def update_siegeStateStatus(self, siegeStateStatus):
        timeLeft = self.__getTimeLeft(siegeStateStatus)
        self._avatar().updateSiegeStateStatus(self.entity.id, siegeStateStatus.status, timeLeft)

    @noexcept
    def update_burnoutWarning(self, burnoutWarning):
        self._avatar().updateBurnoutWarning(self.entity.id, burnoutWarning.status)

    @noexcept
    def update_burnoutUnavailable(self, burnoutUnavailable):
        avatar = self._avatar()
        avatar.updateBurnoutUnavailable(self.entity.id, burnoutUnavailable.status)

    @noexcept
    def update_drownLevel(self, drownLevel):
        self._avatar().updateDrownLevel(self.entity.id, drownLevel.level, self.__getDestroyTimes(drownLevel.times))

    @noexcept
    def update_isOtherVehicleDamagedDevicesVisible(self, isOtherVehicleDamagedDevicesVisible):
        self._avatar().updateIsOtherVehicleDamagedDevicesVisible(self.entity.id, isOtherVehicleDamagedDevicesVisible.status)

    @noexcept
    def update_overturnLevel(self, overturnLevel):
        self._avatar().updateOverturnLevel(self.entity.id, overturnLevel.level, self.__getDestroyTimes(overturnLevel.times))

    @noexcept
    def update_smoke(self, smoke):
        self._avatar().onSmoke(smoke.smokeInfos)

    @noexcept
    def update_targetVehicleID(self, targetVehicleID):
        self._avatar().updateTargetVehicleID(targetVehicleID.targetID)

    @noexcept
    def update_targetingInfo(self, data):
        self._avatar().updateTargetingInfo(data.turretYaw, data.gunPitch, data.maxTurretRotationSpeed, data.maxGunRotationSpeed, data.shotDispMultiplierFactor, data.gunShotDispersionFactorsTurretRotation, data.chassisShotDispersionFactorsMovement, data.chassisShotDispersionFactorsRotation, data.aimingTime)

    @noexcept
    def update_vehicleHealthInfo(self, data):
        self._avatar().updateVehicleHealth(self.entity.id, data.health, data.deathReasonID, data.isCrewActive, data.isRespawnActive)

    @noexcept
    def update_welcomeToSector(self, data):
        self._avatar().welcomeToSector(data.sectorID, data.groupID, data.groupState, data.goodGroup, data.actionTime, data.actionDuration)

    @noexcept
    def update_battleEventsSummary(self, data):
        self._avatar().battleEventsSummary(data)

    @noexcept
    def update_deathZonesStatus(self, data):
        self._avatar().updateDeathZonesStatus(self.entity.id, data)

    def onBattleEvents(self, battleEvents):
        if _DO_LOG:
            self._doLog(('onBattleEvents {}').format(battleEvents))
        self._avatar().onBattleEvents(battleEvents)

    def onObservedByEnemy(self):
        if _DO_LOG:
            self._doLog('onObservedByEnemy')
        self._avatar().onObservedByEnemy(self.entity.id)

    def onSectorShooting(self, sectorID):
        if _DO_LOG:
            self._doLog(('onSectorShooting {}').format(sectorID))
        self._avatar().onSectorShooting(sectorID)

    def beforeSetupUpdate(self):
        self._avatar().beforeSetupUpdate(self.entity.id)

    def showOwnVehicleHitDirection(self, data):
        if _DO_LOG:
            self._doLog(('showOwnVehicleHitDirection {}').format(data))
        self._avatar().showOwnVehicleHitDirection(data.hitDirYaw, data.attackerID, data.damage, data.crits, data.isBlocked, data.isShellHE, data.damagedID, data.attackReasonID)

    def getReloadTime(self):
        if self.vehicleGunReloadTime:
            return self.__getTimeLeftBaseTime(self.vehicleGunReloadTime, True)
        return (0, 0)

    def setNested_vehicleAmmoList(self, path, prev):
        changedAmmo = self.vehicleAmmoList[path[0]]
        if changedAmmo.compactDescr != prev.compactDescr:
            self._avatar().resetVehicleAmmo(prev.compactDescr, changedAmmo.compactDescr, changedAmmo.quantity, changedAmmo.previousStage, changedAmmo.endTime, changedAmmo.totalTime)
        else:
            self.__setNested(self.update_vehicleAmmoList, 'vehicleAmmoList', path, prev)

    def __getDestroyTimes(self, times):
        startTime = BigWorld.serverTime() if self.__isAttachingToVehicle else times[0]
        return (startTime, max(times[1] - startTime, 0.0))

    def __getTimeLeft(self, data, useEndTime=None):
        if useEndTime is None:
            useEndTime = self.__isAttachingToVehicle
        if data.timeLeft <= 0:
            timeLeft = data.timeLeft
        elif useEndTime:
            timeLeft = max(0, data.endTime - self._serverTime())
        else:
            timeLeft = roundToPower10(data.timeLeft, -2)
        return timeLeft

    def __getTimeLeftBaseTime(self, data, useEndTime=None):
        return (self.__getTimeLeft(data, useEndTime), roundToPower10(data.baseTime, -2))

    @property
    def shells(self):
        return self.__getItemsByType(ITEM_TYPES.shell)

    @property
    def equipment(self):
        return self.__getItemsByType(ITEM_TYPES.equipment)

    @property
    def currentShell(self):
        return self.__getVehicleSetting(VEHICLE_SETTING.CURRENT_SHELLS)

    @property
    def nextShell(self):
        return self.__getVehicleSetting(VEHICLE_SETTING.NEXT_SHELLS)

    def __getItemsByType(self, ammoType):
        return [ ammo for ammo in self.vehicleAmmoList if vehicles.parseIntCompactDescr(ammo.compactDescr)[0] == ammoType
               ]

    def __getVehicleSetting(self, code):
        for item in self.vehicleSettings:
            if item.code == code:
                return item.value

        return -1

    def initialUpdate(self, force=False):
        if not force:
            if self.__isInitialUpdated or not self.entity.isStarted:
                return
        self.__isInitialUpdated = True
        self.__isAttachingToVehicle = True
        try:
            self.__attachToVehicle()
        finally:
            self.__isAttachingToVehicle = False

    def __attachToVehicle(self):
        self.set_vehicleAmmoList()
        self.set_vehicleGunReloadTime()
        self.set_vehicleClipReloadTime()
        self.set_syncVehicleAttrs()
        self.set_vehicleSettings()
        self.set_destroyedDevicesIsRepairing()
        self.set_vehicleDamageInfoList()
        self.set_vehicleOptionalDeviceStatusList()
        self.set_dualGunState()
        self.set_dualGunStatus()
        self.set_burnoutWarning()
        self.set_burnoutUnavailable()
        self.set_isOtherVehicleDamagedDevicesVisible()
        self.set_overturnLevel()
        self.set_smoke()
        self.set_targetVehicleID()
        self.set_targetingInfo()
        self.set_vehicleHealthInfo()
        self.set_welcomeToSector()
        self.set_siegeStateStatus()

    def __getattr__(self, item):
        if _DO_LOG:
            self._doLog(('__getAttr {}').format(item))
        parts = item.split('_')
        if len(parts) == 2 and (parts[0] == 'set' or parts[0] == 'setNested' or parts[0] == 'setSlice'):
            if hasattr(self, parts[1]):
                fname = 'update_' + parts[1]
                func = getattr(self, fname, None)
                if func:
                    attrFunc = None
                    if parts[0] == 'set':
                        attrFunc = partial(self.__set, func, parts[1])
                    if parts[0] == 'setNested':
                        attrFunc = partial(self.__setNested, func, parts[1])
                    if parts[0] == 'setSlice':
                        attrFunc = partial(self.__setSlice, func, parts[1])
                    self.__dict__[item] = attrFunc
                    return attrFunc
        raise AttributeError(('OwnVehicle does not have attrubure {}').format(item))
        return

    def __set(self, func, propname, oldValue=None):
        if _DO_LOG:
            self._doLog(('__set {} {} {}').format(propname, getattr(self, propname), oldValue))
        prop = getattr(self, propname)
        if prop is not None:
            func(prop)
        return

    def __setNested(self, func, propname, changePath, oldValue=None):
        if _DO_LOG:
            self._doLog(('__setNested {} {} {} {}').format(propname, getattr(self, propname), changePath, oldValue))
        func(getattr(self, propname)[changePath[0]:changePath[0] + 1])

    def __setSlice(self, func, propname, changePath, oldValue=None):
        if _DO_LOG:
            self._doLog(('__setSlice {} {} {} {}').format(propname, changePath, getattr(self, propname), oldValue))
        if oldValue:
            return
        prop = getattr(self, propname)
        if not prop:
            return
        fromIndex, toIndex = changePath[(-1)]
        func(prop[fromIndex:toIndex])

    def _doLog(self, msg):
        pass

    def _serverTime(self):
        raise NotImplementedError('_serverTime must be overrided in ownVehicle')

    def _avatar(self):
        raise NotImplementedError('_avatar must be overrided in ownVehicle')