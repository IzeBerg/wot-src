import typing, logging
from gui.impl.lobby.rts.tooltips.rts_currency_tooltip_view import RTSCurrencyTooltipView
from gui.impl.gen.view_models.views.lobby.rts.rts_currency_view_model import CurrencyTypeEnum
_logger = logging.getLogger(__name__)

def createRTSCurrencyTooltipView(contentId, currencyTypeString):
    try:
        currencyType = CurrencyTypeEnum(currencyTypeString)
    except ValueError:
        _logger.warning('Tooltip arg (%s) is not a member of CurrencyTypeEnum. Possible members %s', currencyTypeString, [ c.value for c in CurrencyTypeEnum ])
        return

    return RTSCurrencyTooltipView(contentId, currencyType)