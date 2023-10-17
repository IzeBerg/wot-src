from halloween.skeletons.halloween_controller import IHalloweenController
from halloween_common.halloween_constants import KEY_DAILY_QUEST_TPL
from helpers import dependency
from skeletons.gui.server_events import IEventsCache

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