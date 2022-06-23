from gui.impl.gen import R
from helpers import dependency
from gui.shared.tooltips import TOOLTIP_TYPE
from skeletons.gui.game_control import IFunRandomController
from gui.shared.tooltips.periodic.calendar_day import PeriodicCalendarDayTooltip

class FunRandomCalendarDayTooltip(PeriodicCalendarDayTooltip):
    _RES_ROOT = R.strings.fun_random.calendarDay
    _TOOLTIP_TYPE = TOOLTIP_TYPE.FUN_RANDOM_CALENDAR_DAY
    _controller = dependency.descriptor(IFunRandomController)