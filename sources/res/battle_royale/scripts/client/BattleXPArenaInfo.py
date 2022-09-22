import BigWorld

class BattleXPArenaInfo(BigWorld.DynamicScriptComponent):

    def __init__(self):
        self.__setAverageLevel()

    def set_vehiclesAverageBattleLevel(self, _):
        self.__setAverageLevel()

    def __setAverageLevel(self):
        progressionCtrl = self.entity.sessionProvider.dynamic.progression
        if progressionCtrl is not None:
            progressionCtrl.setAverageBattleLevel(self.vehiclesAverageBattleLevel)
        return