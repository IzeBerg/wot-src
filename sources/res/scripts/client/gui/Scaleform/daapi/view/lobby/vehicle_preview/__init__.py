from frameworks.wulf import WindowLayer
from gui.Scaleform.framework import ComponentSettings
from gui.Scaleform.framework.package_layout import PackageBusinessHandler
from gui.app_loader import settings as app_settings
from gui.Scaleform.daapi.settings.views import VIEW_ALIAS
from gui.shared import EVENT_BUS_SCOPE

def getContextMenuHandlers():
    return ()


def getViewSettings():
    from gui.Scaleform.daapi.view.lobby.hangar.VehicleParameters import VehiclePreviewParameters
    from gui.Scaleform.daapi.view.lobby.vehicle_preview.vehicle_preview_buying_panel import VehiclePreviewBuyingPanel
    from gui.Scaleform.daapi.view.lobby.vehicle_preview.info.trade_in_buying_panel import VehiclePreviewTradeInBuyingPanel
    from gui.Scaleform.daapi.view.lobby.vehicle_preview.info.vehicle_preview_personal_trade_in_buying_panel import VehiclePreviewPersonalTradeInBuyingPanel
    from gui.Scaleform.daapi.view.lobby.vehicle_preview.info.offer_gift_buying_panel import VehiclePreviewOfferGiftBuyingPanel
    from gui.Scaleform.daapi.view.lobby.vehicle_preview.info.browse_tab import VehiclePreviewBrowseTab
    from gui.Scaleform.daapi.view.lobby.vehicle_preview.info.modules_tab import VehiclePreviewModulesTab, ModulesPanel
    from gui.Scaleform.daapi.view.lobby.vehicle_preview.info.crew_tab import VehiclePreviewCrewTab
    from gui.Scaleform.daapi.view.lobby.vehicle_preview.pack_items_popover import PackItemsPopover
    from gui.Scaleform.daapi.view.lobby.trade_in.trade_off_widget import TradeOffWidget
    from gui.Scaleform.framework import ScopeTemplates, GroupedViewSettings
    from gui.Scaleform.genConsts.VEHPREVIEW_CONSTANTS import VEHPREVIEW_CONSTANTS
    from gui.Scaleform.daapi.view.lobby.vehicle_preview.info.progression_styles_buying_panel import VehiclePreviewProgressionStylesBuyingPanel
    from gui.Scaleform.daapi.view.lobby.vehicle_preview.wot_plus_vehicle_preview import VPWotPlusPanel
    return (
     ComponentSettings(VEHPREVIEW_CONSTANTS.PARAMETERS_PY_ALIAS, VehiclePreviewParameters, ScopeTemplates.DEFAULT_SCOPE),
     ComponentSettings(VEHPREVIEW_CONSTANTS.BUYING_PANEL_PY_ALIAS, VehiclePreviewBuyingPanel, ScopeTemplates.DEFAULT_SCOPE),
     ComponentSettings(VEHPREVIEW_CONSTANTS.TRADE_IN_BUYING_PANEL_PY_ALIAS, VehiclePreviewTradeInBuyingPanel, ScopeTemplates.DEFAULT_SCOPE),
     ComponentSettings(VEHPREVIEW_CONSTANTS.PROGRESSION_STYLES_BUYING_PANEL_PY_ALIAS, VehiclePreviewProgressionStylesBuyingPanel, ScopeTemplates.DEFAULT_SCOPE),
     ComponentSettings(VEHPREVIEW_CONSTANTS.PERSONAL_TRADE_IN_BUYING_PANEL_PY_ALIAS, VehiclePreviewPersonalTradeInBuyingPanel, ScopeTemplates.DEFAULT_SCOPE),
     ComponentSettings(VEHPREVIEW_CONSTANTS.OFFER_GIFT_BUYING_PANEL_PY_ALIAS, VehiclePreviewOfferGiftBuyingPanel, ScopeTemplates.DEFAULT_SCOPE),
     ComponentSettings(VEHPREVIEW_CONSTANTS.BROWSE_LINKAGE, VehiclePreviewBrowseTab, ScopeTemplates.DEFAULT_SCOPE),
     ComponentSettings(VEHPREVIEW_CONSTANTS.MODULES_LINKAGE, VehiclePreviewModulesTab, ScopeTemplates.DEFAULT_SCOPE),
     ComponentSettings(VEHPREVIEW_CONSTANTS.MODULES_PY_ALIAS, ModulesPanel, ScopeTemplates.DEFAULT_SCOPE),
     ComponentSettings(VEHPREVIEW_CONSTANTS.CREW_LINKAGE, VehiclePreviewCrewTab, ScopeTemplates.DEFAULT_SCOPE),
     GroupedViewSettings(VIEW_ALIAS.PACK_ITEM_POPOVER, PackItemsPopover, 'packItemsPopover.swf', WindowLayer.WINDOW, VIEW_ALIAS.PACK_ITEM_POPOVER, VIEW_ALIAS.PACK_ITEM_POPOVER, ScopeTemplates.DEFAULT_SCOPE),
     ComponentSettings(VEHPREVIEW_CONSTANTS.TRADE_OFF_WIDGET_ALIAS, TradeOffWidget, ScopeTemplates.DEFAULT_SCOPE),
     ComponentSettings(VEHPREVIEW_CONSTANTS.WOT_PLUS_PANEL_LINKAGE, VPWotPlusPanel, ScopeTemplates.DEFAULT_SCOPE))


def getBusinessHandlers():
    return (
     VehPreviewPackageBusinessHandler(),)


class VehPreviewPackageBusinessHandler(PackageBusinessHandler):

    def __init__(self):
        listeners = (
         (
          VIEW_ALIAS.PACK_ITEM_POPOVER, self.loadViewByCtxEvent),)
        super(VehPreviewPackageBusinessHandler, self).__init__(listeners, app_settings.APP_NAME_SPACE.SF_LOBBY, EVENT_BUS_SCOPE.LOBBY)