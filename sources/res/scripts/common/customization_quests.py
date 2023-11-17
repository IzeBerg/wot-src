import itertools
from collections import namedtuple
from quest_cache_helpers import readQuestsFromFile
from quest_xml_source import collectSections
from constants import EVENT_TYPE
C11N_QUESTS_PROGRESSION_SOURCE_PATH = [
 'scripts/item_defs/customization/progression/quests']
CustomizationQuest = namedtuple('CustomizationQuest', ('questID', 'questName', 'questDescr',
                                                       'questClientData'))
g_cust_cache = None

def customizationQuestsFromFile(pathToFiles):
    quests = {}
    for pathToFile in pathToFiles:
        for quest in readQuestsFromFile(pathToFile, EVENT_TYPE.QUEST_USE_FOR_C11N_PROGRESS):
            questID, questName, questDescr, questClientData, _ = quest
            quests[questID] = CustomizationQuest(questID, questName, questDescr, questClientData)

    return quests


def init():
    global g_cust_cache
    if g_cust_cache is None:
        customizationQuestSectionList = list(itertools.chain.from_iterable(collectSections(path) for path in C11N_QUESTS_PROGRESSION_SOURCE_PATH))
        g_cust_cache = customizationQuestsFromFile(customizationQuestSectionList)
    return