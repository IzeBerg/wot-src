from gui.Scaleform.genConsts.TOOLTIPS_CONSTANTS import TOOLTIPS_CONSTANTS
from gui.shared.tooltips import contexts
from gui.shared.tooltips.builders import DataBuilder, DefaultFormatBuilder
from gui.shared.tooltips import trade_in, personal_trade_in
__all__ = ('getTooltipBuilders', )

def getTooltipBuilders():
    return (
     DataBuilder(TOOLTIPS_CONSTANTS.TRADE_IN_INFO, TOOLTIPS_CONSTANTS.BLOCKS_DEFAULT_UI, trade_in.TradeInInfoTooltipData(contexts.ToolTipContext(None))),
     DataBuilder(TOOLTIPS_CONSTANTS.PERSONAL_TRADE_IN_INFO, TOOLTIPS_CONSTANTS.BLOCKS_DEFAULT_UI, personal_trade_in.PersonalTradeInInfoTooltipData(contexts.ToolTipContext(None))),
     DefaultFormatBuilder(TOOLTIPS_CONSTANTS.TRADE_IN_INFO_NOT_AVAILABLE, TOOLTIPS_CONSTANTS.COMPLEX_UI, trade_in.TradeInInfoNotAvailableData(contexts.ToolTipContext(None))),
     DefaultFormatBuilder(TOOLTIPS_CONSTANTS.TRADE_IN_STATE_NOT_AVAILABLE, TOOLTIPS_CONSTANTS.COMPLEX_UI, trade_in.TradeInStateNotAvailableData(contexts.ToolTipContext(None))))