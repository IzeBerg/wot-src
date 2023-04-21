from functools import partial
import BigWorld, CGF
from account_helpers.AccountSettings import ArmoryYard, AccountSettings
from armory_yard_constants import getCurrencyToken, getGroupName, getStageToken, getEndToken, getEndQuestID, PROGRESSION_LEVEL_PDATA_KEY, State, CLAIMED_FINAL_REWARD, PDATA_KEY_ARMORY_YARD, INTO_VIDEO, isArmoryYardStyleQuest, DAY_BEFORE_END_STYLE_QUEST, AY_VIDEOS
from armory_yard.gui.window_events import showArmoryYardIntroWindow, showArmoryYardVehiclePreview, showArmoryYardWaiting, hideArmoryYardWaiting
from armory_yard.gui.impl.lobby.feature.armory_yard_main_view import ArmoryYardMainView
from armory_yard.gui.impl.gen.view_models.views.lobby.feature.armory_yard_main_view_model import TabId
from armory_yard.managers.sound_manager import ArmorySoundManager
from armory_yard.managers.camera_manager import CameraManager
from armory_yard.managers.scene_loading_manager import SceneLoadingManager
from constants import Configs, EVENT_TYPE
from gui.shared.events import ArmoryYardEvent
from gui.shared.money import Money, Currency, ZERO_MONEY
from helpers import dependency, time_utils
from Event import Event, EventManager
from gui.ClientUpdateManager import g_clientUpdateManager
from gui.server_events.event_items import Group
from gui.shared import g_eventBus, events, EVENT_BUS_SCOPE
from gui.game_control.season_provider import SeasonProvider
from gui.shared.utils.scheduled_notifications import Notifiable, SimpleNotifier
from gui.Scaleform.framework.managers.loaders import GuiImplViewLoadParams
from gui.Scaleform.framework import ScopeTemplates
from helpers.server_settings import serverSettingsChangeListener
from skeletons.connection_mgr import IConnectionManager
from skeletons.gui.lobby_context import ILobbyContext
from skeletons.gui.game_control import IArmoryYardController
from skeletons.gui.server_events import IEventsCache
from skeletons.gui.shared import IItemsCache
from cgf_components.armory_yard_components import AssemblyStageIndexManager
from skeletons.gui.shared.utils import IHangarSpace
from armory_yard.managers.stage_manager import showVideo
from gui.impl.gen import R
import ScaleformFileLoader
from gui.Scaleform import SCALEFORM_STARTUP_VIDEO_PATH
AY_VIDEOS_FOLDER = ('/').join((SCALEFORM_STARTUP_VIDEO_PATH, 'armory_yard'))

class ArmoryYardController(IArmoryYardController):
    __eventsCache = dependency.descriptor(IEventsCache)
    __lobbyContext = dependency.descriptor(ILobbyContext)
    __itemsCache = dependency.descriptor(IItemsCache)
    __connectionMgr = dependency.descriptor(IConnectionManager)

    def __init__(self):
        self.__eventManager = EventManager()
        self.onUpdated = Event(self.__eventManager)
        self.onProgressUpdated = Event(self.__eventManager)
        self.onQuestsUpdated = Event(self.__eventManager)
        self.onStatusChange = Event(self.__eventManager)
        self.onCheckNotify = Event(self.__eventManager)
        self.onAnnouncement = Event(self.__eventManager)
        self.onPayed = Event(self.__eventManager)
        self.onServerSwitchChange = Event(self.__eventManager)
        self.onStyleQuestEnds = Event(self.__eventManager)
        self.onCollectReward = Event(self.__eventManager)
        self.onPayedError = Event(self.__eventManager)
        self.__serverSettings = _ServerSettings()
        self.__soundManager = ArmorySoundManager()
        self.__cameraManager = CameraManager()
        self.__sceneLoadingManager = SceneLoadingManager()
        self.__statusChangeNotifier = SimpleNotifier(self.__getTimeToStatusChange, self.__onNotifyStatusChange)
        self.__isPaused = False
        self.__isStarted = False
        self.__isStreamingEnabled = False

    def disableVideoStreaming(self):
        if self.__isStreamingEnabled:
            ScaleformFileLoader.disableStreaming()
            self.__isStreamingEnabled = False

    def enableVideoStreaming(self):
        if not self.__isStreamingEnabled:
            self.__isStreamingEnabled = True
            files = [ ('/').join((AY_VIDEOS_FOLDER, video)) for video in AY_VIDEOS ]
            ScaleformFileLoader.enableStreaming(files)

    @property
    def serverSettings(self):
        return self.__serverSettings

    @property
    def cameraManager(self):
        return self.__cameraManager

    def onLobbyInited(self, event):
        self.__serverSettings.start()
        g_clientUpdateManager.addCallbacks({'tokens': self.__onTokensUpdate, 
           'quests': self.__onQuestsUpdated, 
           PDATA_KEY_ARMORY_YARD: self.__onPdataUpdated})
        self.__serverSettings.onUpdated += self.__statusChangeNotifier.startNotification
        self.__statusChangeNotifier.startNotification()
        self.__checkStyleQuest()
        if self.isEnabled():
            self.onCheckNotify()
            self.__checkAnnouncement()
            self.__isPaused = self.serverSettings.isPaused
            if not self.__isStarted and self.getCollectableRewards() > 0:
                self.onCollectReward()
        self.__connectionMgr.onDisconnected += self.__onDisconnected
        self.__isStarted = True

    def onAccountBecomeNonPlayer(self):
        self.__serverSettings.stop()
        g_clientUpdateManager.removeObjectCallbacks(self)
        self.__soundManager.clear()
        self.__sceneLoadingManager.destroy()
        self.__cameraManager.destroy()
        self.__stopNotification()

    def fini(self):
        self.__serverSettings.stop()
        self.__eventManager.clear()
        self.__soundManager.clear()
        self.__sceneLoadingManager.destroy()
        self.__cameraManager.destroy()
        self.__stopNotification()
        self.__connectionMgr.onDisconnected -= self.__onDisconnected

    def __onDisconnected(self):
        self.__isStarted = False

    def isActive(self):
        return self.getState() not in (State.DISABLED, State.BEFOREPROGRESSION)

    def isQuestActive(self):
        return self.getState() not in (State.DISABLED, State.BEFOREPROGRESSION, State.POSTPROGRESSION)

    def isEnabled(self):
        startSeasonDate, _ = self.getSeasonInterval()
        return startSeasonDate is not None and self.__serverSettings.isEnabled()

    def isCompleted(self):
        totalTokens, receivedTokens = self.getTokensInfo()
        return totalTokens <= receivedTokens

    def isProgressionQuest(self, questID):
        return any([ quest.getID() == questID for _, quest in self.iterProgressionQuests() ])

    def iterProgressionQuests(self):
        for cycleID, _ in self.serverSettings.iterAllCycles():
            for quest in self.iterCycleProgressionQuests(cycleID):
                yield (
                 cycleID, quest)

    def iterCycleProgressionQuests(self, cycleID):
        for questID in self.__eventsCache.getGroups().get(getGroupName(cycleID), Group(0, {})).getGroupEvents():
            quest = self.__eventsCache.getQuestByID(questID)
            if quest.getType() != EVENT_TYPE.TOKEN_QUEST:
                yield quest

    def getNextCycle(self, currentTime=None):
        if currentTime is None:
            currentTime = time_utils.getServerUTCTime()
        curSeason = self.__serverSettings.getCurrentSeason()
        allCycles = curSeason.getAllCycles() if curSeason else {}
        for _, cycleData in sorted(allCycles.items()):
            if currentTime < cycleData.startDate:
                return cycleData

        return

    def getCollectableRewards(self):
        return self.getCurrencyTokenCount() - self.getProgressionLevel()

    def getCurrencyTokenCount(self):
        return self.__eventsCache.questsProgress.getTokenCount(self.serverSettings.getCurrencyToken())

    def getProgressionLevel(self):
        return self.__itemsCache.items.armoryYard.progressionLevel

    def getCurrentProgress(self):
        return self.getCurrencyTokenCount()

    def getTotalSteps(self):
        currentSeason = self.__serverSettings.getCurrentSeason()
        if currentSeason is None:
            return 0
        else:
            return self.__serverSettings.getModeSettings().rewards.get(currentSeason.getSeasonID(), {}).get('maxNumberOfSteps', 0)

    def getStepsRewards(self):
        currentSeason = self.__serverSettings.getCurrentSeason()
        if currentSeason is None:
            return {}
        else:
            return self.__serverSettings.getModeSettings().rewards.get(currentSeason.getSeasonID(), {}).get('steps', {})

    def getFinalRewardVehicle(self):
        stepCount = self.getTotalSteps()
        vehicleBonus = self.getStepsRewards().get(stepCount, {}).get('vehicles', {})
        vehicleCD = next(iter(vehicleBonus.keys())) if vehicleBonus else None
        if vehicleCD is not None:
            return self.__itemsCache.items.getItemByCD(vehicleCD)
        else:
            return

    def getCurrencyTokenCost(self):
        for currency in Currency.BY_WEIGHT:
            if currency in self.__serverSettings.getModeSettings().tokenCost:
                return Money.makeFrom(currency, self.__serverSettings.getModeSettings().tokenCost[currency])

        return ZERO_MONEY

    def isChapterFinished(self, cycleID):
        return bool(self.__eventsCache.questsProgress.getTokenCount(getEndToken(cycleID)))

    def receivedTokensInChapter(self, cycleID):
        return sum([ quest.isCompleted() for quest in self.iterCycleProgressionQuests(cycleID) ])

    def getSeasonInterval(self):
        season = self.serverSettings.getCurrentSeason()
        if season:
            return (season.getStartDate(), season.getEndDate())
        else:
            return (None, None)

    def getTokensInfo(self):
        return (self.getTotalSteps(), self.getCurrencyTokenCount())

    def totalTokensInChapter(self, cycleID):
        quest = self.__eventsCache.getQuestByID(getEndQuestID(cycleID))
        if quest is None:
            return 0
        else:
            return sum([ token.getNeededCount() for token in quest.accountReqs.getTokens() if token.getID() == self.__serverSettings.getStageToken(cycleID)
                       ])

    def getCompensation(self):
        pass

    def getProgressionTimes(self):
        startProgressionTime = None
        finishProgressionTime = 0
        for _, data in self.serverSettings.iterAllCycles():
            if startProgressionTime is None or startProgressionTime > data.startDate:
                startProgressionTime = data.startDate
            if data.endDate > finishProgressionTime:
                finishProgressionTime = data.endDate

        return (
         startProgressionTime, finishProgressionTime)

    def getAvailableQuestsCount(self):
        currentTime = time_utils.getServerUTCTime()
        isPrevChapterFinished = True
        count = 0
        curSeason = self.__serverSettings.getCurrentSeason()
        allCycles = curSeason.getAllCycles() if curSeason else {}
        for cycle in sorted(allCycles.values(), key=lambda item: item.ID):
            if currentTime > cycle.startDate and isPrevChapterFinished:
                count += sum([ not quest.isCompleted() for quest in self.iterCycleProgressionQuests(cycle.ID) ])
            isPrevChapterFinished = self.isChapterFinished(cycle.ID)

        return count

    def getState(self):
        if self.serverSettings.isPaused or not self.isEnabled():
            return State.DISABLED
        currDate = time_utils.getCurrentLocalServerTimestamp()
        startProgressionTime, finishProgressionTime = self.getProgressionTimes()
        if currDate < startProgressionTime:
            return State.BEFOREPROGRESSION
        if currDate >= finishProgressionTime:
            return State.POSTPROGRESSION
        lastCountdownTime = self.serverSettings.getModeSettings().activeHoursCountdown * time_utils.ONE_HOUR
        if finishProgressionTime - currDate <= lastCountdownTime:
            return State.ACTIVELASTHOURS
        return State.ACTIVE

    def goToArmoryYard(self, tabId=TabId.PROGRESS, loadBuyView=False):
        if not self.isActive():
            return
        self.enableVideoStreaming()

        def _loadedCallback():
            if loadBuyView:
                g_eventBus.handleEvent(ArmoryYardEvent(ArmoryYardEvent.SHOW_ARMORY_YARD_BUY_VIEW, ctx={'onLoadedCallback': lambda : BigWorld.callback(0.0, hideArmoryYardWaiting)}), EVENT_BUS_SCOPE.DEFAULT)
            else:
                BigWorld.callback(0.0, hideArmoryYardWaiting)

        showArmoryYardWaiting()
        if not self.__sceneLoadingManager.isLoading() and not self.__sceneLoadingManager.sceneIsLoaded():
            self.__sceneLoadingManager.loadScene(partial(self.goToArmoryYard, tabId, loadBuyView))
            self.__soundManager.onSoundModeChanged(True)
            return
        lastSeasonID = AccountSettings.getArmoryYard(ArmoryYard.ARMORY_YARD_LAST_INTRO_VIEWED) or -1
        if lastSeasonID != self.serverSettings.getCurrentSeason().getSeasonID():
            showArmoryYardIntroWindow(partial(self.showIntroVideo, tabId), loadedCallback=hideArmoryYardWaiting)
            return
        g_eventBus.handleEvent(events.LoadGuiImplViewEvent(GuiImplViewLoadParams(R.views.armory_yard.lobby.feature.ArmoryYardMainView(), ArmoryYardMainView, ScopeTemplates.LOBBY_SUB_SCOPE), tabId, _loadedCallback), scope=EVENT_BUS_SCOPE.LOBBY)

    @dependency.replace_none_kwargs(hangarSpace=IHangarSpace)
    def showIntroVideo(self, tabId, hangarSpace=None):
        stageManager = CGF.getManager(hangarSpace.space.getSpaceID(), AssemblyStageIndexManager)
        self.cameraManager.goToPosition(stageManager.getCameraDataByStageIndex(0))
        showVideo(INTO_VIDEO, partial(self.goToArmoryYard, tabId))

    def goToArmoryYardQuests(self):
        if self.isQuestActive():
            self.goToArmoryYard(TabId.QUESTS)

    def onLoadingHangar(self):
        self.__sceneLoadingManager.unloadScene()
        self.__soundManager.onSoundModeChanged(False)
        self.__cameraManager.goToHangar()
        self.__cameraManager.destroy()

    def hasCurrentRewards(self):
        stepRewards = self.getStepsRewards()
        if not stepRewards:
            return False
        currentLevel = self.getProgressionLevel()
        nextLevel = currentLevel + self.getCollectableRewards()
        if nextLevel == self.getTotalSteps():
            nextLevel -= 1
        for step in xrange(currentLevel + 1, nextLevel + 1):
            if step in stepRewards:
                return True

        return False

    def showHeroTankVehiclePreview(self):
        reward = self.getFinalRewardVehicle()
        if reward is not None:
            showArmoryYardVehiclePreview(self.getFinalRewardVehicle().intCD, True, True, True)
        return

    def update(self):
        if self.isEnabled():
            self.onCheckNotify()
            self.__checkAnnouncement()
            if self.__isPaused != self.serverSettings.isPaused:
                self.__isPaused = self.serverSettings.isPaused
                self.onServerSwitchChange()
        self.onUpdated()

    def __checkAnnouncement(self):
        if self.getState() == State.BEFOREPROGRESSION:
            startTime, _ = self.getProgressionTimes()
            self.onAnnouncement(startTime)
        announcementCountdown = self.serverSettings.getModeSettings().announcementCountdown * time_utils.ONE_HOUR
        nowTime = time_utils.getServerUTCTime()
        curSeason = self.__serverSettings.getCurrentSeason()
        allCycles = curSeason.getAllCycles() if curSeason else {}
        for cycle in allCycles.values():
            if cycle.startDate > nowTime and cycle.startDate - nowTime <= announcementCountdown:
                self.onAnnouncement(cycle.startDate, cycle)

    def __checkStyleQuest(self):
        armoryYardStyleQuests = self.__eventsCache.getAllQuests(lambda q: isArmoryYardStyleQuest(q.getID()))
        nowTime = time_utils.getServerUTCTime()
        for quest in armoryYardStyleQuests.values():
            deltaTime = quest.getFinishTime() - nowTime
            if not quest.isCompleted() and 0 < deltaTime <= DAY_BEFORE_END_STYLE_QUEST * time_utils.ONE_DAY:
                self.onStyleQuestEnds(quest.getFinishTime())

    def __onTokensUpdate(self, diff):
        if self.serverSettings.getCurrencyToken() in diff:
            self.onProgressUpdated()
        if set([ getEndToken(cycleID) for cycleID, _ in self.serverSettings.iterAllCycles() ]) & set(diff):
            self.onQuestsUpdated()

    def __onPdataUpdated(self, diff):
        if PROGRESSION_LEVEL_PDATA_KEY in diff or CLAIMED_FINAL_REWARD in diff:
            self.onProgressUpdated()

    def __onQuestsUpdated(self, diff):
        if set([ quest.getID() for _, quest in self.iterProgressionQuests() ]) & set(diff):
            self.onQuestsUpdated()

    def __getTimeToStatusChange(self):
        if self.isEnabled():
            nowTime = time_utils.getServerUTCTime()
            _, finishTime = self.getSeasonInterval()
            currentSeason = self.serverSettings.getCurrentSeason()
            cycleData = currentSeason.getNextByTimeCycle(nowTime)
            if cycleData is not None:
                delta = cycleData.startDate - nowTime
                if delta > 0:
                    return delta + 1
            delta = currentSeason.getLastCycleInfo().endDate - nowTime
            if delta > 0:
                return delta + 1
            delta = finishTime - nowTime
            if delta > 0:
                return delta + 1
        else:
            nextSeason = self.serverSettings.seasonProvider.getNextSeason()
            if nextSeason is not None:
                nowTime = time_utils.getServerUTCTime()
                startTime = nextSeason.getStartDate()
                delta = startTime - nowTime
                if delta > 0:
                    return delta + 1
        return 0

    def __onNotifyStatusChange(self):
        self.onStatusChange()
        self.onUpdated()
        self.onCheckNotify()
        self.__checkAnnouncement()

    def __stopNotification(self):
        self.__statusChangeNotifier.stopNotification()
        self.__serverSettings.onUpdated -= self.__statusChangeNotifier.startNotification


class _ArmoryYardSeasonProvider(SeasonProvider):
    __slots__ = ('onUpdated', '__notificationManager')
    __armoryYard = dependency.descriptor(IArmoryYardController)

    def __init__(self):
        super(_ArmoryYardSeasonProvider, self).__init__()
        self.__notificationManager = Notifiable()
        self.__notificationManager.addNotificator(SimpleNotifier(self.getTimer, self.__onPrimeTimeUpdate))
        self.onUpdated = Event()

    def start(self):
        self.__notificationManager.startNotification()

    def stop(self):
        self.__notificationManager.stopNotification()

    def fini(self):
        self.stop()
        self.onUpdated.clear()
        self.__notificationManager.clearNotification()
        self.__notificationManager = None
        return

    def getModeSettings(self):
        return self.__armoryYard.serverSettings.getModeSettings()

    def getTimer(self, now=None, peripheryID=None):
        stateChange = self.getClosestStateChangeTime(now)
        if stateChange > 0:
            return stateChange + 1
        return 0

    def onSettingsUpdated(self, diff):
        if 'seasons' not in diff and 'cycleTimes' not in diff:
            return
        self.__notificationManager.startNotification()

    def __onPrimeTimeUpdate(self):
        self.onUpdated()
        self.__armoryYard.update()
        self.__notificationManager.startNotification()


class _ServerSettings(object):
    __slots__ = ('__seasonProvider', 'onUpdated')
    __lobbyContext = dependency.descriptor(ILobbyContext)
    __armoryYard = dependency.descriptor(IArmoryYardController)

    def __init__(self):
        super(_ServerSettings, self).__init__()
        self.__seasonProvider = _ArmoryYardSeasonProvider()
        self.onUpdated = Event()

    def start(self):
        self.__lobbyContext.getServerSettings().onServerSettingsChange += self.__onServerSettingsChanged
        self.__seasonProvider.start()

    def stop(self):
        self.__lobbyContext.getServerSettings().onServerSettingsChange -= self.__onServerSettingsChanged
        self.__seasonProvider.stop()

    def fini(self):
        self.stop()
        self.onUpdated.clear()
        self.__seasonProvider.fini()
        self.__seasonProvider = None
        return

    @property
    def seasonProvider(self):
        return self.__seasonProvider

    @property
    def isPaused(self):
        return self.getModeSettings().isPaused

    def iterAllCycles(self, now=None):
        curSeason = self.getCurrentSeason(now)
        allCycles = curSeason.getAllCycles() if curSeason else {}
        for cycleID, cycleData in sorted(allCycles.items()):
            yield (
             cycleID, cycleData)

    def getCurrentSeason(self, now=None):
        return self.__seasonProvider.getCurrentSeason(now)

    def getNextSeason(self, now=None):
        return self.__seasonProvider.getNextSeason(now)

    def getStageToken(self, cycleID=None):
        cycleID = cycleID or self.__seasonProvider.getCurrentCycleID()
        if cycleID is None:
            return ''
        else:
            return getStageToken(cycleID)

    def getCurrencyToken(self, seasonID=None):
        if seasonID is None:
            curSeason = self.__seasonProvider.getCurrentSeason()
            if curSeason is not None:
                seasonID = curSeason.getSeasonID()
        if seasonID is None:
            return ''
        else:
            return getCurrencyToken(seasonID)

    def isEnabled(self):
        return self.getModeSettings().isEnabled

    def getModeSettings(self):
        return self.__lobbyContext.getServerSettings().armoryYard

    @serverSettingsChangeListener(Configs.ARMORY_YARD_CONFIG.value)
    def __onServerSettingsChanged(self, diff, *args, **kwards):
        self.__seasonProvider.onSettingsUpdated(diff)
        self.onUpdated()
        self.__armoryYard.update()