from gui.Scaleform.genConsts.CURRENCIES_CONSTANTS import CURRENCIES_CONSTANTS
from gui.Scaleform.genConsts.TOOLTIPS_CONSTANTS import TOOLTIPS_CONSTANTS
from gui.shared.tooltips import contexts, advanced, demount_kits
from gui.shared.tooltips.builders import AdvancedDataBuilder, DefaultFormatBuilder
__all__ = ('getTooltipBuilders', )

def getTooltipBuilders():
    return (
     AdvancedDataBuilder(TOOLTIPS_CONSTANTS.AWARD_DEMOUNT_KIT, TOOLTIPS_CONSTANTS.BLOCKS_DEFAULT_UI, demount_kits.DemountKitToolTipData(contexts.DemountKitContext()), advanced.DemountKitTooltipAdvanced(contexts.DemountKitContext())),
     DefaultFormatBuilder(TOOLTIPS_CONSTANTS.NOT_ENOUGH_MONEY, TOOLTIPS_CONSTANTS.COMPLEX_UI, demount_kits.NotEnoughMoneyTooltipData(contexts.ToolTipContext(None))),
     AlternativeGoldTooltipBuilder(TOOLTIPS_CONSTANTS.GOLD_ALTERNATIVE_STATS, TOOLTIPS_CONSTANTS.BLOCKS_DEFAULT_UI, demount_kits.GoldStatsToolTipData(contexts.ToolTipContext(None)), advanced.MoneyAndXpAdvanced(contexts.ToolTipContext(None))),
     AlternativeGoldTooltipBuilder(TOOLTIPS_CONSTANTS.GOLD_ALTERNATIVE_INFO, TOOLTIPS_CONSTANTS.BLOCKS_DEFAULT_UI, demount_kits.GoldToolTipData(contexts.ToolTipContext(None)), advanced.MoneyAndXpAdvanced(contexts.ToolTipContext(None))))


class AlternativeGoldTooltipBuilder(AdvancedDataBuilder):
    __slots__ = ('__btnType', )

    def __init__(self, tooltipType, linkage, provider, adProvider):
        super(AlternativeGoldTooltipBuilder, self).__init__(tooltipType, linkage, provider, adProvider)
        self.__btnType = CURRENCIES_CONSTANTS.GOLD

    def _buildData(self, _advanced, *args, **kwargs):
        return super(AlternativeGoldTooltipBuilder, self)._buildData(_advanced, self.__btnType)