import logging
from enum import Enum
from Queue import Queue
from helpers.time_utils import getServerGameDay, getCurrentLocalServerTimestamp, ONE_DAY
import BigWorld, Event, SoundGroups
from PlayerEvents import g_playerEvents
from cosmic_account_settings import isResearchDoneViewDisplayed, getLastDailyQDay, setLastDailyQDay
from cosmic_event.gui.battle_results import CosmicBattleResultEvent
from cosmic_event.skeletons.announcer_controller import IAnnouncerController
from cosmic_event.skeletons.battle_controller import ICosmicEventBattleController
from cosmic_event.skeletons.progression_controller import ICosmicEventProgressionController
from gui.shared import g_eventBus, EVENT_BUS_SCOPE
from helpers import dependency
_logger = logging.getLogger(__name__)

class AnnouncerEvents(Enum):
    DAILY_QUESTS_COMPLETE = ('ev_cosmic_2024_vo_lobby_daily_quests_complete', 4, 'daily_completed')
    PROGRESSION_COMPLETE = ('ev_cosmic_2024_vo_lobby_login_after_progression_complete',
                            5, 'progression_complete')
    FIRST_LOGIN = ('ev_cosmic_2024_vo_lobby_player_1st_login', 6, 'first_lobby')
    PROGRESSION_PHASE_1_FIN = ('ev_cosmic_2024_vo_lobby_progression_phase_1_fin', 7,
                               'progression_1')
    PROGRESSION_PHASE_2_FIN = ('ev_cosmic_2024_vo_lobby_progression_phase_2_fin', 8,
                               'progression_2')
    PROGRESSION_PHASE_3_FIN = ('ev_cosmic_2024_vo_lobby_progression_phase_3_fin', 10,
                               'progression_3')

    def getSoundName(self):
        return self.value[0]

    def getDuration(self):
        return self.value[1]

    def getTextKey(self):
        return self.value[2]


class AnnouncerController(IAnnouncerController):
    _INITIAL_DELAY_s = 2
    _INBETWEEN_DELAY_s = 5
    _PROGRESSION_PHASES = (AnnouncerEvents.PROGRESSION_PHASE_1_FIN,
     AnnouncerEvents.PROGRESSION_PHASE_2_FIN,
     AnnouncerEvents.PROGRESSION_PHASE_3_FIN)
    _cosmicBattleController = dependency.descriptor(ICosmicEventBattleController)
    _cosmicProgressionController = dependency.descriptor(ICosmicEventProgressionController)

    def __init__(self):
        super(AnnouncerController, self).__init__()
        self.onAnnouncerPlay = Event.Event()
        self._timerCallbackID = None
        self._isPlaying = False
        self._queue = Queue()
        self._progressionNotified = False
        return

    def init(self):
        super(AnnouncerController, self).init()
        g_eventBus.addListener(CosmicBattleResultEvent.POST_BATTLE_SCREEN_OPENING, self._postBattleOpening, scope=EVENT_BUS_SCOPE.LOBBY)
        g_playerEvents.onClientUpdated += self._onClientUpdate

    def fini(self):
        self.onAnnouncerPlay.clear()
        g_eventBus.removeListener(CosmicBattleResultEvent.POST_BATTLE_SCREEN_OPENING, self._postBattleOpening, scope=EVENT_BUS_SCOPE.LOBBY)
        g_playerEvents.onClientUpdated -= self._onClientUpdate
        if self._timerCallbackID is not None:
            BigWorld.cancelCallback(self._timerCallbackID)
            self._timerCallbackID = None
        return

    def onConnected(self):
        self._progressionNotified = False

    def processProgressFinished(self):
        if not self._progressionNotified:
            self._progressionNotified = True
            currentStage, maxStage = self._cosmicProgressionController.getStageProgress()
            if maxStage != 0 and currentStage == maxStage and not isResearchDoneViewDisplayed():
                self.addToQueue(AnnouncerEvents.PROGRESSION_COMPLETE)

    def startQueuePlay(self):
        self._isPlaying = True
        self._updateTimer()

    def stopQueuePlay(self):
        self._isPlaying = False
        self._updateTimer()

    def addToQueue(self, event):
        self._queue.put(event)
        self._updateTimer()

    def _updateTimer(self):
        if self._isPlaying and self._timerCallbackID is None:
            self._timerCallbackID = BigWorld.callback(self._INITIAL_DELAY_s, self._onTimerCallback)
        elif not self._isPlaying and self._timerCallbackID is not None:
            BigWorld.cancelCallback(self._timerCallbackID)
            self._timerCallbackID = None
        return

    def _onTimerCallback(self):
        self._timerCallbackID = None
        if self._queue.empty():
            return
        else:
            nextAnnounce = self._queue.get()
            SoundGroups.g_instance.playSound2D(nextAnnounce.getSoundName())
            self.onAnnouncerPlay(nextAnnounce.getTextKey(), nextAnnounce.getDuration())
            self._timerCallbackID = BigWorld.callback(nextAnnounce.getDuration() + self._INBETWEEN_DELAY_s, self._onTimerCallback)
            return

    def _onClientUpdate(self, diff, _):
        isFullSync = diff.get('prevRev', None) is None
        if isFullSync or 'tokens' not in diff:
            return
        tokens = diff.get('tokens', {})
        chapterTokens = self._cosmicBattleController.getProgressionChapterTokens()
        for index, chapterToken in enumerate(chapterTokens):
            if chapterToken in tokens:
                self.addToQueue(self._PROGRESSION_PHASES[index])

        return

    def _postBattleOpening(self, *args, **kwargs):
        lastDaily = getLastDailyQDay()
        currentDaily = getServerGameDay()
        if lastDaily >= currentDaily:
            return
        if self._cosmicBattleController.getEventEndTimestamp() - ONE_DAY < getCurrentLocalServerTimestamp():
            return
        quests = self._cosmicProgressionController.collectSortedDailyQuests()
        allCompleted = all(quest.isCompleted() for quest in quests.values())
        if allCompleted:
            self.addToQueue(AnnouncerEvents.DAILY_QUESTS_COMPLETE)
            setLastDailyQDay(currentDaily)