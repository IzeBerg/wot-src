from gui.impl.gen import R
from gui.shared.tooltips import TOOLTIP_TYPE
from gui.shared.tooltips.periodic.calendar_day import PeriodicCalendarDayTooltip
from helpers import dependency
from skeletons.gui.game_control import IRTSBattlesController

class RtsCalendarDayTooltip(PeriodicCalendarDayTooltip):
    _RES_ROOT = R.strings.rts_battles.calendarDay
    _TOOLTIP_TYPE = TOOLTIP_TYPE.RTS_CALENDAR_DAY
    _controller = dependency.descriptor(IRTSBattlesController)