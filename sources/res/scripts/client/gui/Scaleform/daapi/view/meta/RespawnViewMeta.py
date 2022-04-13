from gui.Scaleform.framework.entities.BaseDAAPIComponent import BaseDAAPIComponent

class RespawnViewMeta(BaseDAAPIComponent):

    def as_updateAutoTimerS(self, mainTimer):
        if self._isDAAPIInited():
            return self.flashObject.as_updateAutoTimer(mainTimer)