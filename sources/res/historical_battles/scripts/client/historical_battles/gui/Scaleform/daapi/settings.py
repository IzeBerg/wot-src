from constants_utils import ConstInjector
from gui.Scaleform.daapi.settings import views

class VIEW_ALIAS(views.VIEW_ALIAS, ConstInjector):
    _const_type = str
    HISTORICAL_BATTLES = 'historicalBattles'
    HISTORICAL_BATTLE_LOADING = 'historicalBattleLoading'
    HB_VEHICLE_PREVIEW = 'HBVehiclePreview'
    HB_MAIN_PRIZE = 'HBMainPrize'