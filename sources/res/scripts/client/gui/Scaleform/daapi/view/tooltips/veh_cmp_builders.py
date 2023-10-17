from gui.Scaleform.genConsts.TOOLTIPS_CONSTANTS import TOOLTIPS_CONSTANTS
from gui.shared.tooltips import contexts
from gui.shared.tooltips import veh_cmp
from gui.shared.tooltips.builders import DataBuilder, TooltipWindowBuilder
__all__ = ('getTooltipBuilders', )

def getTooltipBuilders():
    return (
     DataBuilder(TOOLTIPS_CONSTANTS.VEH_CMP_CUSTOMIZATION, TOOLTIPS_CONSTANTS.VEH_CMP_CUSTOMIZATION_UI, veh_cmp.VehCmpCustomizationTooltip(contexts.HangarParamContext())),
     TooltipWindowBuilder(TOOLTIPS_CONSTANTS.VEH_CMP_SKILLS, None, veh_cmp.VehCmpSkillsTooltipBuilder(contexts.ToolTipContext(None))))