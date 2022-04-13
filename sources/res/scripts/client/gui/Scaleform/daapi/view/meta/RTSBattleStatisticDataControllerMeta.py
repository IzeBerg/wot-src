from gui.Scaleform.daapi.view.battle.shared.stats_exchange.stats_ctrl import BattleStatisticsDataController

class RTSBattleStatisticDataControllerMeta(BattleStatisticsDataController):

    def as_setRTSCommanderInfoS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_setRTSCommanderInfo(data)

    def as_setRTSCommanderDataS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_setRTSCommanderData(data)

    def as_setRTSOrderS(self, vehicleID, orderId, isActive):
        if self._isDAAPIInited():
            return self.flashObject.as_setRTSOrder(vehicleID, orderId, isActive)

    def as_setDeviceDamagedS(self, vehicleID, deviceName):
        if self._isDAAPIInited():
            return self.flashObject.as_setDeviceDamaged(vehicleID, deviceName)

    def as_setDeviceRepairedS(self, vehicleID, deviceName):
        if self._isDAAPIInited():
            return self.flashObject.as_setDeviceRepaired(vehicleID, deviceName)

    def as_setRTSCommanderModeS(self, value):
        if self._isDAAPIInited():
            return self.flashObject.as_setRTSCommanderMode(value)

    def as_setRTSPlayerCommanderS(self, value):
        if self._isDAAPIInited():
            return self.flashObject.as_setRTSPlayerCommander(value)

    def as_setRTSSupplyDataS(self, value):
        if self._isDAAPIInited():
            return self.flashObject.as_setRTSSupplyData(value)

    def as_setRTSVehicleGroupS(self, vehicleID, groupID):
        if self._isDAAPIInited():
            return self.flashObject.as_setRTSVehicleGroup(vehicleID, groupID)

    def as_setRTSSelectedVehiclesS(self, vehicleIDs):
        if self._isDAAPIInited():
            return self.flashObject.as_setRTSSelectedVehicles(vehicleIDs)

    def as_setRTSVehicleInFocusS(self, vehicleID):
        if self._isDAAPIInited():
            return self.flashObject.as_setRTSVehicleInFocus(vehicleID)

    def as_setRTSVehiclesInFocusS(self, vehicleIDs, focused):
        if self._isDAAPIInited():
            return self.flashObject.as_setRTSVehiclesInFocus(vehicleIDs, focused)

    def as_setRTSReloadingS(self, vehicleID, updateTime, timeLeft, baseTime):
        if self._isDAAPIInited():
            return self.flashObject.as_setRTSReloading(vehicleID, updateTime, timeLeft, baseTime)

    def as_setRTSSpeakingVehicleS(self, vehicleID, value):
        if self._isDAAPIInited():
            return self.flashObject.as_setRTSSpeakingVehicle(vehicleID, value)

    def as_setRTSVehicleDisabledS(self, vehicleID, value):
        if self._isDAAPIInited():
            return self.flashObject.as_setRTSVehicleDisabled(vehicleID, value)

    def as_setRTSClipDataS(self, vehicleID, maxCount, currentCount, isAutoload, isDualgun):
        if self._isDAAPIInited():
            return self.flashObject.as_setRTSClipData(vehicleID, maxCount, currentCount, isAutoload, isDualgun)

    def as_setRTSVehicleConditionS(self, vehicleID, condition):
        if self._isDAAPIInited():
            return self.flashObject.as_setRTSVehicleCondition(vehicleID, condition)