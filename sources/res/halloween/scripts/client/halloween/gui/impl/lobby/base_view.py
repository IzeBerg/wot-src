import typing
from frameworks.wulf import WindowLayer
from helpers import dependency
from gui.impl.lobby.common.view_mixins import LobbyHeaderVisibility
from gui.impl.pub import ViewImpl
from gui.impl.pub.lobby_window import LobbyWindow, LobbyNotificationWindow
from gui.prb_control.entities.listener import IGlobalListener
from gui.shared.view_helpers.blur_manager import CachedBlur
from halloween.skeletons.halloween_controller import IHalloweenController
from skeletons.gui.app_loader import IAppLoader

class BaseView(ViewImpl, LobbyHeaderVisibility, IGlobalListener):
    DESTROY_ON_EVENT_DISABLED = True
    _hwController = dependency.descriptor(IHalloweenController)

    def onPrbEntitySwitched(self):
        if not self._hwController.isAvailable():
            self._onClose()

    @property
    def isHiddenMenu(self):
        return True

    def _subscribe(self):
        super(BaseView, self)._subscribe()
        self._hwController.onEventDisabled += self._onEventDisabled

    def _unsubscribe(self):
        self._hwController.onEventDisabled -= self._onEventDisabled
        super(BaseView, self)._unsubscribe()

    def _onLoading(self, *args, **kwargs):
        super(BaseView, self)._onLoading(*args, **kwargs)
        self.startGlobalListening()

    def _onLoaded(self, *args, **kwargs):
        super(BaseView, self)._onLoaded(*args, **kwargs)
        if self.isHiddenMenu:
            self.suspendLobbyHeader(self.uniqueID)

    def _finalize(self):
        if self.isHiddenMenu:
            self.resumeLobbyHeader(self.uniqueID)
        self.stopGlobalListening()
        super(BaseView, self)._finalize()

    def _onEventDisabled(self):
        if not self._hwController.isAvailable():
            self._onClose()

    def _onClose(self):
        self.destroyWindow()


class HWLobbyWindow(LobbyWindow):
    __appLoader = dependency.descriptor(IAppLoader)

    def __init__(self, wndFlags, decorator=None, content=None, parent=None, layer=WindowLayer.UNDEFINED):
        super(HWLobbyWindow, self).__init__(wndFlags=wndFlags, decorator=decorator, content=content, parent=parent, layer=layer)
        self._blur = None
        return

    def _initialize(self):
        super(HWLobbyWindow, self)._initialize()
        self._blur = CachedBlur(enabled=True, ownLayer=self.layer - 1)
        containerManager = self.__appLoader.getApp().containerManager
        if containerManager:
            containerManager.onViewAddedToContainer += self.__onViewLoaded

    def __onViewLoaded(self, _, *args):
        self._blur.enable()

    def _finalize(self):
        if self._blur:
            self._blur.fini()
        containerManager = self.__appLoader.getApp().containerManager
        if containerManager:
            containerManager.onViewAddedToContainer -= self.__onViewLoaded
        super(HWLobbyWindow, self)._finalize()


class HWLobbyNotificationWindow(LobbyNotificationWindow):
    __appLoader = dependency.descriptor(IAppLoader)

    def __init__(self, wndFlags, decorator=None, content=None, parent=None, layer=WindowLayer.UNDEFINED):
        super(HWLobbyNotificationWindow, self).__init__(wndFlags=wndFlags, decorator=decorator, content=content, parent=parent, layer=layer)
        self._blur = None
        return

    def load(self):
        if self._blur is None:
            self._blur = CachedBlur(enabled=True, ownLayer=self.layer - 1)
        super(HWLobbyNotificationWindow, self).load()
        return

    def _initialize(self):
        super(HWLobbyNotificationWindow, self)._initialize()
        containerManager = self.__appLoader.getApp().containerManager
        if containerManager:
            containerManager.onViewAddedToContainer += self.__onViewLoaded

    def __onViewLoaded(self, _, *args):
        self._blur.enable()

    def _finalize(self):
        if self._blur:
            self._blur.fini()
        containerManager = self.__appLoader.getApp().containerManager
        if containerManager:
            containerManager.onViewAddedToContainer -= self.__onViewLoaded
        super(HWLobbyNotificationWindow, self)._finalize()