from gui.Scaleform.framework.entities.abstract.AbstractWindowView import AbstractWindowView

class UseAwardSheetWindowMeta(AbstractWindowView):

    def accept(self):
        self._printOverrideError('accept')

    def cancel(self):
        self._printOverrideError('cancel')

    def as_setSettingsS(self, value):
        if self._isDAAPIInited():
            return self.flashObject.as_setSettings(value)

    def as_setDataS(self, value):
        if self._isDAAPIInited():
            return self.flashObject.as_setData(value)