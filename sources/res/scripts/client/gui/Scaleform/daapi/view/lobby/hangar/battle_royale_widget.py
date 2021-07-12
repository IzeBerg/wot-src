from collections import namedtuple
from helpers import int2roman
from helpers import dependency
from gui.Scaleform.locale.EPIC_BATTLE import EPIC_BATTLE
from gui.Scaleform.genConsts.TOOLTIPS_CONSTANTS import TOOLTIPS_CONSTANTS
from gui.Scaleform.daapi.view.meta.BattleRoyaleHangarWidgetMeta import BattleRoyaleHangarWidgetMeta
from skeletons.gui.game_control import IBattleRoyaleController
from skeletons.connection_mgr import IConnectionManager
from gui.impl import backport
from gui.impl.gen.resources import R
from gui.periodic_battles.models import CalendarStatusVO
from gui.ranked_battles.constants import PrimeTimeStatus
from helpers import time_utils
from gui.shared import event_dispatcher
from gui.shared.formatters import text_styles
BattleRoyaleWidgetVO = namedtuple('EpicBattlesWidgetVO', ('calendarStatus', 'isSeasonActive',
                                                          'episode', 'tooltipId',
                                                          'showAlert'))

class BattleRoyaleHangarWidget(BattleRoyaleHangarWidgetMeta):
    __battleRoyaleController = dependency.descriptor(IBattleRoyaleController)
    __connectionMgr = dependency.descriptor(IConnectionManager)
    __slots__ = ()

    def onClick(self):
        self.__battleRoyaleController.openURL()

    def onChangeServerClick(self):
        event_dispatcher.showBattleRoyalePrimeTimeWindow()

    def update(self):
        currentSeason = self.__battleRoyaleController.getCurrentSeason()
        isSeasonActive = currentSeason is not None and self.__battleRoyaleController.getCurrentCycleInfo()[1]
        cycleNumber = 1
        if currentSeason:
            cycleNumber = self.__battleRoyaleController.getCurrentOrNextActiveCycleNumber(currentSeason)
        showAlert = not self.__battleRoyaleController.isInPrimeTime() and self.__battleRoyaleController.isEnabled()
        data = BattleRoyaleWidgetVO(calendarStatus=self.__getStatusBlock()._asdict(), isSeasonActive=isSeasonActive, episode=int2roman(cycleNumber), tooltipId=TOOLTIPS_CONSTANTS.BATTLE_ROYALE_WIDGET_INFO, showAlert=showAlert)._asdict()
        self.as_setDataS(data)
        return

    def __getStatusBlock(self):
        status, timeLeft, _ = self.__battleRoyaleController.getPrimeTimeStatus()
        showPrimeTimeAlert = status != PrimeTimeStatus.AVAILABLE
        hasAvailableServers = self.__battleRoyaleController.hasAvailablePrimeTimeServers()
        return CalendarStatusVO(alertIcon=backport.image(R.images.gui.maps.icons.library.alertBigIcon()) if showPrimeTimeAlert else None, buttonIcon='', buttonLabel=backport.text(R.strings.battle_royale.widgetAlertMessageBlock.button()), buttonVisible=showPrimeTimeAlert and hasAvailableServers, buttonTooltip=None, statusText=self.__getAlertStatusText(timeLeft, hasAvailableServers), popoverAlias=None, bgVisible=True, shadowFilterVisible=showPrimeTimeAlert, tooltip=None, isSimpleTooltip=False)

    def __getAlertStatusText(self, timeLeft, hasAvailableServers):
        rAlertMsgBlock = R.strings.battle_royale.widgetAlertMessageBlock
        alertStr = ''
        if hasAvailableServers:
            alertStr = backport.text(rAlertMsgBlock.somePeripheriesHalt(), serverName=self.__connectionMgr.serverUserNameShort)
        else:
            currSeason = self.__battleRoyaleController.getCurrentSeason()
            currTime = time_utils.getCurrentLocalServerTimestamp()
            primeTime = self.__battleRoyaleController.getPrimeTimes().get(self.__connectionMgr.peripheryID)
            isCycleNow = currSeason and currSeason.hasActiveCycle(currTime) and primeTime and primeTime.getPeriodsBetween(currTime, currSeason.getCycleEndDate())
            if isCycleNow:
                if self.__connectionMgr.isStandalone():
                    key = rAlertMsgBlock.singleModeHalt
                else:
                    key = rAlertMsgBlock.allPeripheriesHalt
                timeLeftStr = time_utils.getTillTimeString(timeLeft, EPIC_BATTLE.STATUS_TIMELEFT, removeLeadingZeros=True)
                alertStr = backport.text(key(), time=timeLeftStr)
            else:
                nextSeason = currSeason or self.__battleRoyaleController.getNextSeason()
                if nextSeason is not None:
                    nextCycle = nextSeason.getNextByTimeCycle(currTime)
                    if nextCycle is not None:
                        cycleNumber = nextCycle.getEpicCycleNumber()
                        timeLeftStr = time_utils.getTillTimeString(nextCycle.startDate - currTime, EPIC_BATTLE.STATUS_TIMELEFT, removeLeadingZeros=True)
                        alertStr = backport.text(rAlertMsgBlock.startIn.single() if nextSeason.isSingleCycleSeason() else rAlertMsgBlock.startIn.multi(), cycle=int2roman(cycleNumber), time=timeLeftStr)
                if not alertStr:
                    prevSeason = currSeason or self.__battleRoyaleController.getPreviousSeason()
                    if prevSeason is not None:
                        prevCycle = prevSeason.getLastActiveCycleInfo(currTime)
                        if prevCycle is not None:
                            cycleNumber = prevCycle.getEpicCycleNumber()
                            alertStr = backport.text(rAlertMsgBlock.noCycleMessage.single() if prevSeason.isSingleCycleSeason() else rAlertMsgBlock.noCycleMessage.multi(), cycle=int2roman(cycleNumber))
        return text_styles.vehicleStatusCriticalText(alertStr)