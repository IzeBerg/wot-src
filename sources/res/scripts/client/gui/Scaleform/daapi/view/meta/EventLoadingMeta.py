from gui.Scaleform.framework.entities.View import View

class EventLoadingMeta(View):

    def as_setDataS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_setData(data)

    def as_updateProgressS(self, percent):
        if self._isDAAPIInited():
            return self.flashObject.as_updateProgress(percent)