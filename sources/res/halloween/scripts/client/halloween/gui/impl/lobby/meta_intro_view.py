import typing
from account_helpers import AccountSettings
from frameworks.wulf import ViewFlags, ViewSettings, WindowFlags, WindowLayer
from gui.impl.gen import R
from gui.impl.pub.lobby_window import LobbyWindow
from gui.shared.view_helpers.blur_manager import CachedBlur
from halloween.gui.halloween_account_settings import AccountSettingsKeys
from halloween.gui.impl.gen.view_models.views.lobby.meta_intro_view_model import MetaIntroViewModel
from halloween.gui.impl.lobby.base_view import BaseView
from halloween.gui.sounds import playSound
from halloween.gui.sounds.sound_constants import META_INTRO_ENTER, META_INTRO_EXIT

class MetaIntroView(BaseView):
    __slots__ = ()
    layoutID = R.views.halloween.lobby.MetaIntroView()

    def __init__(self, layoutID=None):
        settings = ViewSettings(layoutID or self.layoutID, ViewFlags.VIEW, MetaIntroViewModel())
        super(MetaIntroView, self).__init__(settings)

    @property
    def viewModel(self):
        return super(MetaIntroView, self).getViewModel()

    def _initialize(self):
        super(MetaIntroView, self)._initialize()
        playSound(META_INTRO_ENTER)

    def _finalize(self):
        playSound(META_INTRO_EXIT)
        super(MetaIntroView, self)._finalize()

    def _subscribe(self):
        super(MetaIntroView, self)._subscribe()
        self.viewModel.onClose += self._onClose

    def _unsubscribe(self):
        super(MetaIntroView, self)._unsubscribe()
        self.viewModel.onClose -= self._onClose

    def _onClose(self):
        settings = AccountSettings.getSettings(AccountSettingsKeys.EVENT_KEY)
        settings[AccountSettingsKeys.META_INTRO_VIEW_SHOWED] = True
        AccountSettings.setSettings(AccountSettingsKeys.EVENT_KEY, settings)
        self.destroyWindow()


class MetaIntroWindow(LobbyWindow):

    def __init__(self, layoutID, parent=None):
        super(MetaIntroWindow, self).__init__(wndFlags=WindowFlags.WINDOW_FULLSCREEN, content=MetaIntroView(layoutID=layoutID), parent=parent, layer=WindowLayer.FULLSCREEN_WINDOW)
        self._blur = None
        self._blur = CachedBlur(enabled=True, ownLayer=self.layer - 1)
        return

    def _finalize(self):
        if self._blur:
            self._blur.fini()
        super(MetaIntroWindow, self)._finalize()