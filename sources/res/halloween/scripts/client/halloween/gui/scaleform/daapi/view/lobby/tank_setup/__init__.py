from halloween.gui.scaleform.genConsts.HALLOWEEN_CM_HANDLER_TYPE import HALLOWEEN_CM_HANDLER_TYPE
from halloween.gui.scaleform.daapi.view.lobby.tank_setup.context_menu.consumable import HWHangarConsumableSlotContextMenu

def getContextMenuHandlers():
    return (
     (
      HALLOWEEN_CM_HANDLER_TYPE.TANK_SETUP_HW_HANGAR_CONSUMABLE_SLOT, HWHangarConsumableSlotContextMenu),)


def getViewSettings():
    return ()


def getBusinessHandlers():
    return ()