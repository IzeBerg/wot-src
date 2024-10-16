import BigWorld
from BigWorld import DualGunAimingSystem, DualGunAimingSystemRemote
from AvatarInputHandler.DynamicCameras.SniperCamera import SniperCamera

def getCameraAsSettingsHolder(settingsDataSec):
    return DualGunCamera(settingsDataSec)


class DualGunCamera(SniperCamera):

    def _aimingSystemClass(self):
        if BigWorld.player().isObserver():
            return DualGunAimingSystemRemote
        return DualGunAimingSystem

    def _readConfigs(self, dataSec):
        super(DualGunCamera, self)._readConfigs(dataSec)
        transitionTime = dataSec.readFloat('transitionTime', 0.3)
        DualGunAimingSystem.setTransitionTime(transitionTime)