from skeletons.gui.game_control import IGameController

class IWTEventNotifications(IGameController):

    def init(self):
        raise NotImplementedError

    def fini(self):
        raise NotImplementedError