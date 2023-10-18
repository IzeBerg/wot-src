import BigWorld
from AvatarInputHandler.DynamicCameras.ArtyCamera import ArtyCamera

def getCameraAsSettingsHolder(settingsDataSec):
    return OnlyArtyCamera(settingsDataSec)


class OnlyArtyCamera(ArtyCamera):

    @staticmethod
    def _createAimingSystem():
        from BigWorld import OnlyArtyAimingSystemRemote, OnlyArtyAimingSystem
        if BigWorld.player().isObserver():
            return OnlyArtyAimingSystemRemote(BigWorld.player().getVehicleDescriptor().shot.maxDistance)
        return OnlyArtyAimingSystem(BigWorld.player().getVehicleDescriptor().shot.maxDistance)

    def setMaxDistance(self, newMaxDist):
        self._aimingSystem.setMaxRadius(newMaxDist)