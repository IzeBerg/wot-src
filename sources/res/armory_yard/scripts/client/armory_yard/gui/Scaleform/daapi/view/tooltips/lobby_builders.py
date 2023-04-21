from gui.Scaleform.genConsts.TOOLTIPS_CONSTANTS import TOOLTIPS_CONSTANTS
from gui.shared.tooltips.builders import DataBuilder
from gui.shared.tooltips import contexts, vehicle
__all__ = ('getTooltipBuilders', )

def getTooltipBuilders():
    return (
     DataBuilder(TOOLTIPS_CONSTANTS.ARMORY_YARD_AWARD_VEHICLE, TOOLTIPS_CONSTANTS.VEHICLE_INFO_UI, vehicle.VehicleInfoTooltipData(contexts.AwardContext(simplifiedOnly=False))),)