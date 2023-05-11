from gui.Scaleform.framework.entities.BaseDAAPIComponent import BaseDAAPIComponent

class VehiclePreviewBottomPanelShowcaseStyleBuyingMeta(BaseDAAPIComponent):

    def onBuyClick(self):
        self._printOverrideError('onBuyClick')

    def as_setDataS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_setData(data)

    def as_updateTimeRemainingS(self, value):
        if self._isDAAPIInited():
            return self.flashObject.as_updateTimeRemaining(value)

    def as_setBuyingTimeElapsedS(self, value):
        if self._isDAAPIInited():
            return self.flashObject.as_setBuyingTimeElapsed(value)