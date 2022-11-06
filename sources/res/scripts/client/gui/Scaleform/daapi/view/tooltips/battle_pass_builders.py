from gui.Scaleform.genConsts.TOOLTIPS_CONSTANTS import TOOLTIPS_CONSTANTS
from gui.shared.tooltips import contexts, battle_pass
from gui.shared.tooltips.builders import DataBuilder
__all__ = ('getTooltipBuilders', )

def getTooltipBuilders():
    return (
     DataBuilder(TOOLTIPS_CONSTANTS.BATTLE_PASS_GIFT_TOKEN, TOOLTIPS_CONSTANTS.BATTLE_PASS_GIFT_TOKEN_UI, battle_pass.BattlePassGiftTokenTooltipData(contexts.BattlePassGiftTokenContext())),
     DataBuilder(TOOLTIPS_CONSTANTS.BATTLE_PASS_POINTS, TOOLTIPS_CONSTANTS.BLOCKS_DEFAULT_UI, battle_pass.BattlePassPointsTooltipData(contexts.ToolTipContext(None))))