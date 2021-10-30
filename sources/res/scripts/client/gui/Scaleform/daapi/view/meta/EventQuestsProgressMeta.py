from gui.Scaleform.framework.entities.View import View

class EventQuestsProgressMeta(View):

    def closeView(self):
        self._printOverrideError('closeView')

    def as_setDataS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_setData(data)