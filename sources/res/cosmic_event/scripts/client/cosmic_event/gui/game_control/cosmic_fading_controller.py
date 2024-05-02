from gui.impl.common.fade_manager import FadeManager, DefaultFadingCover
from cosmic_event.skeletons.cosmic_fading_controller import ICosmicFadingController
from cosmic_constants import COSMIC_FADE_OUT_DURATION, COSMIC_FADE_IN_DURATION
from wg_async import wg_await, wg_async
from frameworks.wulf import WindowLayer

class CosmicFadingCover(DefaultFadingCover):

    def __init__(self):
        super(CosmicFadingCover, self).__init__(fadeInDuration=COSMIC_FADE_IN_DURATION, fadeOutDuration=COSMIC_FADE_OUT_DURATION)


class CosmicFadingController(ICosmicFadingController):

    def __init__(self):
        super(CosmicFadingController, self).__init__()
        self._fadingLayer = FadeManager(layer=WindowLayer.TOP_SUB_VIEW, coverFactory=CosmicFadingCover)

    def fini(self):
        if self._fadingLayer:
            self._hideImmediately()
        self._fadingLayer = None
        super(CosmicFadingController, self).fini()
        return

    @wg_async
    def show(self):
        if not self._fadingLayer.isAnimating:
            yield wg_await(self._fadingLayer.show())

    @wg_async
    def hide(self):
        if self._fadingLayer.isAnimating:
            yield wg_await(self._fadingLayer.hide())

    def onDisconnected(self):
        self._hideImmediately()

    def onAvatarBecomePlayer(self):
        self._hideImmediately()

    def onAccountBecomePlayer(self):
        self._hideImmediately()

    def _hideImmediately(self):
        self._fadingLayer.hideImmediately()