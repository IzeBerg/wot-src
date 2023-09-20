from gui.Scaleform.genConsts.TOOLTIPS_CONSTANTS import TOOLTIPS_CONSTANTS
from gui.shared.tooltips import contexts, efficiency
from gui.shared.tooltips.builders import DataBuilder
__all__ = ('getTooltipBuilders', )

def getTooltipBuilders():
    return (
     DataBuilder(TOOLTIPS_CONSTANTS.EFFICIENCY_PARAM, TOOLTIPS_CONSTANTS.FINAL_STSTS_UI, efficiency.EfficiencyTooltipData(contexts.FinalStatisticContext())),
     DataBuilder(TOOLTIPS_CONSTANTS.TOTAL_EFFICIENCY_PARAM, TOOLTIPS_CONSTANTS.FINAL_STSTS_UI, efficiency.TotalEfficiencyTooltipData(contexts.FinalStatisticContext())))