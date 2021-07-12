from gui.shared.gui_items import GUI_ITEM_TYPE
_MODULES_ORDER = (
 GUI_ITEM_TYPE.GUN,
 GUI_ITEM_TYPE.TURRET,
 GUI_ITEM_TYPE.ENGINE,
 GUI_ITEM_TYPE.CHASSIS,
 GUI_ITEM_TYPE.RADIO)

def _getModuleOrderByType(itemType):
    if itemType in GUI_ITEM_TYPE.VEHICLE_MODULES:
        return _MODULES_ORDER.index(itemType)
    return -1


def modulesSortFunction(i1, i2):
    return cmp(_getModuleOrderByType(i1.getTypeID()), _getModuleOrderByType(i2.getTypeID()))