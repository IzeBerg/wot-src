from CurrentVehicle import g_currentVehicle
from helpers import dependency
from skeletons.gui.shared import IItemsCache
_DEFAULT_VEH_ID = 6929

@dependency.replace_none_kwargs(itemsCache=IItemsCache)
def getVehiclePreviewID(style, itemsCache=None):
    styledVehicleCD = None
    if g_currentVehicle.isPresent() and style.mayInstall(g_currentVehicle.item):
        styledVehicleCD = g_currentVehicle.item.intCD
    else:
        accDossier = itemsCache.items.getAccountDossier()
        vehiclesStats = accDossier.getRandomStats().getVehicles()
        vehicleGetter = itemsCache.items.getItemByCD
        sortedVehicles = sorted((vehicleGetter(veh) for veh in vehiclesStats.iterkeys()), key=lambda veh: (
         veh.level, vehiclesStats[veh.intCD].battlesCount), reverse=True)
        for vehicle in sortedVehicles:
            if style.mayInstall(vehicle):
                styledVehicleCD = vehicle.intCD
                break

    if styledVehicleCD is None:
        styledVehicleCD = _DEFAULT_VEH_ID
    return styledVehicleCD