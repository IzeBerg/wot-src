from gui.Scaleform.genConsts.TOOLTIPS_CONSTANTS import TOOLTIPS_CONSTANTS
from gui.shared.tooltips import contexts, common
from gui.shared.tooltips.builders import DataBuilder
__all__ = ('getTooltipBuilders', )

def getTooltipBuilders():
    return (
     DataBuilder(TOOLTIPS_CONSTANTS.TOTAL_EFFICIENCY_PARAM, TOOLTIPS_CONSTANTS.FINAL_STSTS_UI, common.TotalEfficiencyTooltipData(contexts.FinalStatisticContext())),)