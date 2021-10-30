import logging
from weakref import proxy
from Event import Event, EventManager
from helpers import dependency
from skeletons.gui.server_events import IEventsCache
from skeletons.account_helpers.settings_core import ISettingsCore
from helpers.CallbackDelayer import CallbackDelayer
from gui.shared.money import Currency
from gui.server_events.conditions import getTokenNeededCountInCondition, getTokenReceivedCountInCondition
_logger = logging.getLogger(__name__)
_BONUS_ORDER = (
 Currency.CREDITS,
 Currency.GOLD,
 Currency.CRYSTAL,
 'creditsFactor',
 'freeXP',
 'freeXPFactor',
 'tankmenXP',
 'tankmenXPFactor',
 'xp',
 'xpFactor',
 'dailyXPFactor',
 'items')
_DEFAULT_BONUS_ORDER = len(_BONUS_ORDER)

class GameEventProgress(CallbackDelayer):
    eventsCache = dependency.descriptor(IEventsCache)
    settingsCore = dependency.descriptor(ISettingsCore)
    _CALLBACK_OFFSET = 2.0

    def __init__(self, questGroupPrefix, questGroupProgressPrefix, questFinalRewardGroupPrefix, questBonusGroupSuffix, maxLevelBoughtTokenName):
        super(GameEventProgress, self).__init__()
        self._items = None
        self._questGroupPrefix = questGroupPrefix
        self._questGroupProgressPrefix = questGroupProgressPrefix
        self._questBonusGroupSuffix = questBonusGroupSuffix
        self._maxLevelBoughtTokenName = maxLevelBoughtTokenName
        self._questFinalRewardGroupPrefix = questFinalRewardGroupPrefix
        self.__em = EventManager()
        self.onItemsUpdated = Event(self.__em)
        return

    def init(self):
        self._items = [self._createProgressItemEmpty()]
        self.eventsCache.onSyncCompleted += self._onSyncCompleted
        self._onSyncCompleted()

    def fini(self):
        self._items = None
        self.eventsCache.onSyncCompleted -= self._onSyncCompleted
        self.__em.clear()
        self.destroy()
        return

    def getItems(self):
        return self._items

    def getQuestGroupPrefix(self):
        return self._questGroupPrefix

    def getQuestBonusGroupSuffix(self):
        return self._questBonusGroupSuffix

    def isCompleted(self):
        return self.isMaxLevelBought() or len(self._items) > 1 and all(item.isCompleted() for item in self._items)

    def isMaxLevelBought(self):
        return bool(self.eventsCache.questsProgress.getTokenCount(self._maxLevelBoughtTokenName))

    def getCurrentProgressItem(self):
        return next((item for item in reversed(self._items) if item.isCompleted() or self.isMaxLevelBought()), None)

    def getProgressLeftToNextLevel(self):
        item = self.getCurrentProgressItem()
        if item.getLevel() == self.getMaxLevel():
            return 0
        nextLevel = self._items[(item.getLevel() + 1)]
        if nextLevel.isAvailable():
            return nextLevel.getMaxProgress() - nextLevel.getCurrentProgress()
        return 0

    def getNextProgressItem(self):
        item = self.getCurrentProgressItem()
        if item.getLevel() == self.getMaxLevel():
            return None
        else:
            return self._items[(item.getLevel() + 1)]

    def getCurrentProgressLevel(self):
        currentLevel = self.getCurrentProgressItem()
        if currentLevel:
            return currentLevel.getLevel()
        return 0

    def getCurrentProgress(self):
        res = 0
        for item in self._items:
            if item.isCompleted():
                res += item.getMaxProgress()
            elif item.isAvailable():
                res += item.getCurrentProgress()
                res += item.getBonusCount() * item.getMaxProgress()
            else:
                break

        return res

    def getTotalProgressForLevel(self, level):
        res = 0
        for itemID in xrange(level + 1):
            item = self._items[itemID]
            if item.isCompleted():
                res += item.getMaxProgress()
            elif item.isAvailable():
                res += (item.getBonusCount() + 1) * item.getMaxProgress()
            else:
                break

        return res

    def getProgressForLevel(self, level, bonusCount):
        res = 0
        for itemID in xrange(level + 1):
            item = self._items[itemID]
            if item.isCompleted():
                res += item.getMaxProgress()
            elif item.isAvailable():
                res += bonusCount * item.getMaxProgress()
            else:
                break

        return res

    def getTotalProgress(self):
        item = self.getNextProgressItem()
        if item is None:
            item = self.getCurrentProgressItem()
        return self.getTotalProgressForLevel(item.getLevel())

    def isMaxLevelBuyEnabled(self):
        return self.eventsCache.isEventEnabled()

    def getMaxProgressItem(self):
        if self._items:
            return self._items[(-1)]
        else:
            return

    def getCurrentMaxProgressLevel(self):
        return next((item.getLevel() for item in reversed(self._items) if item.isUnlocked()), 0)

    def getMaxLevel(self):
        return len(self._items) - 1

    def getStartTime(self):
        if len(self._items) > 1:
            return self._items[1].getStartTime()
        return 0

    def getLastQuestStartTime(self):
        if self._items:
            return self._items[(-1)].getStartTime()
        return 0

    def getFinishTime(self):
        if self._items:
            return self._items[(-1)].getFinishTime()
        return 0

    def getFinishTimeLeft(self):
        if self._items:
            return self._items[(-1)].getFinishTimeLeft()
        return 0

    def getFirstLockItem(self):
        return next((item for item in self._items if not item.isUnlocked()), None)

    def getProgressTokenName(self):
        raise NotImplementedError

    def _onSyncCompleted(self):
        if self._items is None:
            return
        else:
            quests = sorted([ q for q in self.eventsCache.getHiddenQuests().itervalues() if self._isMyProgressQuest(q)
                            ], key=GameEventProgressItem.getLevelFromQuest)
            if len(self._items) > len(quests) + 1:
                self._items = self._items[:len(quests) + 1]
            self._items[0].setQuest(None)
            for index, quest in enumerate(quests, start=1):
                if index >= len(self._items):
                    self._items.append(self._createProgressItem(quest))
                else:
                    self._items[index].setQuest(quest)

            self.onItemsUpdated()
            self.stopCallback(self._onSyncCompletedCallback)
            lockItem = self.getFirstLockItem()
            if lockItem:
                self.delayCallback(lockItem.getStartTimeLeft() + self._CALLBACK_OFFSET, self._onSyncCompletedCallback)
            return

    def _onSyncCompletedCallback(self):
        self._onSyncCompleted()

    def _isMyProgressQuest(self, quest):
        groupID = quest.getGroupID()
        return groupID and groupID.startswith(self._questGroupPrefix) and groupID.endswith(self._questGroupProgressPrefix)

    def _getGameEventServerSetting(self, key, default=None):
        value = self.settingsCore.serverSettings.getGameEventStorage().get(key)
        return value or default

    def _createProgressItem(self, quest):
        return GameEventProgressItem(self, quest)

    def _createProgressItemEmpty(self):
        return GameEventProgressItemEmpty(self)


class GameEventProgressItem(object):
    eventsCache = dependency.descriptor(IEventsCache)

    def __init__(self, progressController, quest):
        super(GameEventProgressItem, self).__init__()
        self._progressController = proxy(progressController)
        self._quest = quest

    def getQuest(self):
        return self._quest

    def setQuest(self, quest):
        self._quest = quest

    def getLevel(self):
        return self.getLevelFromQuest(self._quest)

    @staticmethod
    def getLevelFromQuest(quest):
        return int(quest.getID().split('_')[(-1)])

    def isAvailable(self):
        if not self._quest.isAvailable().isValid:
            return False
        return self._progressController.getCurrentProgressLevel() == self.getLevel() - 1

    def isCompleted(self):
        return self._quest.isCompleted()

    def isUnlocked(self):
        return self.getStartTimeLeft() <= 0

    def getCurrentProgress(self):
        maxProgress = self.getMaxProgress()
        if self.isCompleted():
            return maxProgress
        if self.isAvailable():
            return min(getTokenReceivedCountInCondition(self._quest, self._progressController.getProgressTokenName(), default=0), maxProgress)
        return 0

    def getMaxProgress(self):
        return getTokenNeededCountInCondition(self._quest, self._progressController.getProgressTokenName(), default=0)

    def getStartTime(self):
        return self._quest.getStartTime()

    def getStartTimeLeft(self):
        return self._quest.getStartTimeLeft()

    def getFinishTimeLeft(self):
        return self._quest.getFinishTimeLeft()

    def getFinishTime(self):
        return self._quest.getFinishTime()

    def getBonuses(self):
        return sorted(self._quest.getBonuses(), key=self._getBonusPriority)

    def getActiveBonuses(self):
        bonuses = []
        bonusQuest = self.getCorrespondBonusQuest()
        if bonusQuest:
            bonuses.extend(bonusQuest.getBonuses())
        return sorted(bonuses, key=self._getBonusPriority)

    def isBonusQuestCompleted(self):
        bonusQuest = self.getCorrespondBonusQuest()
        if bonusQuest is None:
            return False
        else:
            return bonusQuest.isCompleted()

    def getBonusCount(self):
        return self._quest.getBonusCount()

    def _getBonusPriority(self, bonus):
        if bonus.getName() in _BONUS_ORDER:
            return _BONUS_ORDER.index(bonus.getName())
        return _DEFAULT_BONUS_ORDER

    def getCorrespondBonusQuest(self):
        return next((q for q in self.eventsCache.getHiddenQuests().itervalues() if self._isMyBonusQuest(q)), None)

    def _isMyBonusQuest(self, quest):
        groupID = quest.getGroupID()
        if not groupID:
            return False
        if not (groupID.startswith(self._progressController.getQuestGroupPrefix()) and groupID.endswith(self._progressController.getQuestBonusGroupSuffix())):
            return False
        return self._getLevelFromBonusQuest(quest) == self.getLevel()

    def _getLevelFromBonusQuest(self, quest):
        return int(quest.getID().split('_')[(-1)])


class GameEventProgressItemEmpty(GameEventProgressItem):

    def __init__(self, progressController):
        super(GameEventProgressItemEmpty, self).__init__(progressController, None)
        return

    def getLevel(self):
        return 0

    def isAvailable(self):
        return True

    def isCompleted(self):
        return True

    def getMaxProgress(self):
        return 0

    def isUnlocked(self):
        return True

    def getStartTimeLeft(self):
        return 0

    def getFinishTimeLeft(self):
        return 0

    def getFinishTime(self):
        return 0

    def getStartTime(self):
        return 0

    def getBonuses(self):
        return []

    def getBonusCount(self):
        return 1