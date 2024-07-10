import typing, CGF
from constants import IS_CLIENT
if IS_CLIENT:
    from Vehicle import Vehicle
else:

    class Vehicle(object):
        pass


def getVehicleEntityByGameObject(gameObject):
    return getVehicleEntityComponentByGameObject(gameObject, Vehicle)


def getVehicleEntityComponentByGameObject(gameObject, componentType):
    hierarchy = CGF.HierarchyManager(gameObject.spaceID)
    findResult = hierarchy.findComponentInParent(gameObject, componentType)
    if findResult is not None:
        return findResult[1]
    else:
        return