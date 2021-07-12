from gui.Scaleform.genConsts.TOOLTIPS_CONSTANTS import TOOLTIPS_CONSTANTS
from gui.shared.tooltips import contexts, crew_bundle
from gui.shared.tooltips.builders import DataBuilder
__all__ = ('getTooltipBuilders', )

def getTooltipBuilders():
    return (
     DataBuilder(TOOLTIPS_CONSTANTS.SHOP_CREW_BUNDLE, TOOLTIPS_CONSTANTS.BLOCKS_DEFAULT_UI, crew_bundle.CrewBundleTooltipData(contexts.ToolTipContext(None))),)