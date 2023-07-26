from gui.Scaleform.genConsts.TOOLTIPS_CONSTANTS import TOOLTIPS_CONSTANTS
from gui.shared.tooltips import contexts, vehicle
from gui.shared.tooltips.builders import DataBuilder, TooltipWindowBuilder
from fun_random.gui.shared.tooltips.contexts import FunRandomCarouselContext
from fun_random.gui.shared.tooltips.vehicle_tooltip_wrapper import FunRandomVehicleTooltipWindowData
from fun_random.gui.Scaleform.daapi.view.lobby.feature.tooltips.calendar_day_tooltip import FunRandomCalendarDayTooltip, FunRandomModeSelectorCalendarTooltip
from fun_random.gui.Scaleform.daapi.view.lobby.feature.tooltips.rewards_tooltip import FunRandomRewardsTooltip
__all__ = ('getTooltipBuilders', )

def getTooltipBuilders():
    return (
     DataBuilder(TOOLTIPS_CONSTANTS.FUN_RANDOM_CALENDAR_DAY, TOOLTIPS_CONSTANTS.BLOCKS_DEFAULT_UI, FunRandomCalendarDayTooltip(contexts.ToolTipContext(None))),
     DataBuilder(TOOLTIPS_CONSTANTS.FUN_RANDOM_MODE_SELECTOR_CALENDAR_DAY, TOOLTIPS_CONSTANTS.BLOCKS_DEFAULT_UI, FunRandomModeSelectorCalendarTooltip(contexts.ToolTipContext(None))),
     DataBuilder(TOOLTIPS_CONSTANTS.FUN_RANDOM_CAROUSEL_VEHICLE, TOOLTIPS_CONSTANTS.VEHICLE_INFO_UI, vehicle.VehicleInfoTooltipData(FunRandomCarouselContext())),
     TooltipWindowBuilder(TOOLTIPS_CONSTANTS.FUN_RANDOM_VEHICLE, None, FunRandomVehicleTooltipWindowData(FunRandomCarouselContext())),
     DataBuilder(TOOLTIPS_CONSTANTS.FUN_RANDOM_REWARDS, TOOLTIPS_CONSTANTS.BLOCKS_DEFAULT_UI, FunRandomRewardsTooltip(contexts.ToolTipContext(None))))