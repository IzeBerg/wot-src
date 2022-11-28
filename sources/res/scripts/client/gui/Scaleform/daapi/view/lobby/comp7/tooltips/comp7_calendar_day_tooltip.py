from gui.impl.gen import R
from gui.shared.tooltips import TOOLTIP_TYPE
from gui.shared.tooltips.periodic.calendar_day import PeriodicCalendarDayTooltip
from helpers import dependency
from skeletons.gui.game_control import IComp7Controller

class Comp7CalendarDayTooltip(PeriodicCalendarDayTooltip):
    _controller = dependency.descriptor(IComp7Controller)
    _TOOLTIP_TYPE = TOOLTIP_TYPE.COMP7_CALENDAR_DAY_INFO
    _RES_ROOT = R.strings.comp7.calendarDay

    def _getController(self, *_):
        return self._controller