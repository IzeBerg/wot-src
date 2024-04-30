from enum import Enum
import aih_constants
from historical_battles.gui.impl.gen.view_models.views.lobby.order_model import OrderType
MultiplierToOrderType = {1: OrderType.SMALL, 
   5: OrderType.SMALL, 
   10: OrderType.MEDIUM, 
   15: OrderType.BIG}

class CTRL_MODE_NAME(aih_constants.CTRL_MODE_NAME):
    AOE_MAP_CASE_ARCADE = 'aoeArcadeMapcase'


class InfoViewKeys(Enum):
    ORDER_INFO_X10_VIEW = 'OrderInfoX10View'