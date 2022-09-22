import logging, BigWorld, WWISE, CGF, GenericComponents
from shared_utils import findFirst
from constants import IS_CLIENT
import SoundGroups
if IS_CLIENT:
    from Vehicle import Vehicle
_logger = logging.getLogger(__name__)

def getVehicle(go, spaceID):
    hierarchy = CGF.HierarchyManager(spaceID)
    parent = hierarchy.getTopMostParent(go)
    return parent.findComponentByType(Vehicle)


def play2d(soundName):
    SoundGroups.g_instance.playSound2D(soundName)


def play3d(soundName, go, spaceID):
    hierarchy = CGF.HierarchyManager(spaceID)
    parent = hierarchy.getTopMostParent(go)
    transform = parent.findComponentByType(GenericComponents.TransformComponent)
    if transform is not None:
        SoundGroups.g_instance.playSoundPos(soundName, transform.worldPosition)
    return


def playVehiclePart(soundName, vehicle, partIndex):
    if vehicle.appearance is not None:
        if vehicle.appearance.engineAudition is not None:
            soundObject = vehicle.appearance.engineAudition.getSoundObject(partIndex)
            soundObject.play(soundName)
        else:
            _logger.warning("Couldn't play sound. engineAudition is None. Part index: %s", str(partIndex))
    else:
        _logger.warning("Couldn't play sound. Appearance is None. Part index: %s", str(partIndex))
    return


def playNotification(notificationName):
    soundNotifications = getattr(BigWorld.player(), 'soundNotifications', None)
    if soundNotifications is not None:
        soundNotifications.play(notificationName)
    return


def _getSoundComponent(vehicle):
    from cgf_components.sound_components import VehicleSoundComponent
    if vehicle is not None and vehicle.appearance is not None:
        return vehicle.appearance.findComponentByType(VehicleSoundComponent)
    else:
        return


def playVehicleSound(event, vehicle):
    soundComponent = _getSoundComponent(vehicle)
    if soundComponent is not None:
        soundComponent.play(event)
    return


def hasVehicleSound(event, vehicle):
    soundComponent = _getSoundComponent(vehicle)
    if soundComponent is not None:
        return bool(findFirst(lambda soundObj: soundObj.name == event, soundComponent.soundObjects))
    else:
        return


def setState(name, value):
    WWISE.WW_setState(name, value)


def setRTCP(name, value):
    WWISE.WW_setRTCPGlobal(name, value)