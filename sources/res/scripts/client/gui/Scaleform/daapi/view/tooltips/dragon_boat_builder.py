from gui.Scaleform.genConsts.TOOLTIPS_CONSTANTS import TOOLTIPS_CONSTANTS
from gui.shared.tooltips import contexts, dragon_boat
from gui.shared.tooltips.builders import DataBuilder
__all__ = ('getTooltipBuilders', )

def getTooltipBuilders():
    return (
     DataBuilder(TOOLTIPS_CONSTANTS.DRAGON_BOAT_POINTS_INFO, TOOLTIPS_CONSTANTS.BLOCKS_DEFAULT_UI, dragon_boat.DragonBoatPointsTooltipData(contexts.ToolTipContext(None))),)