from fun_random.gui.feature.util.fun_mixins import FunSubModesWatcher
from fun_random.gui.shared.tooltips import TooltipType
from gui.impl.gen import R
from gui.shared.tooltips.periodic.calendar_day import PeriodicCalendarDayTooltip
from helpers.time_utils import ONE_DAY

class FunRandomCalendarDayTooltip(PeriodicCalendarDayTooltip, FunSubModesWatcher):
    _TOOLTIP_TYPE = TooltipType.FUN_RANDOM
    _RES_ROOT = R.strings.fun_random.calendarDay

    def _getController(self, *_):
        return self.getDesiredSubMode()


class FunRandomModeSelectorCalendarTooltip(FunRandomCalendarDayTooltip, FunSubModesWatcher):

    def _getController(self, subModeID=None, *_):
        if subModeID is None:
            return self._funRandomCtrl.subModesInfo
        else:
            return self.getSubMode(subModeID)

    def _isValidPrimeTimes(self, serversPeriodsMapping):
        periods = [ periods for serverPeriods in serversPeriodsMapping.values() for periods in serverPeriods ]
        return any([ period[1] - period[0] != ONE_DAY for period in periods ])