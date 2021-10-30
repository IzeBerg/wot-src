from gui.Scaleform.framework.entities.BaseDAAPIComponent import BaseDAAPIComponent

class DebugPanelMeta(BaseDAAPIComponent):

    def as_updatePingInfoS(self, pingValue):
        if self._isDAAPIInited():
            return self.flashObject.as_updatePingInfo(pingValue)

    def as_updateFPSInfoS(self, fpsValue):
        if self._isDAAPIInited():
            return self.flashObject.as_updateFPSInfo(fpsValue)

    def as_updateLagInfoS(self, isLagging):
        if self._isDAAPIInited():
            return self.flashObject.as_updateLagInfo(isLagging)

    def as_updatePingFPSInfoS(self, pingValue, fpsValue):
        if self._isDAAPIInited():
            return self.flashObject.as_updatePingFPSInfo(pingValue, fpsValue)

    def as_updatePingFPSLagInfoS(self, pingValue, fpsValue, isLagging):
        if self._isDAAPIInited():
            return self.flashObject.as_updatePingFPSLagInfo(pingValue, fpsValue, isLagging)