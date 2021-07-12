from gui.Scaleform.genConsts.TOOLTIPS_CONSTANTS import TOOLTIPS_CONSTANTS
from gui.shared.tooltips import contexts
from gui.shared.tooltips.builders import DataBuilder
from gui.Scaleform.daapi.view.lobby.hangar.seniority_awards import SeniorityAwardsFlagTooltip
__all__ = ('getTooltipBuilders', )

def getTooltipBuilders():
    return (
     DataBuilder(TOOLTIPS_CONSTANTS.SENIORITY_FLAG, TOOLTIPS_CONSTANTS.BLOCKS_DEFAULT_UI, SeniorityAwardsFlagTooltip(contexts.HangarContext())),)