import logging
from functools import wraps
import BattleReplay, adisp
from frameworks.wulf import WindowLayer
from gui.shared import g_eventBus
from helpers import dependency
from story_mode.gui.shared.event import StoryModeViewReadyEvent
from story_mode.skeletons.story_mode_fading_controller import IStoryModeFadingController
from wg_async import wg_await, wg_async, BrokenPromiseError, await_callback, TimeoutError, forwardAsFuture, AsyncEvent
_logger = logging.getLogger(__name__)
WAIT_FOR_EVENT_TIMEOUT = 10

class UseStoryModeFading(object):
    __slots__ = ('_hide', '_show', '_layer', '_waitForLayoutReady')
    _fadeManager = dependency.descriptor(IStoryModeFadingController)

    def __init__(self, show=True, hide=True, layer=WindowLayer.OVERLAY, waitForLayoutReady=None):
        super(UseStoryModeFading, self).__init__()
        self._hide = hide
        self._show = show
        self._layer = layer
        self._waitForLayoutReady = waitForLayoutReady

    def __call__(self, func):

        @wraps(func)
        @wg_async
        def wrapper(*args, **kwargs):
            try:
                asyncEvent = AsyncEvent()

                def viewReadyHandler(event):
                    if event.viewID == self._waitForLayoutReady:
                        asyncEvent.set()

                if self._waitForLayoutReady is None:
                    asyncEvent.set()
                else:
                    g_eventBus.addListener(StoryModeViewReadyEvent.VIEW_READY, viewReadyHandler)
                if not BattleReplay.isPlaying() and self._show:
                    yield wg_await(self._fadeManager.show(self._layer))
                if adisp.isAsync(func):
                    yield await_callback(func)(*args, **kwargs)
                else:
                    yield wg_await(forwardAsFuture(func(*args, **kwargs)))
                yield wg_await(asyncEvent.wait(), WAIT_FOR_EVENT_TIMEOUT)
                g_eventBus.removeListener(StoryModeViewReadyEvent.VIEW_READY, viewReadyHandler)
                if not BattleReplay.isPlaying() and self._hide:
                    yield wg_await(self._fadeManager.hide(self._layer))
            except BrokenPromiseError:
                _logger.debug('%s got BrokenPromiseError during the fade-in/fade-out animation.', func)
            except TimeoutError:
                _logger.error('Got time-out during the fade-in/fade-out animation.')

            return

        return wrapper