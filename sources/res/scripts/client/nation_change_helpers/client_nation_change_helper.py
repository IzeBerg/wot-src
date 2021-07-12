from helpers import dependency
from nation_change.nation_change_helpers import iterVehTypeCDsInNationGroup, isMainInNationGroup
from skeletons.gui.shared import IItemsCache

def getValidVehicleCDForNationChange(vehCompDescr):
    tempVehCD = vehCompDescr
    vehicle = _getItem(vehCompDescr)
    if vehicle.hasNationGroup:
        if vehicle.isInInventory:
            if not vehicle.activeInNationGroup:
                tempVehCD = iterVehTypeCDsInNationGroup(vehCompDescr).next()
        elif not isMainInNationGroup(vehCompDescr):
            tempVehCD = iterVehTypeCDsInNationGroup(vehCompDescr).next()
    return tempVehCD


@dependency.replace_none_kwargs(itemsCache=IItemsCache)
def _getItem(itemID, itemsCache=None):
    return itemsCache.items.getItemByCD(itemID)