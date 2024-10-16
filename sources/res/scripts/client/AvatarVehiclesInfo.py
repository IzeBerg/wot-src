import BigWorld
from Vehicle import Vehicle
from AvatarVehiclesInfoBase import AvatarVehiclesInfoBase

class AvatarVehiclesInfo(AvatarVehiclesInfoBase):

    def setVehInfo_isAlive(self, vehInfo, diff):
        vehID = vehInfo['vehicleID']
        if BigWorld.entities.get(vehID) is None and diff.new and not diff.prev:
            Vehicle.respawnVehicle(vehID, vehInfo['compDescr'], vehInfo['outfitCD'])
        super(AvatarVehiclesInfo, self).setVehInfo_isAlive(vehInfo, diff)
        return