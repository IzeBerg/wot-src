from gui.impl.gen import R
from helpers import dependency
from gui.shared.tooltips import TOOLTIP_TYPE
from skeletons.gui.game_control import IRankedBattlesController
from gui.shared.tooltips.periodic.calendar_day import PeriodicCalendarDayTooltip

class RankedCalendarDayTooltip(PeriodicCalendarDayTooltip):
    _RES_ROOT = R.strings.ranked_battles.calendarDay
    _TOOLTIP_TYPE = TOOLTIP_TYPE.RANKED_CALENDAR_DAY
    __rankedController = dependency.descriptor(IRankedBattlesController)

    def _getController(self, *_):
        return self.__rankedController