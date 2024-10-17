import WWISE
from frameworks.wulf import ViewSettings, WindowFlags
from gui.impl.gen import R
from gui.impl.lobby.common.tooltips.extended_text_tooltip import ExtendedTextTooltip
from halloween.gui.impl.gen.view_models.views.lobby.difficulty_window_view_model import DifficultyWindowViewModel
from halloween.gui.impl.lobby.base_view import BaseView, HWLobbyNotificationWindow
from halloween.gui.sounds import playSound
from halloween.gui.sounds.sound_constants import DifficultyWindowState, DIFFICULTY_SCREEN

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

    def createToolTipContent(self, event, contentID):
        if contentID == R.views.lobby.common.tooltips.ExtendedTextTooltip():
            text = event.getArgument('text', '')
            stringifyKwargs = event.getArgument('stringifyKwargs', '')
            return ExtendedTextTooltip(text, stringifyKwargs)
        return super(DifficultyWindowView, self).createToolTipContent(event, contentID)

    def _initialize(self, *args, **kwargs):
        super(DifficultyWindowView, self)._initialize()
        WWISE.WW_setState(DifficultyWindowState.GROUP, DifficultyWindowState.OPEN)
        soundKey = DIFFICULTY_SCREEN.get(self._difficultyLevel, None)
        if soundKey is not None:
            playSound(soundKey)
        return

    def _finalize(self):
        WWISE.WW_setState(DifficultyWindowState.GROUP, DifficultyWindowState.CLOSE)
        super(DifficultyWindowView, self)._finalize()

    def _onLoading(self):
        super(DifficultyWindowView, self)._onLoading()
        with self.viewModel.transaction() as (model):
            model.setLevel(self._difficultyLevel)

    def _subscribe(self):
        super(DifficultyWindowView, self)._subscribe()
        self.viewModel.onClose += self._onClose

    def _unsubscribe(self):
        super(DifficultyWindowView, self)._unsubscribe()
        self.viewModel.onClose -= self._onClose


class DifficultyWindow(HWLobbyNotificationWindow):

    def __init__(self, layoutID, difficultyLevel, parent=None):
        super(DifficultyWindow, self).__init__(wndFlags=WindowFlags.WINDOW_FULLSCREEN | WindowFlags.WINDOW, content=DifficultyWindowView(layoutID=layoutID, difficultyLevel=difficultyLevel), parent=parent)
        self._args = (
         layoutID, difficultyLevel)

    def isParamsEqual(self, *args):
        return self._args == args