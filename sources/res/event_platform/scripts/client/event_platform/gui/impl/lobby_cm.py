from debug_utils import LOG_ERROR
from gui.Scaleform.daapi.view.lobby.hangar.hangar_cm_handlers import VehicleContextMenuHandler

class EPVehicleContextMenuHandler(VehicleContextMenuHandler):

    def __init__(self, cmProxy, ctx=None):
        LOG_ERROR('INIT -- EPVehicleContextMenuHandler')
        super(EPVehicleContextMenuHandler, self).__init__(cmProxy, ctx)