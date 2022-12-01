from ny_common.settings import CelebrityConsts
from typing import Optional, Dict, Set

class CelebrityConfig(object):
    __slots__ = ('_config', )

    def __init__(self, config):
        self._config = config

    def getQuestCount(self):
        return self._config.get(CelebrityConsts.QUEST_COUNT, 0)

    def getAdditionalQuests(self):
        quests = self._config.get(CelebrityConsts.ADDITIONAL_QUESTS, None)
        if quests is None:
            return
        else:
            return {key:AdditionalQuest(quest) for key, quest in quests.iteritems()}

    def getAdditionQuestByQuestData(self, questInfo):
        quests = self._config.get(CelebrityConsts.ADDITIONAL_QUESTS, None)
        if quests is None and questInfo not in quests:
            return
        else:
            return AdditionalQuest(quests[questInfo])


class AdditionalQuest(object):
    __slots__ = ('_quest', )

    def __init__(self, quest):
        self._quest = quest

    def getDependencies(self):
        dependencies = self._quest.get(CelebrityConsts.ADDITIONAL_QUEST_DEPENDENCIES, None)
        if dependencies is None:
            return
        else:
            return AdditionalQuestDependencies(dependencies)


class AdditionalQuestDependencies(object):
    __slots__ = ('_dependencies', )

    def __init__(self, dependencies):
        self._dependencies = dependencies

    def getTokensDependencies(self):
        return self._dependencies.get(CelebrityConsts.TOKENS_DEPENDENCY, None)