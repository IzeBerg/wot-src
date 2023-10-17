import typing
from frameworks.wulf import ViewSettings, WindowFlags
from gui.impl.gen import R
from gui.impl.pub.lobby_window import LobbyNotificationWindow
from gui.shared.view_helpers.blur_manager import CachedBlur
from halloween.gui.impl.gen.view_models.views.lobby.difficulty_window_view_model import DifficultyWindowViewModel
from halloween.gui.impl.lobby.base_view import BaseView
from halloween.gui.sounds import playSound
from halloween.gui.sounds.sound_constants import DIFFICULTY_WINDOW_OPEN

class DifficultyWindowView(BaseView):
    __slots__ = ()
    layoutID = R.views.halloween.lobby.DifficultyWindowView()

    def __init__(self, layoutID=None, difficultyLevel=None):
        settings = ViewSettings(layoutID or self.layoutID, model=DifficultyWindowViewModel())
        self._difficultyLevel = difficultyLevel
        super(DifficultyWindowView, self).__init__(settings)

    @property
    def viewModel(self):
        return super(DifficultyWindowView, self).getViewModel()

    def _initialize(self, *args, **kwargs):
        super(DifficultyWindowView, self)._initialize()
        playSound(DIFFICULTY_WINDOW_OPEN)

    def _onLoading(self):
        super(DifficultyWindowView, self)._onLoading()
        with self.viewModel.transaction() as (model):
            model.setWindowType(self._difficultyLevel)

    def _subscribe(self):
        super(DifficultyWindowView, self)._subscribe()
        self.viewModel.onClose += self._onClose

    def _unsubscribe(self):
        super(DifficultyWindowView, self)._unsubscribe()
        self.viewModel.onClose -= self._onClose


class DifficultyWindow(LobbyNotificationWindow):

    def __init__(self, layoutID, difficultyLevel, parent=None):
        super(DifficultyWindow, self).__init__(wndFlags=WindowFlags.WINDOW_FULLSCREEN | WindowFlags.WINDOW, content=DifficultyWindowView(layoutID=layoutID, difficultyLevel=difficultyLevel), parent=parent)
        self._blur = None
        self._args = (layoutID, difficultyLevel)
        return

    def load(self):
        if self._blur is None:
            self._blur = CachedBlur(enabled=True, ownLayer=self.layer - 1)
        super(DifficultyWindow, self).load()
        return

    def _finalize(self):
        if self._blur is not None:
            self._blur.fini()
            self._blur = None
        super(DifficultyWindow, self)._finalize()
        return

    def isParamsEqual(self, *args):
        return self._args == args