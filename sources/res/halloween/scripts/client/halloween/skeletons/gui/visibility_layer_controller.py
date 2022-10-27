from skeletons.gui.game_control import IGameController

class IHalloweenVisibilityLayerController(IGameController):
    onChangeVisibilityMask = None

    def changeVisibilityMask(self, phaseIndex):
        raise NotImplementedError