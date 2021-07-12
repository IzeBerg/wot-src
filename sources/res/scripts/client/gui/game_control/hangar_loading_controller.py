import Event
from helpers import dependency
from skeletons.gui.game_control import IHangarLoadingController, IBootcampController
from skeletons.gui.shared.utils import IHangarSpace

class HangarLoadingController(IHangarLoadingController):
    __bootcamp = dependency.descriptor(IBootcampController)
    __hangarSpace = dependency.descriptor(IHangarSpace)

    def __init__(self):
        super(HangarLoadingController, self).__init__()
        self.onHangarLoadedAfterLogin = Event.Event()
        self.__isConnectedAsAccount = False

    def fini(self):
        self.__isConnectedAsAccount = False
        self.__hangarSpace.onSpaceCreate -= self.__hangarLoadedAfterLoginNotify

    def onAvatarBecomePlayer(self):
        self.__isConnectedAsAccount = False

    def onConnected(self):
        self.__isConnectedAsAccount = True

    def onAccountBecomeNonPlayer(self):
        self.__isConnectedAsAccount = False
        self.__hangarSpace.onSpaceCreate -= self.__hangarLoadedAfterLoginNotify

    def onDisconnected(self):
        self.__isConnectedAsAccount = False
        self.__hangarSpace.onSpaceCreate -= self.__hangarLoadedAfterLoginNotify

    def onLobbyInited(self, event):
        if self.__isHangarLoadedAfterLogin():
            if self.__hangarSpace.spaceInited:
                self.__hangarLoadedAfterLoginNotify()
            else:
                self.__hangarSpace.onSpaceCreate += self.__hangarLoadedAfterLoginNotify

    def __hangarLoadedAfterLoginNotify(self):
        self.__hangarSpace.onSpaceCreate -= self.__hangarLoadedAfterLoginNotify
        self.onHangarLoadedAfterLogin()

    def __isHangarLoadedAfterLogin(self):
        return self.__isConnectedAsAccount and not self.__bootcamp.isInBootcamp() and not self.__bootcamp.isInBootcampAccount()