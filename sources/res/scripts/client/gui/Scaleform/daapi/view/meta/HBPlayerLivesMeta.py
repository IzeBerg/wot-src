from gui.Scaleform.framework.entities.BaseDAAPIComponent import BaseDAAPIComponent

class HBPlayerLivesMeta(BaseDAAPIComponent):

    def as_setCountLivesS(self, count, dead, locked):
        if self._isDAAPIInited():
            return self.flashObject.as_setCountLives(count, dead, locked)