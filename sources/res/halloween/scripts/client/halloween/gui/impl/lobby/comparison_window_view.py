import typing
from frameworks.wulf import ViewSettings, WindowFlags, ViewModel
from gui.impl.gen import R
from gui.impl.lobby.common.tooltips.extended_text_tooltip import ExtendedTextTooltip
from gui.impl.pub.lobby_window import LobbyWindow
from gui.shared.view_helpers.blur_manager import CachedBlur
from halloween.gui.impl.lobby.base_view import BaseView
from halloween.gui.sounds import playSound
from halloween.gui.sounds.sound_constants import COMPARISON_VIEW_ENTER, COMPARISON_VIEW_EXIT

class ComparisonWindowView(BaseView):
    __slots__ = ()
    layoutID = R.views.halloween.lobby.ComparisonWindowView()

    def __init__(self, layoutID=None):
        settings = ViewSettings(layoutID or self.layoutID, model=ViewModel())
        super(ComparisonWindowView, self).__init__(settings)

    def createToolTipContent(self, event, contentID):
        if contentID == R.views.lobby.common.tooltips.ExtendedTextTooltip():
            text = event.getArgument('text', '')
            stringifyKwargs = event.getArgument('stringifyKwargs', '')
            return ExtendedTextTooltip(text, stringifyKwargs)
        return super(ComparisonWindowView, self).createToolTipContent(event, contentID)

    def _initialize(self, *args, **kwargs):
        super(ComparisonWindowView, self)._initialize()
        playSound(COMPARISON_VIEW_ENTER)


class ComparisonWindow(LobbyWindow):

    def __init__(self, layoutID, parent=None):
        super(ComparisonWindow, self).__init__(wndFlags=WindowFlags.WINDOW_FULLSCREEN | WindowFlags.WINDOW, content=ComparisonWindowView(layoutID=layoutID), parent=parent)
        self._blur = None
        self._blur = CachedBlur(enabled=True, ownLayer=self.layer - 1)
        return

    def _finalize(self):
        if self._blur:
            self._blur.fini()
        playSound(COMPARISON_VIEW_EXIT)
        super(ComparisonWindow, self)._finalize()