from gui.Scaleform.framework.entities.abstract.AbstractWindowView import AbstractWindowView

class ConfirmItemWindowMeta(AbstractWindowView):

    def submit(self, count, currency):
        self._printOverrideError('submit')

    def as_setDataS(self, value):
        if self._isDAAPIInited():
            return self.flashObject.as_setData(value)

    def as_setSettingsS(self, value):
        if self._isDAAPIInited():
            return self.flashObject.as_setSettings(value)