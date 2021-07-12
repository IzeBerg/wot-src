from gui.Scaleform.framework.entities.View import View

class EventProgressionBuyConfirmViewMeta(View):

    def onClose(self):
        self._printOverrideError('onClose')

    def onBuy(self):
        self._printOverrideError('onBuy')

    def onBack(self):
        self._printOverrideError('onBack')

    def as_setDataS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_setData(data)