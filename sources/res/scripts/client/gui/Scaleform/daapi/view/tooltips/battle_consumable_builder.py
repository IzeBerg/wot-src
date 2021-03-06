from gui.Scaleform.genConsts.TOOLTIPS_CONSTANTS import TOOLTIPS_CONSTANTS
from gui.shared.tooltips import battle_consumable
from gui.shared.tooltips import contexts
from gui.shared.tooltips.builders import DataBuilder
__all__ = ('getTooltipBuilders', )

def getTooltipBuilders():
    return (
     DataBuilder(TOOLTIPS_CONSTANTS.BATTLE_CONSUMABLE, TOOLTIPS_CONSTANTS.BLOCKS_DEFAULT_UI, battle_consumable.BattleConsumableTooltipData(contexts.BattleConsumableContext())),)