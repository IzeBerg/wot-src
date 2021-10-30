from gui.Scaleform.framework.entities.View import View

class EventItemsTradeMeta(View):

    def closeView(self):
        self._printOverrideError('closeView')

    def backView(self):
        self._printOverrideError('backView')

    def onButtonPaymentPanelClick(self, count):
        self._printOverrideError('onButtonPaymentPanelClick')

    def as_setDataS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_setData(data)

    def as_updateTokensS(self, value):
        if self._isDAAPIInited():
            return self.flashObject.as_updateTokens(value)