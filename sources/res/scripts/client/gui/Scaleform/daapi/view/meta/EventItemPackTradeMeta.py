from gui.Scaleform.framework.entities.View import View

class EventItemPackTradeMeta(View):

    def closeView(self):
        self._printOverrideError('closeView')

    def backView(self):
        self._printOverrideError('backView')

    def onButtonPaymentSetPanelClick(self, count):
        self._printOverrideError('onButtonPaymentSetPanelClick')

    def as_setDataS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_setData(data)