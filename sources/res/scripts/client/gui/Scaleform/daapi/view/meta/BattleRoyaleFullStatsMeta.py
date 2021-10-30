from gui.Scaleform.framework.entities.BaseDAAPIComponent import BaseDAAPIComponent

class BattleRoyaleFullStatsMeta(BaseDAAPIComponent):

    def as_setDataS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_setData(data)

    def as_updateScoreS(self, alive, destroyed, squads):
        if self._isDAAPIInited():
            return self.flashObject.as_updateScore(alive, destroyed, squads)

    def as_updateNationsVehiclesCounterS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_updateNationsVehiclesCounter(data)