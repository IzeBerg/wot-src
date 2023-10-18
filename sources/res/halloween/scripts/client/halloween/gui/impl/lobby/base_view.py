from gui.Scaleform.daapi.view.lobby.header.LobbyHeader import HeaderMenuVisibilityState
from gui.impl.pub import ViewImpl
from gui.impl.pub.selectable_view_impl import notifyCursorOver3DScene
from gui.prb_control.entities.listener import IGlobalListener
from halloween.gui.impl.lobby import updateHeaderMenu
from halloween.skeletons.halloween_controller import IHalloweenController
from helpers import dependency

class BaseView(ViewImpl, IGlobalListener):
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
            updateHeaderMenu(HeaderMenuVisibilityState.NOTHING)
        notifyCursorOver3DScene(False)

    def _finalize(self):
        if self.isHiddenMenu:
            updateHeaderMenu(HeaderMenuVisibilityState.ALL)
        self.stopGlobalListening()
        super(BaseView, self)._finalize()

    def _onEventDisabled(self):
        if not self._hwController.isAvailable():
            self._onClose()

    def _onClose(self):
        self.destroyWindow()