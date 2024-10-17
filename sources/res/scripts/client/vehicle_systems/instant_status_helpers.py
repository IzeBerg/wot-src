import InstantStatuses
from constants import IS_CLIENT

def invokeInstantStatusForVehicle(vehicle, instantStatusType):
    instantStatus = vehicle.appearance.findComponentByType(instantStatusType)
    if instantStatus is None:
        vehicle.appearance.createComponent(instantStatusType)
    else:
        instantStatus.addNextDone()
    return


def invokeShotsDoneStatus(vehicle):
    invokeInstantStatusForVehicle(vehicle, InstantStatuses.ShotsDoneComponent)
    if IS_CLIENT:
        vehicle.onDiscreteShotDone()