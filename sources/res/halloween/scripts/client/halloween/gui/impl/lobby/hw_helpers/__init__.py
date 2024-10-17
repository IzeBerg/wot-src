from functools import wraps
from BWUtil import AsyncReturn
from halloween.skeletons.halloween_controller import IHalloweenController
from halloween_common.halloween_constants import KEY_DAILY_QUEST_TPL
from helpers import dependency
from skeletons.gui.server_events import IEventsCache
from wg_async import wg_await, wg_async, forwardAsFuture

@dependency.replace_none_kwargs(eventsCache=IEventsCache)
def isDailyKeyQuestCompleted(intCD, eventsCache=None):
    quest = eventsCache.getAllQuests().get(KEY_DAILY_QUEST_TPL.format(intCD=intCD))
    if quest:
        return quest.isCompleted()
    return True


@dependency.replace_none_kwargs(eventsCache=IEventsCache)
def getDailyKeyQuestDescription(intCD, eventsCache=None):
    quest = eventsCache.getAllQuests().get(KEY_DAILY_QUEST_TPL.format(intCD=intCD))
    if quest:
        return quest.getDescription()
    return ''


@dependency.replace_none_kwargs(hwCtrl=IHalloweenController)
def isCustomizationHangarDisabled(hwCtrl=None):
    return hwCtrl.isEventHangar()


class UseHeaderNavigationImpossible(object):
    __slots__ = ('_hide', '_show', '_confirmationHelper')

    def __init__(self, confirmationHelper, show=True, hide=True):
        super(UseHeaderNavigationImpossible, self).__init__()
        self._hide = hide
        self._show = show
        self._confirmationHelper = confirmationHelper

    def __call__(self, func):

        @wraps(func)
        @wg_async
        def wrapper(*args, **kwargs):

            @wg_async
            def confirmation():
                raise AsyncReturn(False)

            if self._show:
                self._confirmationHelper.start(confirmation)
            yield wg_await(forwardAsFuture(func(*args, **kwargs)))
            if self._hide:
                self._confirmationHelper.stop()

        return wrapper