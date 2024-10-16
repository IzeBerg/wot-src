from skeletons.gui.game_control import IGameController

class IHalloweenGlobalChatController(IGameController):

    def isEnabled(self):
        raise NotImplementedError