from gui.Scaleform.framework.entities.BaseDAAPIComponent import BaseDAAPIComponent

class EventStatsMeta(BaseDAAPIComponent):

    def as_updatePlayerStatsS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_updatePlayerStats(data)

    def as_updateTitleS(self, title, desc):
        if self._isDAAPIInited():
            return self.flashObject.as_updateTitle(title, desc)