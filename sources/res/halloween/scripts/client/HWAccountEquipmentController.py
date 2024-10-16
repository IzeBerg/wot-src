import typing, logging, BigWorld, weakref, functools
from halloween_common import halloween_account_commands, halloween_constants
from CurrentVehicle import g_currentVehicle
from constants import IS_DEVELOPMENT
from items import vehicles
from PlayerEvents import g_playerEvents
from shared_utils.account_helpers.diff_utils import synchronizeDicts
from helpers import dependency
from skeletons.connection_mgr import IConnectionManager
from gui.shared.gui_items.vehicle_equipment import _ExpendableEquipment
from gui.shared.gui_items import GUI_ITEM_TYPE
from skeletons.gui.shared import IItemsCache
from gui.shared.utils.requesters import getDiffID
if typing.TYPE_CHECKING:
    from gui.shared.gui_items import Vehicle as GuiVehicle
_logger = logging.getLogger(__name__)

def getHWConsumables(vehicle):
    return BigWorld.player().HWAccountEquipmentController.getHWConsumables(vehicle)


def devSetLayout(layout, invID=None):
    if not IS_DEVELOPMENT:
        return
    BigWorld.player().HWAccountEquipmentController.devSetLayout(layout, invID)


def devSetAutoMaintenanceEnabled(isEnabled, invID=None):
    if not IS_DEVELOPMENT:
        return
    BigWorld.player().HWAccountEquipmentController.devSetAutoMaintenanceEnabled(isEnabled, invID)


class _HWConsumables(object):
    __slots__ = ('layout', 'installed', 'isAutoEquip')

    def __init__(self, layout, installed, isAutoEquip):
        super(_HWConsumables, self).__init__()
        self.layout = layout
        self.installed = installed
        self.isAutoEquip = isAutoEquip


class _HWExpendableEquipment(_ExpendableEquipment):
    __slots__ = ()

    def _createItem(self, intCD):
        if not intCD:
            return None
        else:
            return super(_HWExpendableEquipment, self)._createItem(intCD)


class HWInventorySessionCache(object):
    DATA_KEY = halloween_constants.HW_INVENTORY_PDATA_KEY
    inventoryCache = None
    defConsumablesCache = None

    @classmethod
    def hwInventory(cls):
        return cls.inventoryCache.get(cls.DATA_KEY, {})

    @classmethod
    def init(cls):
        if cls.inventoryCache is not None:
            return
        else:
            cls.inventoryCache = {}
            cls.defConsumablesCache = {}
            g_playerEvents.onClientSynchronize += cls._onClientSynchronize
            connectionMgr = dependency.instance(IConnectionManager)
            connectionMgr.onDisconnected += cls.__deleteInstance
            return

    @classmethod
    def getCachedEquipment(cls, obj, initializer):
        objID = id(obj)
        if objID not in cls.defConsumablesCache:
            cls.defConsumablesCache[objID] = (initializer(obj),
             weakref.ref(obj, functools.partial(cls.__delCachedEquipment, objID)))
        return cls.defConsumablesCache[objID][0]

    @classmethod
    def hwInventoryVehInvalidator(cls, params):
        for data in params.diff.get(cls.DATA_KEY, {}).itervalues():
            for vehInvID in data.iterkeys():
                vehData = params.inventory.getVehicleData(getDiffID(vehInvID))
                if vehData is not None:
                    params.invalidate[GUI_ITEM_TYPE.VEHICLE].add(vehData.descriptor.type.compactDescr)

        return

    @classmethod
    def _onClientSynchronize(cls, isFullSync, diff):
        cache = cls.inventoryCache
        if isFullSync:
            cache.clear()
            cls.defConsumablesCache.clear()
        dataResetKey = (cls.DATA_KEY, '_r')
        if dataResetKey in diff:
            cache[cls.DATA_KEY] = diff[dataResetKey]
        if cls.DATA_KEY in diff:
            synchronizeDicts(diff[cls.DATA_KEY], cache.setdefault(cls.DATA_KEY, {}))

    @classmethod
    def __deleteInstance(cls):
        cls.inventoryCache = None
        cls.defConsumablesCache = None
        g_playerEvents.onClientSynchronize -= cls._onClientSynchronize
        connectionMgr = dependency.instance(IConnectionManager)
        connectionMgr.onDisconnected -= cls.__deleteInstance
        return

    @classmethod
    def __delCachedEquipment(cls, objID, _):
        if cls.defConsumablesCache is not None:
            cls.defConsumablesCache.pop(objID, None)
        return


class HWAccountEquipmentController(BigWorld.StaticScriptComponent):
    EMPTY_LAYOUT = [
     0, 0, 0]
    itemsCache = dependency.descriptor(IItemsCache)

    def __init__(self):
        super(HWAccountEquipmentController, self).__init__()
        HWInventorySessionCache.init()
        self._vehObject = None
        self._vehInvID = None
        return

    @property
    def hwInventory(self):
        return HWInventorySessionCache.hwInventory()

    def getVehicleLayout(self, vehInvID):
        return self.hwInventory.get('layout', {}).get(vehInvID, self.EMPTY_LAYOUT)

    def getVehicleInventory(self, vehInvID):
        return self.hwInventory.get('eqs', {}).get(vehInvID, [])

    def getVehicleSettings(self, vehInvID):
        return self.hwInventory.get('settings', {}).get(vehInvID, {})

    def isVehicleAutoEquipEnabled(self, vehInvID):
        return self.getVehicleSettings(vehInvID).get('autoMaintenance', halloween_constants.HW_DEFAULT_AUTO_MAINTENANCE)

    def getHWConsumables(self, vehicle):
        return HWInventorySessionCache.getCachedEquipment(vehicle, self._createHWDefConsumables)

    def updateSelectedEquipment(self, vehInvID, eqList, callback=None):
        self.entity._doCmdIntArr(halloween_account_commands.CMD_UPDATE_SELECTED_HW_EQUIPMENT, [
         vehInvID] + eqList, callback)

    def setHwAutoMaintenanceEnabled(self, vehInvID, isEnabled, callback=None):
        self.entity._doCmdInt2(halloween_account_commands.CMD_SET_HW_AUTO_MAINTENANCE_ENABLED, vehInvID, isEnabled, callback)

    def _createHWDefConsumables(self, vehicle):
        layout = self.getVehicleLayout(vehicle.invID)
        inventory = self.getVehicleInventory(vehicle.invID)
        result = _HWConsumables(layout=_HWExpendableEquipment(GUI_ITEM_TYPE.EQUIPMENT, len(layout), self.itemsCache.items, True, *layout), installed=_HWExpendableEquipment(GUI_ITEM_TYPE.EQUIPMENT, len(layout), self.itemsCache.items, True, *[ eq if eq in inventory else None for eq in layout ]), isAutoEquip=self.isVehicleAutoEquipEnabled(vehicle.invID))
        return result

    def devSetLayout(self, layout, invID=None):
        if not IS_DEVELOPMENT:
            return
        else:
            self.updateSelectedEquipment(g_currentVehicle.invID if invID is None else invID, [ self.__devGetEqCompDescr(eq) for eq in layout ])
            return

    def devSetAutoMaintenanceEnabled(self, isEnabled, invID=None):
        if not IS_DEVELOPMENT:
            return
        else:
            self.setHwAutoMaintenanceEnabled(g_currentVehicle.invID if invID is None else invID, int(isEnabled))
            return

    def __devGetEqCompDescr(self, equipment):
        if not equipment:
            return 0
        else:
            if isinstance(equipment, str):
                equipment = vehicles.g_cache.equipmentIDs().get(equipment, None)
                if equipment is None:
                    return 0
            e = vehicles.g_cache.equipments().get(equipment, None)
            if e is None:
                return 0
            return e.compactDescr