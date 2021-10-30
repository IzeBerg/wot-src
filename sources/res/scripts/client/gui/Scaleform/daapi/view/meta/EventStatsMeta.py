from gui.Scaleform.framework.entities.BaseDAAPIComponent import BaseDAAPIComponent

class EventStatsMeta(BaseDAAPIComponent):

    def as_updatePlayerStatsS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_updatePlayerStats(data)

    def as_updateDataS(self, title, desc, difficulty, goal):
        if self._isDAAPIInited():
            return self.flashObject.as_updateData(title, desc, difficulty, goal)

    def as_updateBuffsS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_updateBuffs(data)