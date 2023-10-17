from gui.Scaleform.genConsts.CONTEXT_MENU_HANDLER_TYPE import CONTEXT_MENU_HANDLER_TYPE
from halloween.gui.scaleform.daapi.view.lobby.tank_setup.context_menu.consumable import HWHangarConsumableSlotContextMenu

def getContextMenuHandlers():
    return (
     (
      CONTEXT_MENU_HANDLER_TYPE.TANK_SETUP_HW_HANGAR_CONSUMABLE_SLOT, HWHangarConsumableSlotContextMenu),)


def getViewSettings():
    return ()


def getBusinessHandlers():
    return ()