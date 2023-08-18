from skeletons.gui.game_control import IGameController

class IVersusAIController(IGameController):

    def isEnabled(self):
        raise NotImplementedError