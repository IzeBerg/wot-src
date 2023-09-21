from gui.impl.lobby.buy_vehicle_view import BuyVehicleWindow
from gui.prb_control.settings import FUNCTIONAL_FLAG

def isHangarShallBeLoaded(ctx):
    flags = FUNCTIONAL_FLAG.LOAD_PAGE | FUNCTIONAL_FLAG.TRAINING
    return ctx and not ctx.hasFlags(flags) and not BuyVehicleWindow.getInstances()