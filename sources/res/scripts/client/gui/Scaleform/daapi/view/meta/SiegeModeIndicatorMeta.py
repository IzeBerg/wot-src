from gui.Scaleform.framework.entities.BaseDAAPIComponent import BaseDAAPIComponent

class SiegeModeIndicatorMeta(BaseDAAPIComponent):

    def as_switchSiegeStateS(self, totalTime, leftTime, siegeState, moduleState, isSmooth):
        if self._isDAAPIInited():
            return self.flashObject.as_switchSiegeState(totalTime, leftTime, siegeState, moduleState, isSmooth)

    def as_setAutoSiegeModeStateS(self, siegeState, moduleState):
        if self._isDAAPIInited():
            return self.flashObject.as_setAutoSiegeModeState(siegeState, moduleState)

    def as_switchSiegeStateSnapshotS(self, totalTime, leftTime, siegeState, moduleState, isSmooth):
        if self._isDAAPIInited():
            return self.flashObject.as_switchSiegeStateSnapshot(totalTime, leftTime, siegeState, moduleState, isSmooth)

    def as_updateDeviceStateS(self, deviceName, deviceState):
        if self._isDAAPIInited():
            return self.flashObject.as_updateDeviceState(deviceName, deviceState)

    def as_updateLayoutS(self, x, y):
        if self._isDAAPIInited():
            return self.flashObject.as_updateLayout(x, y)

    def as_setVisibleS(self, visible):
        if self._isDAAPIInited():
            return self.flashObject.as_setVisible(visible)

    def as_setSiegeModeTypeS(self, type):
        if self._isDAAPIInited():
            return self.flashObject.as_setSiegeModeType(type)