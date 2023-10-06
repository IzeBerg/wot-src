from gui.Scaleform.framework.entities.BaseDAAPIComponent import BaseDAAPIComponent

class BattleRoyaleTimersPanelMeta(BaseDAAPIComponent):

    def as_setIsReplayS(self, value):
        if self._isDAAPIInited():
            return self.flashObject.as_setIsReplay(value)

    def as_setRespawnTimeS(self, time):
        if self._isDAAPIInited():
            return self.flashObject.as_setRespawnTime(time)

    def as_setAirDropTimeS(self, time):
        if self._isDAAPIInited():
            return self.flashObject.as_setAirDropTime(time)