from gui.Scaleform.genConsts.TOOLTIPS_CONSTANTS import TOOLTIPS_CONSTANTS
from gui.shared.tooltips import contexts
from gui.shared.tooltips.builders import DataBuilder
from gui.shared.tooltips.referral_program.awards import AwardsTooltipData
__all__ = ('getTooltipBuilders', )

def getTooltipBuilders():
    return (
     DataBuilder(TOOLTIPS_CONSTANTS.REFERRAL_AWARDS, TOOLTIPS_CONSTANTS.BLOCKS_DEFAULT_UI, AwardsTooltipData(contexts.ToolTipContext(None))),)