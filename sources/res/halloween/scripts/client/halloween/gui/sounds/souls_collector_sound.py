import SoundGroups
from halloween.gui.sounds.sound_constants import SoulsCollectorSounds, SOULS_COLLECTOR_OBJ_NAME
from halloween.gui.sounds import playSound

class SoulsCollectorSound(object):

    def __init__(self, collectorComp):
        self._soulsCollectorSoundObject = SoundGroups.g_instance.WWgetSoundObject(SOULS_COLLECTOR_OBJ_NAME, collectorComp.entity.matrix)
        self._soulsCollectorSoundObject.play(SoulsCollectorSounds.LOOP)

    def destroy(self):
        if self._soulsCollectorSoundObject:
            self._soulsCollectorSoundObject.stopAll()
            self._soulsCollectorSoundObject = None
        return

    def updateSoulsCollectorState(self, collected, capacity, isCollecting):
        self._soulsCollectorSoundObject.setRTPC(SoulsCollectorSounds.RTPC, float(collected) / capacity * 100)

    def onFilling(self, collected):
        if collected > 0:
            playSound(SoulsCollectorSounds.COLLECT)