from CurrentVehicle import g_currentVehicle
from halloween.gui.halloween_account_settings import getSettings, AccountSettingsKeys, setSettings
from halloween.skeletons.halloween_controller import IHalloweenController
from helpers import dependency
from skeletons.gui.shared import IItemsCache

class VehicleSwitcher(object):
    _halloweenCtrl = dependency.descriptor(IHalloweenController)
    _itemsCache = dependency.descriptor(IItemsCache)

    def startSwitcher(self):
        g_currentVehicle.onChanged += self.__onCurrentVehicleChanged
        self.selectModeVehicle()

    def stopSwitcher(self):
        g_currentVehicle.onChanged -= self.__onCurrentVehicleChanged

    def selectModeVehicle(self, vehInvID=0):
        if not vehInvID:
            vehInvID = self._getFavoriteVehInvID()
        setSettings(AccountSettingsKeys.FAVORITES_VEHICLE, vehInvID)
        g_currentVehicle.selectVehicle(vehInvID)

    def _getFavoriteVehInvID(self):
        vehInvID = getSettings(AccountSettingsKeys.FAVORITES_VEHICLE)
        if not vehInvID:
            vehicles = self._halloweenCtrl.getConfig().get('vehicles', [])
            vehicle = self._itemsCache.items.getItemByCD(vehicles[0] if vehicles else 0)
            vehInvID = vehicle.invID if vehicle and vehicle.isInInventory else 0
        return vehInvID

    def __onCurrentVehicleChanged(self):
        if g_currentVehicle.item is None:
            return
        else:
            vehicles = self._halloweenCtrl.getConfig().get('vehicles', [])
            if g_currentVehicle.item.intCD not in vehicles:
                g_currentVehicle.selectVehicle(self._getFavoriteVehInvID())
            return