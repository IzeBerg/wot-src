from skeletons.gui.game_control import IGameController

class ICosmicFadingController(IGameController):

    def show(self):
        raise NotImplementedError

    def hide(self):
        raise NotImplementedError