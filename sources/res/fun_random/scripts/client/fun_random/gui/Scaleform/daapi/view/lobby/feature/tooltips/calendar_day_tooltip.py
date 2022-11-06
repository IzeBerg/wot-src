from fun_random.gui.shared.tooltips import TooltipType
from gui.impl.gen import R
from gui.shared.tooltips.periodic.calendar_day import PeriodicCalendarDayTooltip
from helpers import dependency
from skeletons.gui.game_control import IFunRandomController

class FunRandomCalendarDayTooltip(PeriodicCalendarDayTooltip):
    _TOOLTIP_TYPE = TooltipType.FUN_RANDOM
    _RES_ROOT = R.strings.fun_random.calendarDay
    _controller = dependency.descriptor(IFunRandomController)