from CurrentVehicle import g_currentVehicle
from halloween.gui.halloween_account_settings import getSettings, AccountSettingsKeys, setSettings
from halloween.gui.impl.lobby.widgets.carousel_def_view import CarouselDefView
from halloween.skeletons.halloween_controller import IHalloweenController
from halloween.skeletons.difficulty_level_controller import IDifficultyLevelController
from helpers import dependency
from skeletons.gui.shared import IItemsCache
from halloween_common.halloween_constants import QUEUE_TYPE
from gui.prb_control.events_dispatcher import g_eventDispatcher
_FAVORITE_VEHICLE_DEFAULT_KEY = AccountSettingsKeys.FAVORITES_VEHICLE
_MODE_FAVORITE_VEHICLE_KEY = {QUEUE_TYPE.HALLOWEEN_DEFENCE: AccountSettingsKeys.DEFENCE_FAVORITES_VEHICLE}

class VehicleSwitcher(object):
    _halloweenCtrl = dependency.descriptor(IHalloweenController)
    _difficultyLevelCtrl = dependency.descriptor(IDifficultyLevelController)
    _itemsCache = dependency.descriptor(IItemsCache)

    def startSwitcher(self):
        g_currentVehicle.onChanged += self.__onCurrentVehicleChanged
        self.selectModeVehicle()

    def stopSwitcher(self):
        g_currentVehicle.onChanged -= self.__onCurrentVehicleChanged

    def selectModeVehicle(self, vehInvID=0):
        if not vehInvID:
            vehInvID = self._getFavoriteVehInvID()
        if vehInvID:
            favoriteVehicleKey = _MODE_FAVORITE_VEHICLE_KEY.get(self.__currentQueueType, _FAVORITE_VEHICLE_DEFAULT_KEY)
            setSettings(favoriteVehicleKey, vehInvID)
            g_currentVehicle.selectVehicle(vehInvID)
        else:
            g_currentVehicle.selectNoVehicle()

    @property
    def __currentQueueType(self):
        return self._difficultyLevelCtrl.getCurrentQueueType()

    def _getFavoriteVehInvID(self):
        favoriteVehicleKey = _MODE_FAVORITE_VEHICLE_KEY.get(self.__currentQueueType, _FAVORITE_VEHICLE_DEFAULT_KEY)
        vehInvID = getSettings(favoriteVehicleKey)
        if vehInvID and self._itemsCache.items.getVehicle(vehInvID) is None:
            vehInvID = None
        if not vehInvID:
            if self.__currentQueueType == QUEUE_TYPE.HALLOWEEN_DEFENCE:
                defVehicles = sorted(self._halloweenCtrl.getDefenceSuitableVehicles(), key=CarouselDefView._vehicleComparisonKey)
                if defVehicles:
                    vehInvID = defVehicles[0].invID
            else:
                hwVehicles = [ self._itemsCache.items.getItemByCD(intCD) for intCD in self._halloweenCtrl.getModeSettings().vehicles
                             ]
                if hwVehicles:
                    vehInvID = hwVehicles[0].invID
        return vehInvID

    def __onCurrentVehicleChanged(self):
        g_eventDispatcher.updateUI()