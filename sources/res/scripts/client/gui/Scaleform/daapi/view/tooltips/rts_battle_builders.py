from gui.Scaleform.genConsts.TOOLTIPS_CONSTANTS import TOOLTIPS_CONSTANTS
from gui.shared.tooltips import contexts
from gui.shared.tooltips.rts import rts_battle_tooltip
from gui.shared.tooltips.builders import DataBuilder
__all__ = ('getTooltipBuilders', )

def getTooltipBuilders():
    return (
     DataBuilder(TOOLTIPS_CONSTANTS.RTS_ORDER_INFO, TOOLTIPS_CONSTANTS.BLOCKS_DEFAULT_UI, rts_battle_tooltip.RTSOrderTooltipData(contexts.ToolTipContext(None))),)