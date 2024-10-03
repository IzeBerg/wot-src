import typing, operator, time, BigWorld
from constants import EVENT_TYPE, EMAIL_CONFIRMATION_QUEST_ID
from customization_quests_common import deserializeToken, validateToken
from gui import makeHtmlString
from gui.Scaleform.genConsts.MISSIONS_STATES import MISSIONS_STATES
from gui.Scaleform.locale.MENU import MENU
from gui.Scaleform.locale.QUESTS import QUESTS
from gui.Scaleform.locale.RES_ICONS import RES_ICONS
from gui.impl import backport
from gui.impl.gen import R
from gui.server_events import formatters
from gui.server_events.personal_missions_navigation import PersonalMissionsNavigation
from gui.shared.gui_items.customization import C11nStyleProgressData
from helpers import time_utils, i18n, dependency, isPlayerAccount
from shared_utils import CONST_CONTAINER, findFirst, first
from skeletons.gui.customization import ICustomizationService
from skeletons.gui.game_control import IMarathonEventsController, IArmoryYardController, IDebutBoxesController, IEarlyAccessController
from skeletons.gui.lobby_context import ILobbyContext
from skeletons.gui.server_events import IEventsCache
from skeletons.gui.shared import IItemsCache
from gui.server_events.events_constants import BATTLE_MATTERS_QUEST_ID, MARATHON_GROUP_PREFIX, PREMIUM_GROUP_PREFIX, DAILY_QUEST_ID_PREFIX, RANKED_DAILY_GROUP_ID, RANKED_PLATFORM_GROUP_ID, BATTLE_ROYALE_GROUPS_ID, EPIC_BATTLE_GROUPS_ID, MAPS_TRAINING_GROUPS_ID, MAPS_TRAINING_QUEST_PREFIX, FUN_RANDOM_GROUP_ID, COSMIC_EVENT_PREFIX, VERSUS_AI_QUEST_GROUP_PREFIX, WT_QUEST_PREFIX
from helpers.i18n import makeString as _ms
if typing.TYPE_CHECKING:
    from gui.server_events.event_items import Quest
FINISH_TIME_LEFT_TO_SHOW = time_utils.ONE_DAY
START_TIME_LIMIT = 5 * time_utils.ONE_DAY
AWARDS_PER_PAGE = 3
AWARDS_PER_SINGLE_PAGE = 5

class EventInfoModel(object):
    NO_BONUS_COUNT = -1

    def __init__(self, event):
        self.event = event

    def getTimerMsg(self, key=None):
        startTimeLeft = self.event.getStartTimeLeft()
        if startTimeLeft > 0:
            if startTimeLeft > START_TIME_LIMIT:
                fmt = self._getDateTimeString(self.event.getStartTime())
            else:
                fmt = self._getTillTimeString(startTimeLeft)
            return makeHtmlString('html_templates:lobby/quests', 'timerTillStart', {'time': fmt})
        if FINISH_TIME_LEFT_TO_SHOW > self.event.getFinishTimeLeft() > 0:
            gmtime = time.gmtime(self.event.getFinishTimeLeft())
            if gmtime.tm_hour > 0:
                fmt = i18n.makeString('#quests:item/timer/tillFinish/onlyHours')
            else:
                fmt = i18n.makeString('#quests:item/timer/tillFinish/lessThanHour')
            fmt %= {'hours': time.strftime('%H', gmtime), 
               'min': time.strftime('%M', gmtime), 
               'days': str(gmtime.tm_mday)}
            return makeHtmlString('html_templates:lobby/quests', 'timerTillFinish', {'time': fmt})
        return ''

    def _getStatus(self, pCur=None):
        return (MISSIONS_STATES.NONE, '')

    @classmethod
    def _getTillTimeString(cls, timeValue):
        return time_utils.getTillTimeString(timeValue, MENU.TIME_TIMEVALUE)

    @classmethod
    def _getDailyProgressResetTimeUTC(cls):
        regionalSettings = BigWorld.player().serverSettings['regional_settings']
        if 'starting_time_of_a_new_game_day' in regionalSettings:
            newDayUTC = regionalSettings['starting_time_of_a_new_game_day']
        elif 'starting_time_of_a_new_day' in regionalSettings:
            newDayUTC = regionalSettings['starting_time_of_a_new_day']
        else:
            newDayUTC = 0
        return newDayUTC

    @classmethod
    def _getWeeklyProgressResetTimeUTC(cls):
        regionalSettings = BigWorld.player().serverSettings['regional_settings']
        if 'starting_day_of_a_new_week' in regionalSettings:
            newWeek = regionalSettings['starting_day_of_a_new_week']
        else:
            newWeek = 0
        if 'starting_time_of_a_new_game_day' in regionalSettings:
            newDayUTC = regionalSettings['starting_time_of_a_new_game_day']
        elif 'starting_time_of_a_new_day' in regionalSettings:
            newDayUTC = regionalSettings['starting_time_of_a_new_day']
        else:
            newDayUTC = 0
        return (newWeek, newDayUTC)

    @classmethod
    def getDailyProgressResetTimeDelta(cls):
        currentDayUTC = time_utils.getServerTimeCurrentDay()
        dailyProgressResetTimeUTC = cls._getDailyProgressResetTimeUTC()
        untilRest = dailyProgressResetTimeUTC - currentDayUTC
        if untilRest < 0:
            untilRest += time_utils.ONE_DAY
        return untilRest

    def _getActiveDateTimeString(self):
        i18nKey, args = None, {}
        if self.event.getFinishTimeLeft() <= time_utils.ONE_DAY:
            gmtime = time.gmtime(self.event.getFinishTimeLeft())
            if gmtime.tm_hour > 0:
                fmt = i18n.makeString(QUESTS.ITEM_TIMER_TILLFINISH_LONGFULLFORMAT)
            else:
                fmt = i18n.makeString(QUESTS.ITEM_TIMER_TILLFINISH_SHORTFULLFORMAT)
            fmt %= {'hours': time.strftime('%H', gmtime)}
            return fmt
        else:
            if self.event.getStartTimeLeft() > 0:
                i18nKey = '#quests:details/header/activeDuration'
                args = {'startTime': self._getDateTimeString(self.event.getStartTime()), 
                   'finishTime': self._getDateTimeString(self.event.getFinishTime())}
            else:
                if self.event.getFinishTimeLeft() <= time_utils.HALF_YEAR:
                    i18nKey = '#quests:details/header/tillDate'
                    args = {'finishTime': self._getDateTimeString(self.event.getFinishTime())}
                weekDays = self.event.getWeekDays()
                intervals = self.event.getActiveTimeIntervals()
                if weekDays or intervals:
                    if i18nKey is None:
                        i18nKey = '#quests:details/header/schedule'
                    if weekDays:
                        days = (', ').join([ i18n.makeString('#menu:dateTime/weekDays/full/%d' % idx) for idx in self.event.getWeekDays()
                                           ])
                        i18nKey += 'Days'
                        args['days'] = days
                    if intervals:
                        times = []
                        for low, high in intervals:
                            times.append('%s - %s' % (backport.getShortTimeFormat(low),
                             backport.getShortTimeFormat(high)))

                        i18nKey += 'Times'
                        times = (', ').join(times)
                        args['times'] = times
                if i18nKey is None:
                    return
            return i18n.makeString(i18nKey, **args)

    @classmethod
    def _getDateTimeString(cls, timeValue):
        return ('{0:>s} {1:>s}').format(backport.getLongDateFormat(timeValue), backport.getShortTimeFormat(timeValue))


class QuestInfoModel(EventInfoModel):

    def _getActiveDateTimeString(self):
        timeLeft = self.event.getFinishTimeLeft()
        if timeLeft <= time_utils.THREE_QUARTER_HOUR:
            return formatters.formatYellow(QUESTS.DETAILS_HEADER_COMETOENDINMINUTES, minutes=getMinutesRoundByTime(timeLeft))
        return super(QuestInfoModel, self)._getActiveDateTimeString()

    def getTimerMsg(self, key='comeToEndInMinutes'):
        timeLeft = self.event.getFinishTimeLeft()
        if timeLeft <= time_utils.THREE_QUARTER_HOUR:
            return makeHtmlString('html_templates:lobby/quests/', key, {'minutes': getMinutesRoundByTime(timeLeft)})
        return super(QuestInfoModel, self).getTimerMsg()

    def _getDailyResetStatus(self, resetLabelKey, labeFormatter):
        if self.event.bonusCond.isDaily():
            resetHourUTC = self._getDailyProgressResetTimeUTC() / time_utils.ONE_HOUR
            if resetHourUTC >= 0:
                return labeFormatter(resetLabelKey) % {'time': time.strftime(i18n.makeString('#quests:details/conditions/postBattle/dailyReset/timeFmt'), time_utils.getTimeStructInLocal(time_utils.getTimeTodayForUTC(hour=resetHourUTC)))}
        return ''

    def _getWeeklyResetStatus(self, resetLabelKey, labeFormatter):
        if self.event.bonusCond.isWeekly():
            day, resetSeconds = self._getWeeklyProgressResetTimeUTC()
            resetHourUTC = resetSeconds / time_utils.ONE_HOUR
            dayStr = i18n.makeString('#menu:dateTime/weekDays/full/' + str(day + 1)) + ', '
            if resetHourUTC >= 0:
                resetTime = time_utils.getTimeStructInLocal(time_utils.getTimeTodayForUTC(hour=resetHourUTC))
                resetTime = time.struct_time(resetTime[:6] + (day,) + resetTime[7:])
                return labeFormatter(resetLabelKey) % {'time': dayStr + time.strftime(i18n.makeString('#quests:details/conditions/postBattle/weeklyReset/timeFmt'), resetTime)}
        return ''

    def _getCompleteDailyStatus(self, completeKey):
        return backport.text(completeKey, time=self._getTillTimeString(time_utils.ONE_DAY - time_utils.getServerRegionalTimeCurrentDay()))

    def _getCompleteWeeklyStatus(self, completeKey):
        curTime = time_utils.getTimeStructInUTC(time_utils.getCurrentTimestamp())
        resetDay, resetSeconds = self._getWeeklyProgressResetTimeUTC()
        dayDelta = (resetDay - curTime.tm_wday) % 7
        if dayDelta == 0:
            dayDelta = 7
        timeDelta = dayDelta * time_utils.ONE_DAY + resetSeconds - (curTime.tm_hour * time_utils.ONE_HOUR + curTime.tm_min * time_utils.ONE_MINUTE + curTime.tm_sec)
        if timeDelta > time_utils.ONE_WEEK:
            timeDelta -= time_utils.ONE_WEEK
        return backport.text(completeKey, time=self._getTillTimeString(timeDelta))

    def _getCompleteKey(self):
        return R.strings.quests.missionDetails.status.completed.daily()

    def _getCompleteWeeklyKey(self):
        return R.strings.quests.missionDetails.status.completed.weekly()


class EVENT_STATUS(CONST_CONTAINER):
    COMPLETED = 'done'
    NOT_AVAILABLE = 'notAvailable'
    WRONG_TIME = 'wrongTime'
    NONE = ''


def getMinutesRoundByTime(timeLeft):
    timeLeft = int(timeLeft)
    return (timeLeft / time_utils.QUARTER_HOUR + cmp(timeLeft % time_utils.QUARTER_HOUR, 0)) * time_utils.QUARTER


def missionsSortFunc(q):
    isAvailable, status = q.isAvailable()
    isCompleted = q.isCompleted()
    return (
     isAvailable and not isCompleted,
     q.getPriority(),
     status == 'requirement',
     bool(status),
     isCompleted,
     q.getUserName())


def premMissionsSortFunc(a, b):

    def isChild(a, b):
        if not b.getParents():
            return 0
        return a.getID() in b.getParents().values()[0]

    return isChild(a, b) - isChild(b, a)


def dailyQuestsSortFunc(q):
    return q.getSortKey()


def hasAnySavedProgresses(savedProgresses):
    if savedProgresses:
        return True
    return False


def questsSortFunc(q):

    def getPriority(event):
        if isPremium(event.getGroupID()):
            return -1
        return event.getPriority()

    return (
     q.isCompleted(),
     getPriority(q),
     getPriority(q) == -1,
     q.getID())


def getBoosterQuests():

    def filterQuests(quest):
        hasBooster = len(quest.getBonuses('goodies'))
        isNotRanked = quest.getType() != EVENT_TYPE.RANKED_QUEST
        return hasBooster and isNotRanked and quest.isAvailable()[0] and not quest.isCompleted()

    eventsCache = dependency.instance(IEventsCache)
    return eventsCache.getActiveQuests(filterFunc=filterQuests)


def hasAtLeastOneAvailableQuest(quests):
    return any(quest.isAvailable().isValid for quest in quests)


def hasAtLeastOneCompletedQuest(quests):
    return any(quest.isCompleted() for quest in quests)


def isAllQuestsCompleted(quests):
    return all(quest.isCompleted() for quest in quests)


def getMarathonPrefix(eventID):
    marathonsCtrl = dependency.instance(IMarathonEventsController)
    return marathonsCtrl.getPrefix(eventID)


def isMarathon(eventID):
    return eventID.startswith(MARATHON_GROUP_PREFIX)


def isMapsTraining(groupID):
    return groupID == MAPS_TRAINING_GROUPS_ID or groupID and groupID.startswith(MAPS_TRAINING_QUEST_PREFIX)


def isBattleMattersQuestID(questID):
    if questID:
        return questID.startswith(BATTLE_MATTERS_QUEST_ID)
    return False


def isPremium(eventID):
    if eventID:
        return eventID.startswith(PREMIUM_GROUP_PREFIX)
    return False


def isDailyEpic(eventID):
    if eventID:
        return eventID.startswith(EPIC_BATTLE_GROUPS_ID)
    return False


def isBattleRoyale(eventID):
    if eventID:
        return eventID.startswith(BATTLE_ROYALE_GROUPS_ID)
    return False


def isVersusAIQuest(eventID):
    if eventID:
        return eventID.startswith(VERSUS_AI_QUEST_GROUP_PREFIX)
    return False


@dependency.replace_none_kwargs(debutBoxesController=IDebutBoxesController)
def isDebutBoxesGroup(groupID, debutBoxesController=None):
    if groupID:
        return groupID == debutBoxesController.getGroupID()
    return False


@dependency.replace_none_kwargs(debutBoxesController=IDebutBoxesController)
def isDebutBoxesQuest(questID, debutBoxesController=None):
    if questID:
        return questID in debutBoxesController.getQuestsIDs()
    return False


def isFunRandomQuest(eventID):
    if eventID:
        return eventID.startswith(FUN_RANDOM_GROUP_ID)
    return False


def isRankedDaily(eventID):
    if eventID:
        return eventID.startswith(RANKED_DAILY_GROUP_ID)
    return False


def isRankedPlatform(eventID):
    if eventID:
        return eventID.startswith(RANKED_PLATFORM_GROUP_ID)
    return False


def isDailyQuest(eventID):
    if eventID:
        return eventID.startswith(DAILY_QUEST_ID_PREFIX)
    return False


def isACEmailConfirmationQuest(eventID):
    if eventID:
        return eventID == EMAIL_CONFIRMATION_QUEST_ID
    return False


def isCosmicQuest(eventID):
    if eventID:
        return eventID.find(COSMIC_EVENT_PREFIX) != -1
    return False


def isRegularQuest(eventID):
    idGameModeEvent = isDailyEpic(eventID) or isRankedDaily(eventID) or isRankedPlatform(eventID)
    return not (isMarathon(eventID) or isBattleMattersQuestID(eventID) or isPremium(eventID) or idGameModeEvent)


@dependency.replace_none_kwargs(c11nService=ICustomizationService)
def isC11nQuest(eventID, c11nService=None):
    return c11nService.isProgressionQuests(eventID)


def isWtQuest(eventID):
    if eventID:
        return eventID.startswith(WT_QUEST_PREFIX)
    return False


def getDataByC11nQuest(quest):
    if not isC11nQuest(quest.getID()):
        return C11nStyleProgressData()
    tokenBonuses = quest.getBonuses('tokens')
    if not tokenBonuses:
        return C11nStyleProgressData()
    firstBonus = first(tokenBonuses)
    token = first(firstBonus.getTokens().values())
    return parseC11nProgressToken(token)


def parseC11nProgressToken(token):
    tokenID = token.id
    if not validateToken(tokenID):
        return C11nStyleProgressData()
    styleID, branch = deserializeToken(tokenID)
    return C11nStyleProgressData(styleID=styleID, branch=branch, level=token.limit)


def getIdxFromQuest(quest):
    return getIdxFromQuestID(quest.getID())


def getIdxFromQuestID(questID):
    parts = questID.split('_')
    result = -1
    if parts:
        try:
            result = int(parts[(-1)])
        except ValueError:
            result = -1

    return result


@dependency.replace_none_kwargs(itemsCache=IItemsCache)
def getLootboxesFromBonuses(bonuses, itemsCache=None):
    lootboxes = {}
    for bonus in bonuses:
        if bonus.getName() == 'battleToken':
            tokens = bonus.getTokens()
            boxes = itemsCache.items.tokens.getLootBoxes()
            for token in tokens.values():
                if 'lootBox' in token.id:
                    lootboxType = boxes[token.id].getType()
                    if lootboxType not in lootboxes:
                        lootboxes[lootboxType] = {'count': token.count, 'isFree': boxes[token.id].isFree()}
                    else:
                        lootboxes[lootboxType]['count'] += token.count

            break

    return lootboxes


class AwardSheetPresenter(object):

    class Size(CONST_CONTAINER):
        TINY = 'tiny'
        SMALL = 'small'
        MID = 'mid'
        BIG = 'big'
        X_16 = 'x16'

    __navigation = PersonalMissionsNavigation()

    @classmethod
    def getIcon(cls, size, branch=None):
        branchID = branch if branch is not None else cls.__navigation.getBranch()
        return RES_ICONS.getFreesSheetImg(branchID, size)

    @classmethod
    def getPawnedIcon(cls, branch=None):
        branchID = branch if branch is not None else cls.__navigation.getBranch()
        return RES_ICONS.getPawnedSheetImg(branchID)


def getTankmanRewardQuests():
    eventsCache = dependency.instance(IEventsCache)
    for _, o in sorted(eventsCache.getPersonalMissions().getAllOperations().iteritems(), key=operator.itemgetter(0)):
        if o.isUnlocked():
            operationName = _ms('#personal_missions:operations/title%d' % o.getID())
            for classifier in o.getIterationChain():
                _, quests = o.getChainByClassifierAttr(classifier)
                for _, q in sorted(quests.iteritems(), key=operator.itemgetter(0)):
                    bonus = q.getTankmanBonus()
                    needToGetTankman = q.needToGetAddReward() and not bonus.isMain or q.needToGetMainReward() and bonus.isMain
                    if needToGetTankman and bonus.tankman is not None:
                        yield (
                         q, operationName)

    return


@dependency.replace_none_kwargs(eventsCache=IEventsCache)
def getPremiumGroup(eventsCache=None):
    groups = eventsCache.getGroups()
    return findFirst(lambda g: isPremium(g.getID()), groups.values())


@dependency.replace_none_kwargs(eventsCache=IEventsCache)
def getDailyEpicGroup(eventsCache=None):
    groups = eventsCache.getGroups()
    return findFirst(lambda g: isDailyEpic(g.getID()), groups.values())


@dependency.replace_none_kwargs(eventsCache=IEventsCache)
def getDailyBattleRoyaleGroup(eventsCache=None):
    groups = eventsCache.getGroups()
    return findFirst(lambda g: isBattleRoyale(g.getID()), groups.values())


@dependency.replace_none_kwargs(eventsCache=IEventsCache)
def getRankedDailyGroup(eventsCache=None):
    groups = eventsCache.getGroups()
    return findFirst(lambda g: isRankedDaily(g.getID()), groups.values())


@dependency.replace_none_kwargs(eventsCache=IEventsCache)
def getRankedPlatformGroup(eventsCache=None):
    groups = eventsCache.getGroups()
    return findFirst(lambda g: isRankedPlatform(g.getID()), groups.values())


@dependency.replace_none_kwargs(eventsCache=IEventsCache)
def getFunRandomDailyGroup(eventsCache=None):
    groups = eventsCache.getGroups()
    return findFirst(lambda g: isFunRandomQuest(g.getID()), groups.values())


@dependency.replace_none_kwargs(eventsCache=IEventsCache, lobbyContext=ILobbyContext)
def isPremiumQuestsEnable(lobbyContext=None, eventsCache=None):
    return lobbyContext.getServerSettings().getPremQuestsConfig().get('enabled', False) and len(eventsCache.getPremiumQuests()) > 0


@dependency.replace_none_kwargs(eventsCache=IEventsCache, lobbyContext=ILobbyContext)
def isDailyQuestsEnable(lobbyContext=None, eventsCache=None):
    return lobbyContext.getServerSettings().getDailyQuestConfig().get('enabled', False)


@dependency.replace_none_kwargs(lobbyContext=ILobbyContext)
def getRerollTimeout(lobbyContext=None):
    return lobbyContext.getServerSettings().getDailyQuestConfig().get('rerollTimeout', 0)


@dependency.replace_none_kwargs(lobbyContext=ILobbyContext)
def isRerollEnabled(lobbyContext=None):
    return lobbyContext.getServerSettings().getDailyQuestConfig().get('rerollEnabled', False)


@dependency.replace_none_kwargs(lobbyContext=ILobbyContext)
def isEpicQuestEnabled(lobbyContext=None):
    return lobbyContext.getServerSettings().getDailyQuestConfig().get('epicRewardEnabled', False)


def getEventsData(eventsTypeName):
    if isPlayerAccount():
        return BigWorld.player().getUnpackedEventsData(eventsTypeName)
    return {}


@dependency.replace_none_kwargs(lobbyContext=ILobbyContext)
def getC11nQuestsConfig(lobbyContext=None):
    return lobbyContext.getServerSettings().getCustomizationQuestsConfig()


@dependency.replace_none_kwargs(armoryYardCtrl=IArmoryYardController)
def isArmoryYardQuest(eventID, armoryYardCtrl=None):
    return armoryYardCtrl.isProgressionQuest(eventID)


@dependency.replace_none_kwargs(earlyAccessCtrl=IEarlyAccessController)
def isActiveEarlyAccessQuest(eventID, earlyAccessCtrl=None):
    return earlyAccessCtrl.isQuestActive() and (earlyAccessCtrl.isProgressionQuest(eventID) or earlyAccessCtrl.isPostProgressionQuest(eventID))