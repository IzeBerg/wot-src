from gui.Scaleform.genConsts.TOOLTIPS_CONSTANTS import TOOLTIPS_CONSTANTS
from gui.shared.tooltips import contexts
from gui.shared.tooltips import elen
from gui.shared.tooltips.builders import DataBuilder
__all__ = ('getTooltipBuilders', )

def getTooltipBuilders():
    return (
     DataBuilder(TOOLTIPS_CONSTANTS.EVENT_QUESTS_PREVIEW, TOOLTIPS_CONSTANTS.BLOCKS_DEFAULT_UI, elen.ElenPreviewTooltipData(contexts.QuestsBoosterContext())),
     DataBuilder(TOOLTIPS_CONSTANTS.EVENT_BOARDS_BADGE, TOOLTIPS_CONSTANTS.BLOCKS_DEFAULT_UI, elen.BadgeTooltipData(contexts.ToolTipContext(None))),
     DataBuilder(TOOLTIPS_CONSTANTS.EVENT_BOARDS_BADGES_GROUP, TOOLTIPS_CONSTANTS.BLOCKS_DEFAULT_UI, elen.BabgesGroupTooltipData(contexts.QuestContext())))