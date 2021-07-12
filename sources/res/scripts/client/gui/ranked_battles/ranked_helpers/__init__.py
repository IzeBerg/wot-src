import logging, typing
from collections import namedtuple
from gui.impl import backport
from gui.impl.gen import R
from gui.periodic_battles.models import CalendarStatusVO
from gui.ranked_battles.constants import RANKED_QUEST_ID_PREFIX, PrimeTimeStatus, RankedTokenQuestPostfix, LOBBY_SUB_LANDING_PARAM, SEASON_RATING_PARAM, AlertTypes
from gui.Scaleform.genConsts.RANKEDBATTLES_ALIASES import RANKEDBATTLES_ALIASES
from gui.Scaleform.genConsts.TOOLTIPS_CONSTANTS import TOOLTIPS_CONSTANTS
from gui.shared.utils.functions import makeTooltip
from gui.shared.formatters import text_styles
from gui.shared.formatters.ranges import toRomanRangeString
from helpers import dependency, time_utils
from skeletons.connection_mgr import IConnectionManager
from skeletons.gui.game_control import IRankedBattlesController
from skeletons.gui.lobby_context import ILobbyContext
_logger = logging.getLogger(__name__)
_AlertMessage = namedtuple('_AlertMessage', 'alertType, alertStr, buttonVisible')

def getBonusBattlesLabel(bonusBattlesCount):
    label = ''
    if bonusBattlesCount:
        label = backport.text(R.strings.ranked_battles.rankedBattleMainView.bonusBattles(), battlesCount=bonusBattlesCount)
    return label


def getBonusMultiplierLabel():
    bonusMultiplier = dependency.instance(IRankedBattlesController).getBonusBattlesMultiplier()
    label = ''
    if bonusMultiplier > 0:
        label = backport.text(R.strings.ranked_battles.rankedBattlesWidget.bonusMultiplier(), count=bonusMultiplier)
    return label


def getBonusBattlesIncome(resRoot, stepsCount, efficiencyCount, isStepsDaily):
    forEfficiencyStr = ''
    if efficiencyCount > 0:
        forEfficiencyStr = backport.text(resRoot.efficiency(), amount=text_styles.neutral(efficiencyCount))
    forStepsStr = ''
    stepsKey = 'daily' if isStepsDaily else 'persistent'
    if stepsCount > 0:
        forStepsStr = backport.text(resRoot.steps.dyn(stepsKey)(), amount=text_styles.neutral(stepsCount))
    if forEfficiencyStr or forStepsStr:
        return text_styles.concatStylesToSingleLine(forEfficiencyStr, forStepsStr)
    return ''


def getAlertStatusVO():
    rankedController = dependency.instance(IRankedBattlesController)
    alertMessage = _getAlertMessage()
    buttonLabelResID = R.strings.ranked_battles.alertMessage.button.moreInfo()
    if alertMessage.alertType == AlertTypes.PRIME:
        buttonLabelResID = R.strings.ranked_battles.alertMessage.button.changeServer()
    if alertMessage.alertType == AlertTypes.VEHICLE:
        minLvl, maxLvl = rankedController.getSuitableVehicleLevels()
        if rankedController.vehicleIsAvailableForBuy():
            reason = R.strings.ranked_battles.rankedBattlesUnreachableView.vehicleAvailableForBuy()
        elif rankedController.vehicleIsAvailableForRestore():
            reason = R.strings.ranked_battles.rankedBattlesUnreachableView.vehicleAvailableForRestore()
        else:
            reason = R.strings.ranked_battles.rankedBattlesUnreachableView.vehicleUnavailable()
        tooltip = makeTooltip(body=backport.text(reason, levels=toRomanRangeString(range(minLvl, maxLvl + 1))))
    else:
        tooltip = TOOLTIPS_CONSTANTS.RANKED_CALENDAR_DAY_INFO
    return CalendarStatusVO(alertIcon=backport.image(R.images.gui.maps.icons.library.alertBigIcon()) if alertMessage.alertType != AlertTypes.SEASON else None, buttonIcon='', buttonLabel=backport.text(buttonLabelResID), buttonVisible=alertMessage.buttonVisible, buttonTooltip=None, statusText=text_styles.vehicleStatusCriticalText(alertMessage.alertStr), popoverAlias=None, bgVisible=True, shadowFilterVisible=alertMessage.alertType != AlertTypes.SEASON, tooltip=tooltip, isSimpleTooltip=alertMessage.alertType == AlertTypes.VEHICLE)


def _getAlertMessage():
    rankedController = dependency.instance(IRankedBattlesController)
    if not rankedController.hasSuitableVehicles():
        minLvl, maxLvl = rankedController.getSuitableVehicleLevels()
        alertStr = backport.text(R.strings.ranked_battles.alertMessage.unsuitableVehicles(), levels=toRomanRangeString(range(minLvl, maxLvl + 1)))
        return _AlertMessage(AlertTypes.VEHICLE, alertStr, True)
    connectionMgr = dependency.instance(IConnectionManager)
    hasAvailableServers = rankedController.hasAvailablePrimeTimeServers()
    hasConfiguredServers = rankedController.hasConfiguredPrimeTimeServers()
    status, _, _ = rankedController.getPrimeTimeStatus()
    if hasAvailableServers:
        if status in (PrimeTimeStatus.NOT_SET, PrimeTimeStatus.FROZEN):
            alertStr = backport.text(R.strings.ranked_battles.alertMessage.unsuitablePeriphery(), serverName=connectionMgr.serverUserNameShort)
            return _AlertMessage(AlertTypes.PRIME, alertStr, True)
        alertStr = backport.text(R.strings.ranked_battles.alertMessage.somePeripheriesHalt(), serverName=connectionMgr.serverUserNameShort)
        return _AlertMessage(AlertTypes.PRIME, alertStr, True)
    currSeason = rankedController.getCurrentSeason()
    currTime = time_utils.getCurrentLocalServerTimestamp()
    if currSeason:
        if status in (PrimeTimeStatus.NOT_SET, PrimeTimeStatus.FROZEN):
            alertStr = backport.text(R.strings.ranked_battles.alertMessage.unsuitablePeriphery(), serverName=connectionMgr.serverUserNameShort)
            return _AlertMessage(AlertTypes.PRIME, alertStr, hasConfiguredServers)
        timeLeft = rankedController.getTimer()
        timeLeftStr = backport.getTillTimeStringByRClass(timeLeft, R.strings.ranked_battles.status.timeLeft)
        seasonsChangeTime = currSeason.getEndDate()
        if seasonsChangeTime and currTime + timeLeft >= seasonsChangeTime:
            alertStr = backport.text(R.strings.ranked_battles.alertMessage.seasonFinished(), seasonName=currSeason.getUserName())
            return _AlertMessage(AlertTypes.SEASON, alertStr, False)
        if connectionMgr.isStandalone():
            key = R.strings.ranked_battles.alertMessage.singleModeHalt()
        else:
            key = R.strings.ranked_battles.alertMessage.allPeripheriesHalt()
        alertStr = backport.text(key, time=timeLeftStr)
        return _AlertMessage(AlertTypes.PRIME, alertStr, False)
    _logger.warning('This codepoint should not be reached')
    return _AlertMessage(AlertTypes.SEASON, '', False)


@dependency.replace_none_kwargs(lobbyContext=ILobbyContext)
def getRankedBattlesSeasonRatingUrl(lobbyContext=None, spaID=None):
    url = lobbyContext.getServerSettings().rankedBattles.seasonRatingPageUrl
    params = SEASON_RATING_PARAM.format(spaID)
    if spaID is not None:
        return url + params
    else:
        return url


@dependency.replace_none_kwargs(lobbyContext=ILobbyContext)
def getRankedBattlesInfoPageUrl(lobbyContext=None):
    return lobbyContext.getServerSettings().rankedBattles.infoPageUrl


@dependency.replace_none_kwargs(lobbyContext=ILobbyContext)
def getRankedBattlesIntroPageUrl(lobbyContext=None):
    return lobbyContext.getServerSettings().rankedBattles.introPageUrl


@dependency.replace_none_kwargs(lobbyContext=ILobbyContext)
def getRankedBattlesSeasonGapUrl(lobbyContext=None):
    return lobbyContext.getServerSettings().rankedBattles.seasonGapPageUrl


@dependency.replace_none_kwargs(lobbyContext=ILobbyContext)
def getRankedBattlesYearRatingUrl(lobbyContext=None, isLobbySub=False):
    url = lobbyContext.getServerSettings().rankedBattles.yearRatingPageUrl
    params = LOBBY_SUB_LANDING_PARAM + str(isLobbySub).lower()
    if url is not None:
        return url + params
    else:
        return


@dependency.replace_none_kwargs(lobbyContext=ILobbyContext)
def getRankedBattlesShopUrl(lobbyContext=None, isLobbySub=False):
    url = lobbyContext.getServerSettings().rankedBattles.shopPageUrl
    params = LOBBY_SUB_LANDING_PARAM + str(isLobbySub).lower()
    if url is not None:
        return url + params
    else:
        return


def isSeasonTokenQuest(questID):
    return questID.split('_')[(-1)] in (RankedTokenQuestPostfix.SPRINTER, RankedTokenQuestPostfix.COMMON)


def isFinalTokenQuest(questID):
    return questID.split('_')[(-1)] == RankedTokenQuestPostfix.FINAL


def isLeaderTokenQuest(questID):
    return questID.split('_')[(-1)] == RankedTokenQuestPostfix.LEADER


def getDataFromSeasonTokenQuestID(questID):
    seasonID, leagueID, postfix = questID.split('_')[-3:]
    if postfix not in (RankedTokenQuestPostfix.SPRINTER, RankedTokenQuestPostfix.COMMON):
        _logger.error('getDataFromSeasonTokenQuestID usage not for season token quest')
    return (
     int(seasonID), int(leagueID), postfix == RankedTokenQuestPostfix.SPRINTER)


def getDataFromFinalTokenQuestID(questID):
    points, postfix = questID.split('_')[-2:]
    if postfix != RankedTokenQuestPostfix.FINAL:
        _logger.error('getDataFromFinalTokenQuestID usage only for final token quest')
    return int(points)


def getShieldSizeByRankSize(rankSize):
    if rankSize in RANKEDBATTLES_ALIASES.SHIELD_HUGE_SIZES:
        return RANKEDBATTLES_ALIASES.WIDGET_HUGE
    return RANKEDBATTLES_ALIASES.WIDGET_MEDIUM


def isRankedQuestID(questID):
    return questID.startswith(RANKED_QUEST_ID_PREFIX)


def makeStatTooltip(statKey):
    header = backport.text(R.strings.tooltips.rankedBattleView.stats.dyn(statKey).header())
    body = backport.text(R.strings.tooltips.rankedBattleView.stats.dyn(statKey).body())
    return makeTooltip(header, body)