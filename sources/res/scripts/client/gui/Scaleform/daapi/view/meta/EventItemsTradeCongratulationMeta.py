from gui.Scaleform.framework.entities.View import View

class EventItemsTradeCongratulationMeta(View):

    def closeView(self):
        self._printOverrideError('closeView')

    def onButtonConfirmationClick(self):
        self._printOverrideError('onButtonConfirmationClick')

    def as_setDataS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_setData(data)