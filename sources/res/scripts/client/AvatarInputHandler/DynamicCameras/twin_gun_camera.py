import BigWorld
from BigWorld import TwinGunAimingSystem, TwinGunAimingSystemRemote
from AvatarInputHandler.DynamicCameras.SniperCamera import SniperCamera

def getCameraAsSettingsHolder(settingsDataSec):
    return TwinGunCamera(settingsDataSec)


class TwinGunCamera(SniperCamera):

    def _aimingSystemClass(self):
        if BigWorld.player().isObserver():
            return TwinGunAimingSystemRemote
        return TwinGunAimingSystem

    def _readConfigs(self, dataSec):
        super(TwinGunCamera, self)._readConfigs(dataSec)
        transitionTime = dataSec.readFloat('transitionTime', 0.3)
        TwinGunAimingSystem.setTransitionTime(transitionTime)