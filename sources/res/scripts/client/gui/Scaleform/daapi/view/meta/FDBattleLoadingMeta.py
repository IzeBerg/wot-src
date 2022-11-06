from gui.Scaleform.framework.entities.BaseDAAPIComponent import BaseDAAPIComponent

class FDBattleLoadingMeta(BaseDAAPIComponent):

    def as_setDataS(self, hint):
        if self._isDAAPIInited():
            return self.flashObject.as_setData(hint)

    def as_updateProgressS(self, percent):
        if self._isDAAPIInited():
            return self.flashObject.as_updateProgress(percent)