from collections import namedtuple
VehicleSpawnData = namedtuple('VehicleSpawnData', ['vehicleCD', 'outfitCD'])

def convertVehicleSpawnDataToTuples(spawnData):
    return {(data.vehicleCD, data.outfitCD) for data in spawnData}


def convertTuplesToVehicleSpawnData(tuples):
    return {VehicleSpawnData(data[0], data[1]) for data in tuples}