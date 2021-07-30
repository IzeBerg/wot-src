from gui.Scaleform.genConsts.TOOLTIPS_CONSTANTS import TOOLTIPS_CONSTANTS
from gui.shared.tooltips import contexts
from gui.shared.tooltips.builders import DataBuilder
from gui.shared.tooltips.epic_battle.epic_battle_tooltips import EpicRankUnlockTooltipData
__all__ = ('getTooltipBuilders', )

def getTooltipBuilders():
    return (
     DataBuilder(TOOLTIPS_CONSTANTS.EPIC_RANK_UNLOCK_INFO, TOOLTIPS_CONSTANTS.BLOCKS_DEFAULT_UI, EpicRankUnlockTooltipData(contexts.ToolTipContext(None))),)