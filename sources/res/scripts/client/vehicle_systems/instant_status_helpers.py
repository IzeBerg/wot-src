

def invokeInstantStatusForVehicle(vehicle, instantStatusType):
    instantStatus = vehicle.appearance.findComponentByType(instantStatusType)
    if instantStatus is None:
        vehicle.appearance.createComponent(instantStatusType)
    else:
        instantStatus.addNextDone()
    return