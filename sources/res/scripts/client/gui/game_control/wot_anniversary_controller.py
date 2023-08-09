import BigWorld, logging
from datetime import datetime
import typing
from Event import EventManager, Event
from account_helpers.AccountSettings import WOT_ANNIVERSARY_SEEN_BATTLE_QUESTS
from account_helpers.settings_core.settings_constants import WotAnniversaryStorageKeys
from gui.ClientUpdateManager import g_clientUpdateManager
from gui.shared import g_eventBus, events, EVENT_BUS_SCOPE
from gui.shared.utils.scheduled_notifications import AcyclicNotifier
from gui.impl.gen import R
from gui.wot_anniversary.wot_anniversary_helpers import showWotAnniversaryWelcomeWindow, WOT_ANNIVERSARY_PREFIX, WotAnniversaryEventState, setAnniversaryServerSetting, WOT_ANNIVERSARY_LOGIN_DAY_UNLOCK_TOKEN, isAnniversaryNotificationShowed, InterestingFacts, getFactTitleByTechName, getFactDescriptionByTechName, WOT_ANNIVERSARY_SECRET_MESSAGE_TOKEN, WOT_ANNIVERSARY_SECRET_MESSAGE_REWARD_QUEST_PREFIX, isWotAnniversaryLoginQuest, WOT_ANNIVERSARY_COMPLETED_PREFIX, FACTS_FILENAMES, LOCAL_TO_API_NAMES, getFactIGBImagePath, WOT_ANNIVERSARY_QUEST_POINTS, setWotAnniversarySectionSetting, getWotAnniversarySectionSetting, filterNotCompletedBattleQuests, findLatestQuest
from helpers import dependency, time_utils
from skeletons.account_helpers.settings_core import ISettingsCore
from skeletons.gui.game_control import IWotAnniversaryController, IHangarLoadingController
from skeletons.gui.lobby_context import ILobbyContext
from skeletons.gui.server_events import IEventsCache
from skeletons.gui.shared import IItemsCache
from wot_anniversary_common import WOT_ANNIVERSARY_CONFIG_NAME
if typing.TYPE_CHECKING:
    from helpers.server_settings import _WotAnniversaryConfig
_logger = logging.getLogger(__name__)
MIN_BATTLES_REQ = 3
TOKEN_EXPIRY_DELTA = 20

class WotAnniversaryController(IWotAnniversaryController):
    __hangarLoadingController = dependency.descriptor(IHangarLoadingController)
    __eventsCache = dependency.descriptor(IEventsCache)
    __lobbyContext = dependency.descriptor(ILobbyContext)
    __itemsCache = dependency.descriptor(IItemsCache)
    __settingsCore = dependency.descriptor(ISettingsCore)
    __DAYS_TO_SHOW = 3

    def __init__(self):
        super(WotAnniversaryController, self).__init__()
        self.__em = EventManager()
        self.onSettingsChanged = Event(self.__em)
        self.onEventStateChanged = Event(self.__em)
        self.onEventActivePhaseEnded = Event(self.__em)
        self.onEventWillEndSoon = Event(self.__em)
        self.onSecretMessageStateChanged = Event(self.__em)
        self.onAnniversaryTabSwitched = Event(self.__em)
        self.onNewBattleQuestsReceived = Event(self.__em)
        self.__latestNotFinishedBattleQuestId = None
        self._interestingFacts = self.__prepareInterestingFactsData()
        self._isSecretMessageActive = None
        self._interestingFactsDictAPI = self.__factsAsDict(self.getInterestingFacts())
        self.__activePhaseEndedNotifier = AcyclicNotifier(self.__getTimeTillActivePhaseEnd, self.__onActivePhaseEnded)
        return

    def onConnected(self):
        self.__hangarLoadingController.onHangarLoadedAfterLogin += self.__showWotAnniversaryWelcomeWindow

    def onLobbyInited(self, event):
        self.__lobbyContext.getServerSettings().onServerSettingsChange += self.__onServerSettingsChanged
        g_clientUpdateManager.addCallback('tokens', self.__onTokensUpdate)
        g_eventBus.addListener(events.WotAnniversaryEvent.ON_MAIN_VIEW_OPENED, self.__updateLatestViewedQuest, scope=EVENT_BUS_SCOPE.LOBBY)
        g_eventBus.addListener(events.WotAnniversaryEvent.ON_MAIN_VIEW_CLOSED, self.__updateLatestViewedQuest, scope=EVENT_BUS_SCOPE.LOBBY)
        self.__startActivePhaseEndedNotification()
        self.__checkEventWillEndSoon()
        self.__updateLastEventState(onLoading=True)
        self.__updateSecretMessageState()
        self.__updateLatestQuest()

    def onAccountBecomeNonPlayer(self):
        self.__clear()

    def fini(self):
        self.__clear()
        if self.__activePhaseEndedNotifier is not None:
            self.__activePhaseEndedNotifier.clear()
            self.__activePhaseEndedNotifier = None
        return

    def onDisconnected(self):
        self.__clear()

    def isEnabled(self):
        return self.getConfig().isEnabled

    def isAvailable(self):
        return self.isEnabled() and self.getConfig().isActive

    def isSecretMessageActive(self):
        return self.getConfig().isSecretMessageActive

    def isAvailableAndActivePhase(self):
        return self.isAvailable() and self.isInActivePhase()

    def isActive(self):
        return self.getConfig().isActive

    def getConfig(self):
        return self.__lobbyContext.getServerSettings().wotAnniversaryConfig

    def getLatestNotFinishedBattleQuestId(self):
        return self.__latestNotFinishedBattleQuestId

    def getQuests(self):
        return self.__eventsCache.getHiddenQuests(self.__filterFunc)

    def getRewardScreenRequiredQuests(self):
        return self.getConfig().rewardScreenRequiredQuests

    def getInterestingFacts(self):
        if not self._interestingFacts:
            self._interestingFacts = self.__prepareInterestingFactsData()
        return self._interestingFacts

    def getInterestingFactsInDict(self):
        if not self._interestingFactsDictAPI:
            self._interestingFactsDictAPI = self.__factsAsDict(self.getInterestingFacts())
        return self._interestingFactsDictAPI

    def getLoginDayUnlockToken(self, dayNumber):
        if dayNumber is not None:
            allTokens = set(self.__itemsCache.items.tokens.getTokens().keys())
            desiredToken = WOT_ANNIVERSARY_LOGIN_DAY_UNLOCK_TOKEN.format(dayNumber)
            if desiredToken in allTokens:
                return desiredToken
        return

    def getTotalDaysNumber(self):
        stime = datetime.utcfromtimestamp(self.getEventStartTime())
        etime = datetime.utcfromtimestamp(self.getActivePhaseEndTime())
        delta = etime - stime
        return delta.days

    def isLastDayNow(self):
        return time_utils.getCurrentLocalServerTimestamp() + time_utils.ONE_DAY >= self.getConfig().activePhaseEndTime

    def getUrl(self, urlName):
        return self.getConfig().anniversaryUrls.get(urlName, '')

    def getEventStartTime(self):
        return self.getConfig().startTime

    def getActivePhaseEndTime(self):
        return self.getConfig().activePhaseEndTime

    def getEventCategoryEndTime(self):
        return self.getConfig().eventCategoryEndTime

    def isInActivePhase(self):
        return self.getEventStartTime() < time_utils.getCurrentLocalServerTimestamp() < self.getActivePhaseEndTime()

    def isInPostActivePhase(self):
        currentTime = time_utils.getCurrentLocalServerTimestamp()
        return self.getActivePhaseEndTime() < currentTime < self.getEventCategoryEndTime()

    def isEventWillEndSoonDaysNow(self):
        days = self.__DAYS_TO_SHOW * time_utils.ONE_DAY
        return time_utils.getCurrentLocalServerTimestamp() + days >= self.getEventCategoryEndTime()

    def claimSecretReward(self):
        quest = self.__eventsCache.getHiddenQuests().get(WOT_ANNIVERSARY_SECRET_MESSAGE_REWARD_QUEST_PREFIX)
        if quest is not None and not quest.isCompleted():
            BigWorld.player().requestSingleToken(WOT_ANNIVERSARY_SECRET_MESSAGE_TOKEN)
            return True
        else:
            return False

    def showActivePhaseFinishedNotification(self):
        self.onEventActivePhaseEnded()

    def getQuestCompletedAt(self, quest):
        tokenQuestID = quest.getID() + WOT_ANNIVERSARY_COMPLETED_PREFIX
        completedAt = self.__itemsCache.items.tokens.getTokenExpiryTime(tokenQuestID)
        if not completedAt:
            if isWotAnniversaryLoginQuest(quest.getID()):
                completedAt = quest.getStartTime()
        else:
            completedAt -= TOKEN_EXPIRY_DELTA * time_utils.ONE_DAY
        return completedAt

    def __onServerSettingsChanged(self, diff):
        if WOT_ANNIVERSARY_CONFIG_NAME in diff:
            self.onSettingsChanged()
            self.__startActivePhaseEndedNotification()
            self.__updateLastEventState()
            self.__updateSecretMessageState()

    def __updateSecretMessageState(self):
        if self._isSecretMessageActive is not None and self._isSecretMessageActive != self.isSecretMessageActive():
            self.onSecretMessageStateChanged()
        self._isSecretMessageActive = self.isSecretMessageActive()
        return

    def __clear(self):
        self._interestingFacts = []
        self._interestingFactsDictAPI = []
        self.__activePhaseEndedNotifier.stopNotification()
        self.__hangarLoadingController.onHangarLoadedAfterLogin -= self.__showWotAnniversaryWelcomeWindow
        self.__lobbyContext.getServerSettings().onServerSettingsChange -= self.__onServerSettingsChanged
        g_clientUpdateManager.removeObjectCallbacks(self, True)
        g_eventBus.removeListener(events.WotAnniversaryEvent.ON_MAIN_VIEW_OPENED, self.__updateLatestViewedQuest, scope=EVENT_BUS_SCOPE.LOBBY)
        g_eventBus.removeListener(events.WotAnniversaryEvent.ON_MAIN_VIEW_CLOSED, self.__updateLatestViewedQuest, scope=EVENT_BUS_SCOPE.LOBBY)
        self.__em.clear()

    @classmethod
    def __filterFunc(cls, quest):
        qId = quest.getID()
        return qId.startswith(WOT_ANNIVERSARY_PREFIX) and qId != WOT_ANNIVERSARY_SECRET_MESSAGE_REWARD_QUEST_PREFIX

    def __showWotAnniversaryWelcomeWindow(self):
        if BigWorld.checkUnattended():
            return
        if self.__itemsCache.items.getAccountDossier().getTotalStats().getBattlesCount() >= MIN_BATTLES_REQ:
            if self.isAvailableAndActivePhase() and not self.__wasWelcomShowed():
                showWotAnniversaryWelcomeWindow()

    def __startActivePhaseEndedNotification(self):
        if self.isAvailable() and not isAnniversaryNotificationShowed(WotAnniversaryStorageKeys.WOT_ANNIVERSARY_ACTIVE_PHASE_ENDED_NOTIFICATION_SHOWED):
            self.__activePhaseEndedNotifier.startNotification()

    def __onActivePhaseEnded(self):
        if self.isAvailable() and self.isInPostActivePhase() and not isAnniversaryNotificationShowed(WotAnniversaryStorageKeys.WOT_ANNIVERSARY_ACTIVE_PHASE_ENDED_NOTIFICATION_SHOWED):
            self.showActivePhaseFinishedNotification()
            setAnniversaryServerSetting({WotAnniversaryStorageKeys.WOT_ANNIVERSARY_ACTIVE_PHASE_ENDED_NOTIFICATION_SHOWED: True})
            self.onSettingsChanged()

    def __updateLastEventState(self, onLoading=False):
        if self.isEnabled() and self.isInActivePhase():
            isAvailable = self.isActive()
            showedOnPause = isAnniversaryNotificationShowed(WotAnniversaryStorageKeys.WOT_ANNIVERSARY_ON_PAUSE_NOTIFICATION_SHOWED)
            if isAvailable and onLoading and not isAnniversaryNotificationShowed(WotAnniversaryStorageKeys.WOT_ANNIVERSARY_STARTED_NOTIFICATION_SHOWED):
                self.onEventStateChanged(WotAnniversaryEventState.STARTED)
                setAnniversaryServerSetting({WotAnniversaryStorageKeys.WOT_ANNIVERSARY_STARTED_NOTIFICATION_SHOWED: True})
            if not isAvailable and not showedOnPause:
                self.onEventStateChanged(WotAnniversaryEventState.PAUSE)
                setAnniversaryServerSetting({WotAnniversaryStorageKeys.WOT_ANNIVERSARY_ON_PAUSE_NOTIFICATION_SHOWED: True})
            elif isAvailable and showedOnPause:
                self.onEventStateChanged(WotAnniversaryEventState.ENABLED)
                setAnniversaryServerSetting({WotAnniversaryStorageKeys.WOT_ANNIVERSARY_ON_PAUSE_NOTIFICATION_SHOWED: False})
        elif not self.isEnabled() and isAnniversaryNotificationShowed(WotAnniversaryStorageKeys.WOT_ANNIVERSARY_STARTED_NOTIFICATION_SHOWED) and not isAnniversaryNotificationShowed(WotAnniversaryStorageKeys.WOT_ANNIVERSARY_FINISHED_NOTIFICATION_SHOWED):
            self.onEventStateChanged(WotAnniversaryEventState.FINISHED)
            setAnniversaryServerSetting({WotAnniversaryStorageKeys.WOT_ANNIVERSARY_FINISHED_NOTIFICATION_SHOWED: True})

    def __checkEventWillEndSoon(self):
        if self.isAvailable() and self.isInPostActivePhase() and self.isEventWillEndSoonDaysNow() and not isAnniversaryNotificationShowed(WotAnniversaryStorageKeys.WOT_ANNIVERSARY_EVENT_WILL_END_SOON_NOTIFICATION_SHOWED):
            self.onEventWillEndSoon()
            setAnniversaryServerSetting({WotAnniversaryStorageKeys.WOT_ANNIVERSARY_EVENT_WILL_END_SOON_NOTIFICATION_SHOWED: True})

    @staticmethod
    def __wasWelcomShowed():
        return isAnniversaryNotificationShowed(WotAnniversaryStorageKeys.WOT_ANNIVERSARY_WELCOME_SHOWED)

    def __getTimeTillActivePhaseEnd(self):
        return max(self.getConfig().activePhaseEndTime - time_utils.getCurrentLocalServerTimestamp(), 0)

    @staticmethod
    def __prepareInterestingFactsData():
        return [ InterestingFacts(factName, R.images.gui.maps.icons.wot_anniversary.facts.small.dyn(fileName)(), R.images.gui.maps.icons.wot_anniversary.facts.medium.dyn(fileName)(), R.images.gui.maps.icons.wot_anniversary.facts.big.dyn(fileName)(), R.images.gui.maps.icons.wot_anniversary.facts.large.dyn(fileName)(), getFactTitleByTechName(factName), getFactDescriptionByTechName(factName)) for factName, fileName in FACTS_FILENAMES.items()
               ]

    @staticmethod
    def __factsAsDict(facts):
        interestingFactsDict = [ data._asdict() for data in facts ]
        for fact in interestingFactsDict:
            for localKeyName in fact.keys():
                if localKeyName in LOCAL_TO_API_NAMES:
                    newKey = LOCAL_TO_API_NAMES.get(localKeyName, localKeyName)
                    fact[newKey] = getFactIGBImagePath(fact.pop(localKeyName))

        return interestingFactsDict

    def __onTokensUpdate(self, diff):
        for key in diff.keys():
            if key == WOT_ANNIVERSARY_QUEST_POINTS:
                return self.__updateLatestQuest()

    def __updateLatestViewedQuest(self, _):
        if self.__latestNotFinishedBattleQuestId is not None and getWotAnniversarySectionSetting(WOT_ANNIVERSARY_SEEN_BATTLE_QUESTS) != self.__latestNotFinishedBattleQuestId:
            setWotAnniversarySectionSetting(WOT_ANNIVERSARY_SEEN_BATTLE_QUESTS, self.__latestNotFinishedBattleQuestId)
        return

    def __updateLatestQuest(self):
        notComplited = filterNotCompletedBattleQuests(self.getQuests())
        if notComplited:
            self.__latestNotFinishedBattleQuestId = findLatestQuest(notComplited).getID()
        else:
            self.__latestNotFinishedBattleQuestId = None
        self.onNewBattleQuestsReceived()
        return