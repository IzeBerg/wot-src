import logging, time
from collections import namedtuple
from functools import partial
import Event, constants
from constants import MarathonConfig
from account_helpers import AccountSettings
from account_helpers.AccountSettings import MARATHON_REWARD_WAS_SHOWN_PREFIX, MARATHON_VIDEO_WAS_SHOWN_PREFIX
from adisp import async, process
from gui.Scaleform import MENU
from gui.Scaleform.daapi.settings.views import VIEW_ALIAS
from gui.Scaleform.genConsts.TOOLTIPS_CONSTANTS import TOOLTIPS_CONSTANTS
from gui.Scaleform.locale.QUESTS import QUESTS
from gui.Scaleform.locale.TOOLTIPS import TOOLTIPS
from gui.game_control.links import URLMacros
from gui.impl import backport
from gui.impl.gen import R
from gui.impl.lobby.marathon.marathon_reward_helper import showMarathonReward
from gui.marathon.marathon_constants import MARATHON_STATE, MARATHON_WARNING, ZERO_TIME, MARATHON_FLAG_TOOLTIP_HEADERS
from gui.prb_control import prbEntityProperty
from gui.shared.event_dispatcher import showBrowserOverlayView
from gui.shared.formatters import text_styles
from gui.shared.utils.functions import makeTooltip
from helpers import dependency, i18n
from helpers.time_utils import ONE_DAY, getTimeStructInLocal, ONE_HOUR
from items.vehicles import makeVehicleTypeCompDescrByName
from skeletons.gui.game_control import IBootcampController
from skeletons.gui.lobby_context import ILobbyContext
from skeletons.gui.server_events import IEventsCache
_logger = logging.getLogger(__name__)
MarathonEventTooltipData = namedtuple('MarathonEventTooltipData', ('header', 'body',
                                                                   'bodyExtra', 'bodyExtraSmart',
                                                                   'errorBattleType',
                                                                   'errorVehType',
                                                                   'extraStateSteps',
                                                                   'extraStateDiscount',
                                                                   'extraStateCompleted',
                                                                   'stateStart',
                                                                   'stateEnd', 'stateProgress',
                                                                   'stateComplete',
                                                                   'daysShort', 'hoursShort',
                                                                   'minutesShort',
                                                                   'previewAnnounce',
                                                                   'previewInProgress'))
MarathonEventIconsData = namedtuple('MarathonEventIconsData', ('tooltipHeader', 'libraryOkIcon',
                                                               'okIcon', 'timeIcon',
                                                               'timeIconGlow', 'alertIcon',
                                                               'iconFlag', 'libraryInProgress',
                                                               'saleIcon', 'mapFlagHeaderIcon'))
TIME_FORMAT_DAYS = 'days'
TIME_FORMAT_HOURS = 'hours'
TIME_FORMAT_TO_TIME_UNIT = {TIME_FORMAT_DAYS: ONE_DAY, 
   TIME_FORMAT_HOURS: ONE_HOUR}
_R_BUYING_PANEL = R.strings.marathon.vehiclePreview.buyingPanel
_R_TITLE_TOOLTIP = R.strings.marathon.vehiclePreview.title.tooltip
_TOKEN_COUNT_INDEX = 1
_MISSION_TAB_FORMAT = 'MISSIONS_TAB_{}'

class IMarathonEvent(object):
    onDataChanged = None

    def init(self):
        pass

    def fini(self):
        pass


class MarathonEventDataProvider(object):
    AWARD_TOKENS_POSTFIX = ('COMPLETE', 'PS_STOP')

    @property
    def prefix(self):
        return 'event_marathon'

    @property
    def tokenPrefix(self):
        return 'event_marathon'

    @property
    def urlName(self):
        return 'marathonUrl'

    @property
    def marathonCompleteUrlAdd(self):
        return 'overlay/'

    @property
    def label(self):
        label = R.strings.quests.missions.tab.label.dyn(self.prefix)
        if label.isValid():
            return label()
        return R.strings.quests.missions.tab.label.marathons()

    @property
    def backBtnLabel(self):
        label = R.strings.vehicle_preview.header.backBtn.descrLabel.dyn(self.prefix)
        if label.isValid():
            return label()
        return R.strings.vehicle_preview.header.backBtn.descrLabel.marathon()

    @property
    def tabTooltip(self):
        return getattr(QUESTS, _MISSION_TAB_FORMAT.format(self.prefix.upper()), QUESTS.MISSIONS_TAB_MARATHONS)

    @property
    def vehicleName(self):
        return ''

    @property
    def vehicleID(self):
        if not self.vehicleName:
            return 0
        return makeVehicleTypeCompDescrByName(self.vehicleName)

    @property
    def suspendPrefix(self):
        return ':suspend'

    @property
    def completedTokenPostfix(self):
        return '_PASS'

    @property
    def awardTokens(self):
        return tuple(('{}{}').format(self.tokenPrefix, postfix) for postfix in self.AWARD_TOKENS_POSTFIX)

    @property
    def hangarFlags(self):
        return 'flag_italy'

    @property
    def questsInChain(self):
        return 10

    @property
    def minVehicleLevel(self):
        return 6

    @property
    def tooltipHeaderType(self):
        return MARATHON_FLAG_TOOLTIP_HEADERS.COUNTDOWN

    @property
    def showFlagTooltipBottom(self):
        return True

    @property
    def flagTooltip(self):
        return TOOLTIPS_CONSTANTS.MARATHON_QUESTS_PREVIEW

    @property
    def disabledFlagTooltip(self):
        return TOOLTIPS.MARATHON_OFF

    @property
    def marathonTooltipHeader(self):
        return 'marathonTooltipHeader'

    @property
    def tooltips(self):
        body = self.__getTooltipString('body')
        error = self.__getTooltipString('error')
        state = self.__getTooltipString('state')
        extraState = self.__getTooltipString('extra_state')
        return MarathonEventTooltipData(header=self.__getTooltipString('header')(), body=body(), bodyExtra=body.extra(), bodyExtraSmart=body.extra_smart(), errorBattleType=error.battle_type(), errorVehType=error.veh_type(), extraStateSteps=extraState.steps(), extraStateDiscount=extraState.discount(), extraStateCompleted=extraState.completed(), stateStart=state.start(), stateEnd=state.end(), stateProgress=extraState(), stateComplete=state.complete(), daysShort=R.strings.tooltips.template.days.short(), hoursShort=R.strings.tooltips.template.hours.short(), minutesShort=R.strings.tooltips.template.minutes.short(), previewAnnounce=self.__getVehiclePreviewBodyString('announce')(), previewInProgress=self.__getVehiclePreviewBodyString('inprogress')())

    @property
    def icons(self):
        return MarathonEventIconsData(tooltipHeader=backport.image(R.images.gui.maps.icons.quests.dyn(self.marathonTooltipHeader)()), libraryOkIcon=backport.image(R.images.gui.maps.icons.library.okIcon()), okIcon=backport.image(self.__getIconsResource('ok_icon')()), timeIcon=backport.image(self.__getIconsResource('time_icon')()), timeIconGlow=backport.image(self.__getIconsResource('time_icon_glow')()), alertIcon=backport.image(self.__getIconsResource('alert_icon')()), iconFlag=backport.image(self.__getIconsResource('icon_flag')()), libraryInProgress=backport.image(R.images.gui.maps.icons.library.inProgressIcon()), saleIcon=backport.image(self.__getIconsResource('sale_icon')()), mapFlagHeaderIcon={MARATHON_STATE.ENABLED_STATE: backport.image(self.__getIconsResource('cup_icon')()), 
           MARATHON_STATE.DISABLED_STATE: backport.image(self.__getIconsResource('cup_disable_icon')())})

    @property
    def infoBody(self):
        marathonBody = _R_TITLE_TOOLTIP.info.dyn(self.prefix)
        if marathonBody.isValid():
            return marathonBody.body
        return _R_TITLE_TOOLTIP.info.body

    @property
    def bodyAddInfo(self):
        return _R_TITLE_TOOLTIP.body.addInfo

    def doesShowInPostBattle(self):
        return True

    def doesShowRewardVideo(self):
        return False

    def doesShowRewardScreen(self):
        return False

    def doesShowMissionsTab(self):
        return True

    def __getResouce(self, obj, attr):
        resourceObj = obj.dyn(self.prefix)
        if resourceObj.isValid():
            string = resourceObj.dyn(attr)
            if string.isValid():
                return string
        return obj.marathon.dyn(attr)

    def __getTooltipString(self, attr):
        return self.__getResouce(R.strings.tooltips, attr)

    def __getVehiclePreviewBodyString(self, attr):
        return self.__getResouce(R.strings.marathon.vehiclePreview.title.tooltip.body, attr)

    def __getIconsResource(self, attr):
        return self.__getResouce(R.images.gui.maps.icons.library, attr)


class MarathonEvent(IMarathonEvent, MarathonEventDataProvider):
    _eventsCache = dependency.descriptor(IEventsCache)
    _bootcamp = dependency.descriptor(IBootcampController)
    _lobbyContext = dependency.descriptor(ILobbyContext)

    def __init__(self):
        super(MarathonEvent, self).__init__()
        self.__isEnabled = False
        self.__isAvailable = False
        self.__rewardObtained = False
        self.__state = ''
        self.__suspendFlag = False
        self.__quest = None
        self.__group = None
        self.__urlMacros = URLMacros()
        return

    @async
    @process
    def getUrl(self, callback):
        url = yield self.__urlMacros.parse(self._getUrl())
        callback(url)

    @async
    @process
    def getMarathonVehicleUrl(self, callback):
        url = yield self.__urlMacros.parse(self._getUrl(urlType=MarathonConfig.REWARD_VEHICLE_URL))
        callback(url)

    def getFinishSaleTime(self):
        return self._lobbyContext.getServerSettings().getMarathonConfig()[MarathonConfig.FINISH_SALE_TIME]

    def doesShowMissionsTab(self):
        return self.isEnabled()

    def getHangarFlag(self, state=None):
        return backport.image(R.images.gui.maps.icons.library.hangarFlag.dyn(self.hangarFlags)())

    @prbEntityProperty
    def prbEntity(self):
        return

    def isEnabled(self):
        return self.__isEnabled and not self._bootcamp.isInBootcamp()

    def isAvailable(self):
        return self.__isAvailable

    def getQuestsData(self, prefix=None, postfix=None):
        return self.__getProgress('quests', prefix, postfix)

    def getTokensData(self, prefix=None, postfix=None):
        return self.__getProgress('tokens', prefix, postfix)

    def getMarathonProgress(self, byCompletedTokensCount=False):
        tokens = self.getTokensData(prefix=self.tokenPrefix, postfix=self.completedTokenPostfix)
        if byCompletedTokensCount:
            return (len(tokens), self.questsInChain)
        tokenPrefixLen = len(self.tokenPrefix)
        res = []
        for tokenNames in tokens.keys():
            name = str(tokenNames[tokenPrefixLen:])
            res.append(int(filter(str.isdigit, name)))

        currentStep = sorted(res)[(-1)] if res else 0
        return (currentStep, self.questsInChain)

    def getState(self):
        return self.__state

    def getTooltipHeader(self):
        if self.tooltipHeaderType == MARATHON_FLAG_TOOLTIP_HEADERS.PROGRESS:
            return self.getFormattedDaysStatus()
        if self.tooltipHeaderType == MARATHON_FLAG_TOOLTIP_HEADERS.COUNTDOWN:
            return self.getFormattedRemainingTime()
        if self.tooltipHeaderType == MARATHON_FLAG_TOOLTIP_HEADERS.TEXT:
            return self.getFormattedStartFinishText()
        return ('', '')

    def getMarathonFlagState(self, vehicle):
        return {'flagHeaderIcon': self.__getHangarFlagHeaderIcon(), 
           'flagStateIcon': self.__getHangarFlagStateIcon(vehicle), 
           'flagMain': self.getHangarFlag(self.__state), 
           'tooltip': self.__getTooltip(), 
           'enable': self.isAvailable(), 
           'visible': self.isEnabled()}

    def checkForWarnings(self, vehicle):
        wrongBattleType = self.prbEntity.getEntityType() != constants.ARENA_GUI_TYPE.RANDOM
        if wrongBattleType:
            return MARATHON_WARNING.WRONG_BATTLE_TYPE
        wrongVehicleLevel = vehicle.level < self.minVehicleLevel
        if wrongVehicleLevel:
            return MARATHON_WARNING.WRONG_VEH_TYPE
        return ''

    def isRewardObtained(self):
        return self.__rewardObtained

    def getMarathonQuests(self):
        return self._eventsCache.getHiddenQuests(self.__marathonFilterFunc)

    def getFormattedDaysStatus(self):
        icon = self.icons.iconFlag
        text = self.__getProgressInDays(self.__getTimeFromGroupStart())
        return (icon, text)

    def getFormattedRemainingTime(self):
        firstQuestStartTimeLeft, firstQuestFinishTimeLeft = self.__getQuestTimeInterval()
        if self.__state == MARATHON_STATE.NOT_STARTED:
            icon = self.icons.timeIconGlow
            text = self.__getTillTimeStart(firstQuestStartTimeLeft)
        elif self.__state == MARATHON_STATE.IN_PROGRESS:
            text = self.__getTillTimeEnd(firstQuestFinishTimeLeft)
            if firstQuestFinishTimeLeft > ONE_DAY:
                icon = self.icons.iconFlag
            else:
                icon = self.icons.timeIconGlow
        else:
            icon = self.icons.iconFlag
            text = text_styles.main(backport.text(self.tooltips.stateComplete))
        return (
         icon, text)

    def getFormattedStartFinishText(self):
        startDate, finishDate = self.__getGroupStartFinishTime()
        startDateStruct = getTimeStructInLocal(startDate)
        finishDateStruct = getTimeStructInLocal(finishDate)
        startDateText = text_styles.main(backport.text(TOOLTIPS.MARATHON_DATE, day=startDateStruct.tm_mday, month=i18n.makeString(MENU.datetime_months(startDateStruct.tm_mon)), hour=startDateStruct.tm_hour, minutes=i18n.makeString('%02d', startDateStruct.tm_min)))
        finishDateText = text_styles.main(backport.text(TOOLTIPS.MARATHON_DATE, day=finishDateStruct.tm_mday, month=i18n.makeString(MENU.datetime_months(finishDateStruct.tm_mon)), hour=finishDateStruct.tm_hour, minutes=i18n.makeString('%02d', finishDateStruct.tm_min)))
        text = text_styles.main(backport.text(TOOLTIPS.MARATHON_SUBTITLE, startDate=startDateText, finishDate=finishDateText))
        return ('', text)

    def getExtraTimeToBuy(self, timeFormat=TIME_FORMAT_DAYS):
        if self.__state == MARATHON_STATE.FINISHED:
            _, groupFinishTimeLeft = self.__getGroupTimeInterval()
            timeUnit = TIME_FORMAT_TO_TIME_UNIT[timeFormat]
            if groupFinishTimeLeft < timeUnit:
                groupFinishTimeLeft += timeUnit
            if timeFormat == TIME_FORMAT_HOURS:
                templateKey = self.tooltips.hoursShort
            else:
                templateKey = self.tooltips.daysShort
            fmtText = text_styles.neutral(backport.text(templateKey, value=str(int(groupFinishTimeLeft // timeUnit))))
            return fmtText
        return ''

    def getMarathonDiscount(self):
        passQuests, allQuests = self.getMarathonProgress()
        if passQuests and self.questsInChain:
            return int(passQuests * 100) / allQuests
        return 0

    def setState(self):
        if not self.__group:
            self.__isEnabled = False
            self.__isAvailable = False
            self.__state = MARATHON_STATE.UNKNOWN
            return self.__state
        if self.__suspendFlag:
            self.__state = MARATHON_STATE.SUSPENDED
            self.__isEnabled = True
            self.__isAvailable = False
            return self.__state
        groupStartTimeLeft, groupFinishTimeLeft = self.__getGroupTimeInterval()
        zeroTime = ZERO_TIME
        if groupStartTimeLeft > zeroTime or groupFinishTimeLeft <= zeroTime:
            self.__isEnabled = False
            self.__isAvailable = False
            self.__state = MARATHON_STATE.DISABLED
            return self.__state
        if groupStartTimeLeft <= zeroTime < groupFinishTimeLeft:
            self.__isEnabled = True
            self.__isAvailable = True
        firstQuestStartTimeLeft, firstQuestFinishTimeLeft = self.__getQuestTimeInterval()
        if firstQuestStartTimeLeft > zeroTime:
            self.__state = MARATHON_STATE.NOT_STARTED
        elif firstQuestStartTimeLeft <= zeroTime < firstQuestFinishTimeLeft:
            self.__state = MARATHON_STATE.IN_PROGRESS
        elif firstQuestFinishTimeLeft <= zeroTime < groupFinishTimeLeft:
            self.__state = MARATHON_STATE.FINISHED
        return self.__state

    def updateQuestsData(self):
        self.__suspendFlag = False
        quests = self._eventsCache.getHiddenQuests(self.__marathonFilterFunc)
        if quests:
            sortedQuests = sorted(quests.itervalues(), key=self.__findEarliestQuest)
            for q in quests:
                if self.suspendPrefix in q:
                    self.__suspendFlag = True
                    break

            currentStep, _ = self.getMarathonProgress()
            try:
                self.__quest = sortedQuests[(currentStep * 2)]
            except IndexError:
                self.__quest = sortedQuests[(-1)]

        else:
            self.__quest = None
        groups = self._eventsCache.getGroups(self.__marathonFilterFunc)
        if groups:
            sortedGroups = sorted(groups)
            self.__group = groups[sortedGroups[0]]
        else:
            self.__group = None
        tokens = self.getTokensData(prefix=self.tokenPrefix)
        rewardObtained = False
        for key in self.awardTokens:
            if key in tokens and tokens[key][_TOKEN_COUNT_INDEX] > 0:
                rewardObtained = True
                break

        self.__setRewardObtained(rewardObtained)
        return

    def getClosestStatusUpdateTime(self):
        if self.__state == MARATHON_STATE.NOT_STARTED:
            timeLeft, _ = self.__getQuestTimeInterval()
            return timeLeft + 1
        if self.__state == MARATHON_STATE.IN_PROGRESS:
            _, timeLeft = self.__getQuestTimeInterval()
            return timeLeft + 1
        if self.__state == MARATHON_STATE.FINISHED:
            _, timeLeft = self.__getGroupTimeInterval()
            return timeLeft
        return 0

    def showRewardVideo(self):
        videoShownKey = self.__getRewardShownMarkKey(MARATHON_VIDEO_WAS_SHOWN_PREFIX)
        if self.isRewardObtained() and self.doesShowRewardVideo() and not AccountSettings.getUIFlag(videoShownKey):
            showMarathonReward(self.vehicleID, videoShownKey)

    def showRewardScreen(self):
        if not self.doesShowRewardScreen():
            return
        if self.__state in MARATHON_STATE.DISABLED_STATE:
            return
        if self.isRewardObtained() and not AccountSettings.getUIFlag(self.__getRewardShownMarkKey(MARATHON_REWARD_WAS_SHOWN_PREFIX)):
            showBrowserOverlayView(self._getUrl() + self.marathonCompleteUrlAdd, alias=VIEW_ALIAS.BROWSER_OVERLAY, callbackOnLoad=partial(self.__setScreenWasShown, MARATHON_REWARD_WAS_SHOWN_PREFIX))

    def createMarathonWebHandlers(self):
        from gui.marathon.web_handlers import createDefaultMarathonWebHandlers
        return createDefaultMarathonWebHandlers()

    def getVehiclePreviewTitleTooltip(self):
        finishSaleTime = self.__getDateTimeText(self.getFinishSaleTime())
        questStartTime, _ = self.__getQuestStartFinishTime()
        questStartTimeText = self.__getDateTimeText(questStartTime)
        body = self.infoBody
        addInfo = self.bodyAddInfo
        if self.__state == MARATHON_STATE.NOT_STARTED:
            tooltipBody = body.announce()
            addInfo = backport.text(addInfo.announce(), addInfo=backport.text(self.tooltips.previewAnnounce, marathonStartDate=text_styles.neutral(questStartTimeText)))
            return self.__getPreviewInfoTooltip(tooltipBody, addInfo)
        if self.__state in (MARATHON_STATE.IN_PROGRESS, MARATHON_STATE.FINISHED):
            tooltipBody = body.progress.withDiscount() if self.getMarathonDiscount() else body.progress()
            endVehicleSellDate = text_styles.neutral(finishSaleTime)
            addInfo = backport.text(addInfo.progress(), endVehicleSellDate=endVehicleSellDate, addInfo=backport.text(self.tooltips.previewInProgress))
            return self.__getPreviewInfoTooltip(tooltipBody, addInfo)
        return makeTooltip()

    def getPreviewBuyBtnData(self):
        label = backport.text(_R_BUYING_PANEL.buyBtn.label.buy())
        enabled = False
        questStartTime, _ = self.__getQuestStartFinishTime()
        questStartTimeText = self.__getDateTimeText(questStartTime)
        customOffer = None
        addInfo = backport.text(self.tooltips.previewAnnounce, marathonStartDate=text_styles.neutral(questStartTimeText))
        tooltip = makeTooltip(header=backport.text(_R_BUYING_PANEL.buyBtn.tooltip.inactive.header()), body=backport.text(_R_BUYING_PANEL.buyBtn.tooltip.inactive.body(), addInfo=addInfo))
        if self.__state == MARATHON_STATE.IN_PROGRESS or self.__state == MARATHON_STATE.FINISHED:
            enabled = True
            tooltip = makeTooltip(body=backport.text(_R_BUYING_PANEL.buyBtn.tooltip.active.body()))
            if self.getMarathonDiscount():
                label = backport.text(_R_BUYING_PANEL.buyBtn.label.buyWithDiscount())
                discountText = text_styles.stats(backport.text(_R_BUYING_PANEL.customOffer.discount()))
                discountValue = text_styles.promoTitle((' {}').format(backport.text(R.strings.quests.action.discount.percent(), value=backport.getIntegralFormat(self.getMarathonDiscount()))))
                customOffer = ('').join((discountText, discountValue))
        return {'enabled': enabled, 'label': label, 
           'btnTooltip': tooltip, 
           'customOffer': customOffer}

    def _getUrl(self, urlType=MarathonConfig.URL):
        baseUrl = self._lobbyContext.getServerSettings().getMarathonConfig().get(urlType, MarathonConfig.EMPTY_PATH)
        if not baseUrl:
            _logger.warning('Marathon url from marathon_config.xml is absent or invalid: %s', baseUrl)
        return baseUrl

    def __getDateTimeText(self, dateTime):
        localDateTime = getTimeStructInLocal(dateTime)
        monthName = backport.text(R.strings.menu.dateTime.months.dyn(('c_{}').format(localDateTime.tm_mon))())
        dateTimeText = backport.text(R.strings.marathon.vehiclePreview.tooltip.dateTime(), day=localDateTime.tm_mday, monthName=monthName, year=localDateTime.tm_year, hour=localDateTime.tm_hour, min=('{min:02d}').format(min=localDateTime.tm_min))
        return self.__noWrapTextFormat(dateTimeText)

    def __getPreviewInfoTooltip(self, tooltipBody, addInfo):
        return makeTooltip(header=backport.text(R.strings.marathon.vehiclePreview.title.tooltip.header()), body=backport.text(tooltipBody, addInfo=addInfo))

    def __getRewardShownMarkKey(self, key):
        return ('_').join([key, self.tokenPrefix])

    def __setScreenWasShown(self, key):
        AccountSettings.setUIFlag(self.__getRewardShownMarkKey(key), True)

    def __setRewardObtained(self, obtained):
        self.__rewardObtained = obtained

    def __findEarliestQuest(self, quest):
        return quest.getStartTimeLeft()

    def __marathonFilterFunc(self, q):
        return q.getID().startswith(self.prefix)

    def __getProgress(self, progressType, prefix=None, postfix=None):
        progress = {}
        if progressType == 'quests':
            progress = self._eventsCache.questsProgress.getQuestsData()
        elif progressType == 'tokens':
            progress = self._eventsCache.questsProgress.getTokensData()
        if prefix:
            progress = {k:v for k, v in progress.iteritems() if k.startswith(prefix)}
        if postfix:
            progress = {k:v for k, v in progress.iteritems() if k.endswith(postfix)}
        return progress

    def __getHangarFlagHeaderIcon(self):
        for key, imgPath in self.icons.mapFlagHeaderIcon.iteritems():
            if self.__state in key:
                return imgPath

        return ''

    def __getHangarFlagStateIcon(self, vehicle):
        if self.__state not in MARATHON_STATE.ENABLED_STATE:
            return ''
        if self.isRewardObtained():
            return self.icons.okIcon
        if self.__state == MARATHON_STATE.NOT_STARTED:
            return self.icons.timeIcon
        if self.__state == MARATHON_STATE.IN_PROGRESS:
            warning = self.checkForWarnings(vehicle)
            if warning:
                return self.icons.alertIcon
            _, firstQuestFinishTimeLeft = self.__getQuestTimeInterval()
            if firstQuestFinishTimeLeft > ONE_DAY:
                return self.icons.iconFlag
            if firstQuestFinishTimeLeft <= ONE_DAY:
                return self.icons.timeIcon
        if self.__state == MARATHON_STATE.FINISHED:
            return self.icons.saleIcon
        return ''

    def __noWrapTextFormat(self, text):
        return text.replace(' ', '&nbsp;')

    def __getTillTimeEnd(self, value):
        return self.__getFormattedTillTimeString(value, self.tooltips.stateEnd)

    def __getTillTimeStart(self, value):
        return self.__getFormattedTillTimeString(value, self.tooltips.stateStart, extraFmt=True)

    def __getProgressInDays(self, value):
        return self.__getTextInDays(value, self.tooltips.stateProgress)

    def __getTextInDays(self, timeValue, keyNamespace):
        gmtime = time.gmtime(timeValue)
        text = text_styles.stats(backport.text(self.tooltips.daysShort, value=str(time.struct_time(gmtime).tm_yday)))
        return text_styles.main(backport.text(keyNamespace, value=text))

    def __getFormattedTillTimeString(self, timeValue, keyNamespace, extraFmt=False):
        gmtime = time.gmtime(timeValue)
        if timeValue >= ONE_DAY:
            text = backport.text(self.tooltips.daysShort, value=str(gmtime.tm_yday))
        else:
            if timeValue >= ONE_HOUR:
                text = backport.text(self.tooltips.hoursShort, value=str(gmtime.tm_hour + 1))
            else:
                text = backport.text(self.tooltips.minutesShort, value=str(gmtime.tm_min + 1))
            if extraFmt or timeValue >= ONE_DAY:
                return text_styles.main(backport.text(keyNamespace, value=text_styles.stats(text)))
        return text_styles.tutorial(backport.text(keyNamespace, value=text))

    def __getTooltip(self):
        if self.isAvailable():
            return self.flagTooltip
        return self.disabledFlagTooltip

    def __getTimeFromGroupStart(self):
        if self.__group:
            return self.__group.getTimeFromStartTillNow()
        return ZERO_TIME

    def __getGroupTimeInterval(self):
        if self.__group:
            return (self.__group.getStartTimeLeft(), self.__group.getFinishTimeLeft())
        return (ZERO_TIME, ZERO_TIME)

    def __getQuestTimeInterval(self):
        if self.__quest:
            return (self.__quest.getStartTimeLeft(), self.__quest.getFinishTimeLeft())
        return (ZERO_TIME, ZERO_TIME)

    def __getQuestStartFinishTime(self):
        if self.__quest:
            return (self.__quest.getStartTimeRaw(), self.__quest.getFinishTimeRaw())
        return (ZERO_TIME, ZERO_TIME)

    def __getGroupStartFinishTime(self):
        if self.__group:
            return (self.__group.getStartTimeRaw(), self.__group.getFinishTimeRaw())
        return (ZERO_TIME, ZERO_TIME)