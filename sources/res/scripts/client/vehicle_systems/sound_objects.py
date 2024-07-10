import BigWorld
from constants import IS_EDITOR
from vehicle_systems.tankStructure import TankSoundObjectsIndexes

def getGunSoundObject(vehicle):
    if vehicle.appearance is not None and vehicle.appearance.engineAudition is not None:
        soundObject = vehicle.appearance.engineAudition.getSoundObject(TankSoundObjectsIndexes.GUN)
        if soundObject is not None:
            return soundObject
        return SOUND_OBJECT_STUB
    return SOUND_OBJECT_STUB


def getGunSoundObjectDistance(vehicle):
    if IS_EDITOR:
        return vehicle.position.length
    return (BigWorld.camera().position - vehicle.position).length


class SoundObjectStub(object):

    def play(self, *_, **__):
        pass

    def setRTPC(self, *_, **__):
        pass


SOUND_OBJECT_STUB = SoundObjectStub()