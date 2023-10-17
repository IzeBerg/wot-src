from skeletons.gui.game_control import IGameController

class IDifficultyLevelController(IGameController):
    onChangeDifficultyLevelStatus = None
    onChangeDifficultyLevel = None

    def selectLevel(self, level):
        raise NotImplementedError

    def getSelectedLevel(self):
        raise NotImplementedError

    def getCurrentQueueType(self):
        raise NotImplementedError

    def getLevelsInfo(self):
        raise NotImplementedError