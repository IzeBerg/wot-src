from gui.Scaleform.daapi.view.meta.TradeOffWidgetMeta import TradeOffWidgetMeta
from gui.Scaleform.framework.entities.EventSystemEntity import EventSystemEntity
from gui.Scaleform.genConsts.TOOLTIPS_CONSTANTS import TOOLTIPS_CONSTANTS
from gui.Scaleform.locale.RES_ICONS import RES_ICONS
from gui.shop import showTradeOffOverlay
from gui.shared import events
from gui.shared.gui_items import Vehicle
from gui.shared.gui_items.Vehicle import getSmallIconPath
from gui.shared.items_cache import CACHE_SYNC_REASON
from helpers import dependency
from items import UNDEFINED_ITEM_CD
from skeletons.gui.app_loader import IAppLoader
from skeletons.gui.game_control import ITradeInController
from skeletons.gui.shared import IItemsCache
_DEFAULT_TRADE_IN_VEHICLE_LEVEL = 10

class TradeOffWidget(TradeOffWidgetMeta, EventSystemEntity):
    __tradeIn = dependency.descriptor(ITradeInController)
    __itemsCache = dependency.descriptor(IItemsCache)
    __appLoader = dependency.descriptor(IAppLoader)

    def __init__(self):
        super(TradeOffWidget, self).__init__()
        self.__toolTipMgr = self.__appLoader.getApp().getToolTipMgr()
        self.__tradeInVehicle = None
        return

    def setTradeInVehicle(self, tradeInVehicle):
        self.__tradeInVehicle = tradeInVehicle
        self.__setData(self.__tradeIn.getSelectedVehicleToSell())

    def onClick(self):
        if self.__tradeInVehicle is not None:
            self.__tradeIn.selectVehicleToBuy(self.__tradeInVehicle.intCD)
        showTradeOffOverlay()
        return

    def onResetClick(self):
        self.__tradeIn.selectVehicleToSell(UNDEFINED_ITEM_CD)

    def getTooltip(self):
        if self.__tradeIn.isEnabled() and bool(self.__tradeIn.getVehiclesToSell(False)):
            tooltipType = TOOLTIPS_CONSTANTS.TRADE_IN_INFO
            data = ''
        else:
            tooltipType = TOOLTIPS_CONSTANTS.TRADE_IN_INFO_NOT_AVAILABLE
            data = ''
        return {'type': tooltipType, 
           'data': data}

    def _populate(self):
        super(TradeOffWidget, self)._populate()
        self.__setData(self.__tradeIn.getSelectedVehicleToSell())
        self.addListener(events.VehicleBuyEvent.VEHICLE_SELECTED, self.__onTradeOffSelectedChanged)
        self.__itemsCache.onSyncCompleted += self.__onCacheSyncCompleted

    def _dispose(self):
        self.__itemsCache.onSyncCompleted -= self.__onCacheSyncCompleted
        self.removeListener(events.VehicleBuyEvent.VEHICLE_SELECTED, self.__onTradeOffSelectedChanged)
        super(TradeOffWidget, self)._dispose()

    def __onTradeOffSelectedChanged(self, _=None):
        self.__setData(self.__tradeIn.getSelectedVehicleToSell())

    def __setData(self, vehicle=None):
        self.as_setDataS(self.__createVO(vehicle))

    def __createVO(self, vehicle=None):
        vehiclesAvailable = False
        if self.__tradeInVehicle is not None:
            vehiclesAvailable = self.__tradeInVehicle.intCD in self.__tradeIn.getVehiclesToBuy(False)
        vo = {'showTradeOff': vehicle is None, 'available': vehiclesAvailable}
        if vehicle is not None:
            vo.update({'vehicleNationFlag': RES_ICONS.getTradeInNationFlag(vehicle.nationName), 
               'vehicleType': Vehicle.getTypeSmallIconPath(vehicle.type, vehicle.isElite), 
               'vehicleLevel': RES_ICONS.getLevelIcon(vehicle.level), 
               'vehicleIcon': getSmallIconPath(vehicle.name), 
               'vehicleTitle': vehicle.shortUserName})
        return vo

    def __onCacheSyncCompleted(self, updateReason, _=None):
        if updateReason in (CACHE_SYNC_REASON.SHOP_RESYNC, CACHE_SYNC_REASON.INVENTORY_RESYNC,
         CACHE_SYNC_REASON.CLIENT_UPDATE):
            veh = self.__tradeIn.getSelectedVehicleToSell()
            self.__setData(veh)