from gui.Scaleform.framework.entities.View import View

class HBLoadingMeta(View):

    def as_setDataS(self, hints):
        if self._isDAAPIInited():
            return self.flashObject.as_setData(hints)

    def as_updateProgressS(self, percent):
        if self._isDAAPIInited():
            return self.flashObject.as_updateProgress(percent)

    def as_loadedS(self):
        if self._isDAAPIInited():
            return self.flashObject.as_loaded()