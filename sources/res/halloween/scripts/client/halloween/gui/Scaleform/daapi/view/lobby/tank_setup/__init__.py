from gui.Scaleform.genConsts.HANGAR_ALIASES import HANGAR_ALIASES
from gui.Scaleform.framework import ScopeTemplates, ComponentSettings
from halloween.gui.Scaleform.daapi.view.lobby.tank_setup.hw_ammunition_setup_view_veh_params import HWAmmunitionSetupViewVehicleParams
from halloween.gui.Scaleform.daapi.view.lobby.tank_setup.context_menu.consumable import HWConsumableItemContextMenu, HWConsumableSlotContextMenu, HangarHWConsumableSlotContextMenu, HWEquipmentCMHandler
from gui.Scaleform.genConsts.CONTEXT_MENU_HANDLER_TYPE import CONTEXT_MENU_HANDLER_TYPE

def getContextMenuHandlers():
    return (
     (
      CONTEXT_MENU_HANDLER_TYPE.TANK_SETUP_HW_CONSUMABLE_ITEM, HWConsumableItemContextMenu),
     (
      CONTEXT_MENU_HANDLER_TYPE.TANK_SETUP_HW_CONSUMABLE_SLOT, HWConsumableSlotContextMenu),
     (
      CONTEXT_MENU_HANDLER_TYPE.TANK_SETUP_HANGAR_HW_CONSUMABLE_SLOT, HangarHWConsumableSlotContextMenu),
     (
      CONTEXT_MENU_HANDLER_TYPE.STORAGE_EQUIPMENT_ITEM, HWEquipmentCMHandler))


def getViewSettings():
    return (
     ComponentSettings(HANGAR_ALIASES.AMMUNITION_SETUP_VIEW_VEHICLE_PARAMS, HWAmmunitionSetupViewVehicleParams, ScopeTemplates.DEFAULT_SCOPE),)


def getBusinessHandlers():
    return ()