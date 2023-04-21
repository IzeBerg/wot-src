import BigWorld
from AvatarInputHandler.DynamicCameras.ArtyCamera import ArtyCamera

def getCameraAsSettingsHolder(settingsDataSec):
    return FlameArtyCamera(settingsDataSec)


class FlameArtyCamera(ArtyCamera):

    @staticmethod
    def _createAimingSystem():
        from BigWorld import FlameArtyAimingSystemRemote, FlameArtyAimingSystem
        if BigWorld.player().isObserver():
            return FlameArtyAimingSystemRemote(BigWorld.player().getVehicleDescriptor().shot.maxDistance)
        return FlameArtyAimingSystem(BigWorld.player().getVehicleDescriptor().shot.maxDistance)

    def setMaxDistance(self, newMaxDist):
        self._aimingSystem.setMaxRadius(newMaxDist)