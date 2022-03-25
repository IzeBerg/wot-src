from collections import namedtuple
from gui.impl.gen import R
from gui.periodic_battles.models import AlertData, PeriodType, PeriodInfo
from gui.Scaleform.genConsts.TOOLTIPS_CONSTANTS import TOOLTIPS_CONSTANTS
RTSRoster = namedtuple('RTSRoster', 'vehicles supplies rtsManners')

class RTSAlertData(AlertData):
    _RES_ROOT = R.strings.rts_battles.alertMessage
    __PERIOD_TYPES_WITH_TOOLTIP = (
     PeriodType.NOT_AVAILABLE_END,
     PeriodType.NOT_AVAILABLE, PeriodType.STANDALONE_NOT_AVAILABLE, PeriodType.ALL_NOT_AVAILABLE)

    @classmethod
    def _getAlertLabelParams(cls, periodInfo):
        return periodInfo.getVO(withBNames=True, withBDeltas=True, deltaFmt=PeriodInfo.defaultDeltaFormatter(cls._RES_ROOT.timeLeft))

    @classmethod
    def _getTooltip(cls, periodInfo):
        if periodInfo.periodType in cls.__PERIOD_TYPES_WITH_TOOLTIP:
            return TOOLTIPS_CONSTANTS.RTS_CALENDAR_DAY_INFO
        else:
            return