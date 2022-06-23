from frameworks.wulf import WindowLayer
from gui.Scaleform.daapi.settings.views import VIEW_ALIAS
from gui.Scaleform.daapi.view.lobby.storage.customization.customization_cm_handlers import CustomizationCMHandler
from gui.Scaleform.daapi.view.lobby.storage.customization.customization_view import StorageCategoryCustomizationView
from gui.Scaleform.daapi.view.common.filter_popover import StorageBlueprintsFilterPopover
from gui.Scaleform.daapi.view.lobby.storage.blueprints.blueprints_cm_handlers import BlueprintsCMHandler
from gui.Scaleform.daapi.view.lobby.storage.blueprints.blueprints_storage_view import StorageCategoryBlueprintsView
from gui.Scaleform.daapi.view.lobby.storage.forsell.for_sell_view import StorageCategoryForSellView
from gui.Scaleform.daapi.view.lobby.storage.forsell.forsell_cm_handlers import ForSellCMHandler
from gui.Scaleform.daapi.view.lobby.storage.inhangar.all_vehicles_tab import AllVehiclesTabView
from gui.Scaleform.daapi.view.lobby.storage.inhangar.in_hangar_view import StorageCategoryInHangarView
from gui.Scaleform.daapi.view.lobby.storage.inhangar.in_hangar_view import StorageVehicleFilterPopover
from gui.Scaleform.daapi.view.lobby.storage.inhangar.inhangar_cm_handlers import VehiclesRegularCMHandler
from gui.Scaleform.daapi.view.lobby.storage.inhangar.inhangar_cm_handlers import VehiclesRestoreCMHandler
from gui.Scaleform.daapi.view.lobby.storage.inhangar.inhangar_cm_handlers import VehiclesRentedCMHandler
from gui.Scaleform.daapi.view.lobby.storage.inhangar.rent_vehicles_tab import RentVehiclesTabView
from gui.Scaleform.daapi.view.lobby.storage.inhangar.restore_vehicles_tab import RestoreVehiclesTabView
from gui.Scaleform.daapi.view.lobby.storage.inventory.consumables_tab import ConsumablesTabView
from gui.Scaleform.daapi.view.lobby.storage.inventory.inventory_cm_handlers import ModulesShellsCMHandler, ModulesShellsNoSaleCMHandler, DemountKitsCMHandler, RecertificationFormsCMHandler
from gui.Scaleform.daapi.view.lobby.storage.inventory.inventory_cm_handlers import EquipmentCMHandler
from gui.Scaleform.daapi.view.lobby.storage.inventory.inventory_cm_handlers import BattleBoostersCMHandler
from gui.Scaleform.daapi.view.lobby.storage.inventory.inventory_cm_handlers import OptionalDeviceCMHandler
from gui.Scaleform.daapi.view.lobby.storage.inventory.inventory_view import InventoryCategoryStorageView
from gui.Scaleform.daapi.view.lobby.storage.inventory.modules_tab import ModulesTabView
from gui.Scaleform.daapi.view.lobby.storage.inventory.opt_devices_tab import OptDevicesTabView
from gui.Scaleform.daapi.view.lobby.storage.inventory.regular_items_tab import RegularItemsTabView
from gui.Scaleform.daapi.view.lobby.storage.inventory.select_vehicle_popover import VehicleSelectPopover
from gui.Scaleform.daapi.view.lobby.storage.inventory.shells_tab import ShellsTabView
from gui.Scaleform.daapi.view.lobby.storage.inventory.crew_books_tab import CrewBooksTabView
from gui.Scaleform.daapi.view.lobby.storage.offers.offers_view import StorageCategoryOffersView
from gui.Scaleform.daapi.view.lobby.storage.personalreserves.boosters_cm_handlers import PersonalReservesCMHandler
from gui.Scaleform.daapi.view.lobby.storage.personalreserves.boosters_view import StorageCategoryPersonalReservesView
from gui.Scaleform.framework import ViewSettings, ScopeTemplates, GroupedViewSettings, ComponentSettings
from gui.Scaleform.framework.package_layout import PackageBusinessHandler
from gui.Scaleform.genConsts.CONTEXT_MENU_HANDLER_TYPE import CONTEXT_MENU_HANDLER_TYPE
from gui.Scaleform.genConsts.STORAGE_CONSTANTS import STORAGE_CONSTANTS
from gui.Scaleform.locale.TOOLTIPS import TOOLTIPS
from gui.app_loader import settings as app_settings
from gui.shared import EVENT_BUS_SCOPE

def getContextMenuHandlers():
    return (
     (
      CONTEXT_MENU_HANDLER_TYPE.STORAGE_FOR_SELL_ITEM, ForSellCMHandler),
     (
      CONTEXT_MENU_HANDLER_TYPE.STORAGE_MODULES_SHELLS_ITEM, ModulesShellsCMHandler),
     (
      CONTEXT_MENU_HANDLER_TYPE.STORAGE_CREW_BOOKS_NO_SALE_ITEM, ModulesShellsNoSaleCMHandler),
     (
      CONTEXT_MENU_HANDLER_TYPE.STORAGE_EQUIPMENT_ITEM, EquipmentCMHandler),
     (
      CONTEXT_MENU_HANDLER_TYPE.STORAGE_OPTIONAL_DEVICE_ITEM, OptionalDeviceCMHandler),
     (
      CONTEXT_MENU_HANDLER_TYPE.STORAGE_BONS_ITEM, BattleBoostersCMHandler),
     (
      CONTEXT_MENU_HANDLER_TYPE.STORAGE_DEMOUNT_KIT_ITEM, DemountKitsCMHandler),
     (
      CONTEXT_MENU_HANDLER_TYPE.STORAGE_RECERTIFICATION_FORM_ITEM, RecertificationFormsCMHandler),
     (
      CONTEXT_MENU_HANDLER_TYPE.STORAGE_VEHICLES_REGULAR_ITEM, VehiclesRegularCMHandler),
     (
      CONTEXT_MENU_HANDLER_TYPE.STORAGE_VEHICLES_RESTORE_ITEM, VehiclesRestoreCMHandler),
     (
      CONTEXT_MENU_HANDLER_TYPE.STORAGE_VEHICLES_RENTED_ITEM, VehiclesRentedCMHandler),
     (
      CONTEXT_MENU_HANDLER_TYPE.STORAGE_PERSONAL_RESERVE_ITEM, PersonalReservesCMHandler),
     (
      CONTEXT_MENU_HANDLER_TYPE.STORAGE_CUSTOMZIZATION_ITEM, CustomizationCMHandler),
     (
      CONTEXT_MENU_HANDLER_TYPE.STORAGE_BLUEPRINTS_ITEM, BlueprintsCMHandler))


def getViewSettings():
    from gui.Scaleform.daapi.view.lobby.storage.storage_view import StorageView
    return (
     ViewSettings(VIEW_ALIAS.LOBBY_STORAGE, StorageView, 'storageView.swf', WindowLayer.SUB_VIEW, VIEW_ALIAS.LOBBY_STORAGE, ScopeTemplates.LOBBY_SUB_SCOPE),
     ComponentSettings(STORAGE_CONSTANTS.FOR_SELL_VIEW, StorageCategoryForSellView, ScopeTemplates.DEFAULT_SCOPE),
     ComponentSettings(STORAGE_CONSTANTS.IN_HANGAR_VIEW, StorageCategoryInHangarView, ScopeTemplates.DEFAULT_SCOPE),
     ComponentSettings(STORAGE_CONSTANTS.IN_HANGAR_ALL_VEHICLES_TAB, AllVehiclesTabView, ScopeTemplates.DEFAULT_SCOPE),
     ComponentSettings(STORAGE_CONSTANTS.IN_HANGAR_RESTORE_VEHICLES_TAB, RestoreVehiclesTabView, ScopeTemplates.DEFAULT_SCOPE),
     ComponentSettings(STORAGE_CONSTANTS.IN_HANGAR_RENT_VEHICLES_TAB, RentVehiclesTabView, ScopeTemplates.DEFAULT_SCOPE),
     ComponentSettings(STORAGE_CONSTANTS.STORAGE_VIEW, InventoryCategoryStorageView, ScopeTemplates.DEFAULT_SCOPE),
     ComponentSettings(STORAGE_CONSTANTS.STORAGE_REGULAR_ITEMS_TAB, RegularItemsTabView, ScopeTemplates.DEFAULT_SCOPE),
     ComponentSettings(STORAGE_CONSTANTS.STORAGE_CONSUMABLES_TAB, ConsumablesTabView, ScopeTemplates.DEFAULT_SCOPE),
     ComponentSettings(STORAGE_CONSTANTS.STORAGE_MODULES_TAB, ModulesTabView, ScopeTemplates.DEFAULT_SCOPE),
     ComponentSettings(STORAGE_CONSTANTS.STORAGE_SHELLS_TAB, ShellsTabView, ScopeTemplates.DEFAULT_SCOPE),
     ComponentSettings(STORAGE_CONSTANTS.STORAGE_DEVICES_TAB, OptDevicesTabView, ScopeTemplates.DEFAULT_SCOPE),
     ComponentSettings(STORAGE_CONSTANTS.STORAGE_CREW_BOOKS_TAB, CrewBooksTabView, ScopeTemplates.DEFAULT_SCOPE),
     ComponentSettings(STORAGE_CONSTANTS.PERSONAL_RESERVES_VIEW, StorageCategoryPersonalReservesView, ScopeTemplates.DEFAULT_SCOPE),
     GroupedViewSettings(VIEW_ALIAS.STORAGE_VEHICLES_FILTER_POPOVER, StorageVehicleFilterPopover, 'vehiclesFiltersPopoverView.swf', WindowLayer.WINDOW, VIEW_ALIAS.STORAGE_VEHICLES_FILTER_POPOVER, VIEW_ALIAS.STORAGE_VEHICLES_FILTER_POPOVER, ScopeTemplates.DEFAULT_SCOPE),
     ComponentSettings(STORAGE_CONSTANTS.BLUEPRINTS_VIEW, StorageCategoryBlueprintsView, ScopeTemplates.DEFAULT_SCOPE),
     GroupedViewSettings(VIEW_ALIAS.STORAGE_BLUEPRINTS_FILTER_POPOVER, StorageBlueprintsFilterPopover, 'vehiclesFiltersPopoverView.swf', WindowLayer.WINDOW, VIEW_ALIAS.STORAGE_VEHICLES_FILTER_POPOVER, VIEW_ALIAS.STORAGE_BLUEPRINTS_FILTER_POPOVER, ScopeTemplates.DEFAULT_SCOPE),
     GroupedViewSettings(VIEW_ALIAS.STORAGE_VEHICLE_SELECTOR_POPOVER, VehicleSelectPopover, 'storageVehicleSelectorPopover.swf', WindowLayer.WINDOW, VIEW_ALIAS.STORAGE_VEHICLE_SELECTOR_POPOVER, VIEW_ALIAS.STORAGE_VEHICLE_SELECTOR_POPOVER, ScopeTemplates.DEFAULT_SCOPE),
     ComponentSettings(STORAGE_CONSTANTS.CUSTOMIZATION_VIEW, StorageCategoryCustomizationView, ScopeTemplates.DEFAULT_SCOPE),
     ComponentSettings(STORAGE_CONSTANTS.OFFERS_VIEW, StorageCategoryOffersView, ScopeTemplates.DEFAULT_SCOPE))


def getSectionsList():
    return (
     {'id': STORAGE_CONSTANTS.FOR_SELL, 
        'linkage': STORAGE_CONSTANTS.FOR_SELL_VIEW, 
        'tooltip': TOOLTIPS.STORAGE_MAINMENU_FOR_SELL},
     {'id': STORAGE_CONSTANTS.STORAGE, 
        'linkage': STORAGE_CONSTANTS.STORAGE_VIEW, 
        'tooltip': TOOLTIPS.STORAGE_MAINMENU_STORAGE},
     {'id': STORAGE_CONSTANTS.BLUEPRINTS, 
        'linkage': STORAGE_CONSTANTS.BLUEPRINTS_VIEW, 
        'tooltip': TOOLTIPS.STORAGE_MAINMENU_BLUEPRINTS},
     {'id': STORAGE_CONSTANTS.IN_HANGAR, 
        'linkage': STORAGE_CONSTANTS.IN_HANGAR_VIEW, 
        'tooltip': TOOLTIPS.STORAGE_MAINMENU_IN_HANGAR},
     {'id': STORAGE_CONSTANTS.PERSONAL_RESERVES, 
        'linkage': STORAGE_CONSTANTS.PERSONAL_RESERVES_VIEW, 
        'tooltip': TOOLTIPS.STORAGE_MAINMENU_PERSONAL_RESERVES},
     {'id': STORAGE_CONSTANTS.CUSTOMIZATION, 
        'linkage': STORAGE_CONSTANTS.CUSTOMIZATION_VIEW, 
        'tooltip': TOOLTIPS.STORAGE_MAINMENU_CUSTOMIZATION},
     {'id': STORAGE_CONSTANTS.OFFERS, 
        'linkage': STORAGE_CONSTANTS.OFFERS_VIEW, 
        'tooltip': TOOLTIPS.STORAGE_MAINMENU_OFFERS})


def getBusinessHandlers():
    return (
     StoragePackageBusinessHandler(),)


class StoragePackageBusinessHandler(PackageBusinessHandler):

    def __init__(self):
        listeners = (
         (
          VIEW_ALIAS.LOBBY_STORAGE, self.loadViewByCtxEvent),
         (
          VIEW_ALIAS.STORAGE_VEHICLES_FILTER_POPOVER, self.loadViewByCtxEvent),
         (
          VIEW_ALIAS.STORAGE_BLUEPRINTS_FILTER_POPOVER, self.loadViewByCtxEvent),
         (
          VIEW_ALIAS.STORAGE_VEHICLE_SELECTOR_POPOVER, self.loadViewByCtxEvent))
        super(StoragePackageBusinessHandler, self).__init__(listeners, app_settings.APP_NAME_SPACE.SF_LOBBY, EVENT_BUS_SCOPE.LOBBY)