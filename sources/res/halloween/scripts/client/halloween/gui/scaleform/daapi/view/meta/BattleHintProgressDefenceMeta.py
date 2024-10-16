from gui.Scaleform.framework.entities.BaseDAAPIComponent import BaseDAAPIComponent

class BattleHintProgressDefenceMeta(BaseDAAPIComponent):

    def as_updateProgressS(self, value, progressValue, pointsLeft):
        if self._isDAAPIInited():
            return self.flashObject.as_updateProgress(value, progressValue, pointsLeft)

    def as_updateHealthPointsS(self, nextWavePoints):
        if self._isDAAPIInited():
            return self.flashObject.as_updateHealthPoints(nextWavePoints)

    def as_updateVehiclesS(self, vehicles):
        if self._isDAAPIInited():
            return self.flashObject.as_updateVehicles(vehicles)