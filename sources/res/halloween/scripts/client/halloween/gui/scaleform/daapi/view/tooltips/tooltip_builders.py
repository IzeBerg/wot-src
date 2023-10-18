from gui.shared.tooltips import contexts
from gui.shared.tooltips.builders import DataBuilder
from halloween.gui.halloween_gui_constants import HALLOWEEN_CAROUSEL_VEHICLE_TOOLTIP
from halloween.gui.scaleform.daapi.view.tooltips import event
from gui.Scaleform.genConsts.TOOLTIPS_CONSTANTS import TOOLTIPS_CONSTANTS
__all__ = ('getTooltipBuilders', )

def getTooltipBuilders():
    return (
     DataBuilder(HALLOWEEN_CAROUSEL_VEHICLE_TOOLTIP, TOOLTIPS_CONSTANTS.BLOCKS_DEFAULT_UI, event.EventVehicleInfoTooltipData(contexts.CarouselContext())),)