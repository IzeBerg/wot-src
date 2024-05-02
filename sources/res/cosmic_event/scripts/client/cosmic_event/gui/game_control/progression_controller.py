import logging
from collections import OrderedDict
import typing, re, Event
from PlayerEvents import g_playerEvents
from cosmic_event.gui.impl.gen.view_models.views.lobby.cosmic_lobby_view.cosmic_lobby_view_model import LobbyRouteEnum
from cosmic_event.skeletons.battle_controller import ICosmicEventBattleController
from cosmic_event.skeletons.progression_controller import ICosmicEventProgressionController
from helpers import dependency
from skeletons.gui.lobby_context import ILobbyContext
from skeletons.gui.server_events import IEventsCache
from gui.server_events.event_items import Quest
from skeletons.gui.shared import IItemsCache
if typing.TYPE_CHECKING:
    from typing import Dict, Tuple, List, Union, Optional
    from gui.server_events.bonuses import SimpleBonus
_logger = logging.getLogger(__name__)
QUEST_STEP_REGEX = re.compile('cosmic_event:step_([0-9]{1,2})')
ACHIEVEMENT_STEP_REGEX = re.compile('cosmic_event:achievements_(\\d)')

class CosmicProgressionController(ICosmicEventProgressionController):
    eventsCache = dependency.descriptor(IEventsCache)
    cosmicBattleController = dependency.descriptor(ICosmicEventBattleController)
    itemsCache = dependency.descriptor(IItemsCache)
    PROGRESSION_ROUTE = (
     LobbyRouteEnum.KIRK,
     LobbyRouteEnum.SPOCK,
     LobbyRouteEnum.UHURA)

    def __init__(self):
        super(CosmicProgressionController, self).__init__()
        self._quests = None
        self._lastSeenPoints = None
        self.onProgressPointsUpdated = Event.Event()
        return

    @property
    def quests(self):
        if self._quests is None:
            self._quests = self.collectSortedQuests()
        return self._quests

    def init(self):
        super(CosmicProgressionController, self).init()
        g_playerEvents.onClientUpdated += self._onTokensUpdate

    def fini(self):
        lobbyContext = dependency.instance(ILobbyContext)
        lobbyContext.getServerSettings().onServerSettingsChange -= self._onSettingsChanged
        g_playerEvents.onClientUpdated -= self._onTokensUpdate

    def onLobbyInited(self, event):
        lobbyContext = dependency.instance(ILobbyContext)
        lobbyContext.getServerSettings().onServerSettingsChange += self._onSettingsChanged
        self.eventsCache.questsProgress.addFilterFunc(self._filterFunc)

    def onAccountBecomePlayer(self):
        self._quests = None
        return

    def onAvatarBecomePlayer(self):
        if self._lastSeenPoints is None:
            self._lastSeenPoints = self.getCurrentPoints()
        return

    def getQuests(self):
        progressionGroupID = self.cosmicBattleController.getProgressionQuestGroupId()
        return self.eventsCache.getHiddenQuests(lambda q: q.getGroupID() == progressionGroupID)

    def getDailyQuests(self):
        return self.eventsCache.getHiddenBattleQuests(self._filterFunc)

    def getMaxProgressionPoints(self):
        if self.quests:
            lastQuest = self.quests.values()[(-1)]
            return self._getNeededPointsCount(lastQuest)
        return 0

    def getCurrentPoints(self):
        tokenID = self.cosmicBattleController.getTokenProgressionID()
        if tokenID:
            return self.eventsCache.questsProgress.getTokenCount(tokenID)
        return 0

    def getProgression(self):
        return (
         self.getCurrentPoints(), self.getMaxProgressionPoints())

    def getStageProgress(self):
        quests = self.getQuests()
        maxStage = len(quests)
        completedCount = sum(1 for quest in quests.itervalues() if quest.isCompleted())
        return (
         completedCount, maxStage)

    def getMaxStage(self):
        quests = self.getQuests()
        return len(quests)

    def getProgressionStage(self, quest):
        matchObject = QUEST_STEP_REGEX.search(quest.getID())
        if matchObject:
            return int(matchObject.group(1))
        else:
            return

    def getAchievementNumber(self, quest):
        matchObject = ACHIEVEMENT_STEP_REGEX.search(quest.getID())
        if matchObject:
            return int(matchObject.group(1))
        else:
            return

    def getQuestsForAwardsScreen(self):

        def filterFunc(quest):
            questType = bool(ACHIEVEMENT_STEP_REGEX.search(quest[0]))
            index = int(quest[0].split('_')[(-1)])
            return (
             questType, index)

        quests = self.eventsCache.getAllQuests(lambda quest: bool(ACHIEVEMENT_STEP_REGEX.search(quest.getID()) or QUEST_STEP_REGEX.search(quest.getID())))
        return OrderedDict(sorted(quests.items(), key=filterFunc))

    def _getNeededPointsCount(self, quest):
        tokenReq = quest.accountReqs.getTokens()[0]
        return tokenReq.getNeededCount()

    def _onSettingsChanged(self, diff):
        self._quests = None
        return

    def _onTokensUpdate(self, diff, _):
        tokens = diff.get('tokens', {})
        if not tokens:
            return
        tokenID = self.cosmicBattleController.getTokenProgressionID()
        if tokenID in tokens:
            self.onProgressPointsUpdated()

    def _filterFunc(self, quest):
        try:
            return self.isCosmicProgressionQuest(quest.getID()) and quest.accountReqs.isAvailable()
        except Exception:
            _logger.exception('Filter meet unexpected type %s', quest)
            return False

    def collectSortedQuests(self):
        quests = self.getQuests()
        return OrderedDict(sorted(quests.items(), key=lambda key_value: int(key_value[0].split('_')[(-1)])))

    def collectSortedDailyQuests(self):
        quests = self.getDailyQuests()
        return OrderedDict(sorted(quests.items(), key=lambda key_value: key_value[0]))

    def isCosmicProgressionQuest(self, questID):
        questionPrefix = self.cosmicBattleController.getProgressionQuestPrefix()
        return questID.startswith(questionPrefix)

    def getBonuses(self):
        result = []
        for quest in self.quests.values():
            pointsCondition = self._getNeededPointsCount(quest)
            bonuses = quest.getBonuses()
            result.append((pointsCondition, bonuses, quest.isCompleted()))

        return result

    def setQuestProgressAsViewed(self, quest):
        self.eventsCache.questsProgress.markQuestProgressAsViewed(quest.getID())

    def getQuestCompletionChanged(self, quest):
        return self.eventsCache.questsProgress.getQuestCompletionChanged(quest.getID())

    def getLastSeenPoints(self):
        if self._lastSeenPoints is not None:
            return self._lastSeenPoints
        else:
            return self.getCurrentPoints()

    def updateLastSeenPoints(self, points=None):
        self._lastSeenPoints = points or self.getCurrentPoints()

    def isProgressionFinished(self):
        tokens = self.cosmicBattleController.getProgressionChapterTokens()
        if tokens:
            return self.itemsCache.items.tokens.isTokenAvailable(tokens[(-1)])
        return False

    def setProgressionLobbyRoute(self):
        progressionTokens = self.cosmicBattleController.getProgressionChapterTokens()
        index = 0
        for index, token in enumerate(progressionTokens):
            if not self.itemsCache.items.tokens.isTokenAvailable(token):
                break

        self.cosmicBattleController.setLobbyRoute(self.PROGRESSION_ROUTE[index], True)