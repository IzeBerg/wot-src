from gui.Scaleform.framework.entities.BaseDAAPIComponent import BaseDAAPIComponent

class EpicReinforcementPanelMeta(BaseDAAPIComponent):

    def as_setPlayerLivesS(self, lives):
        if self._isDAAPIInited():
            return self.flashObject.as_setPlayerLives(lives)

    def as_setTimestampS(self, timestamp, servertime):
        if self._isDAAPIInited():
            return self.flashObject.as_setTimestamp(timestamp, servertime)

    def as_setTimeS(self, time):
        if self._isDAAPIInited():
            return self.flashObject.as_setTime(time)