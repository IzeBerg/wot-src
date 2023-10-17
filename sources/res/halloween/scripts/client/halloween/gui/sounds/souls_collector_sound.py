import SoundGroups
from halloween.gui.sounds.sound_constants import SoulsCollectorSounds, SOULS_COLLECTOR_OBJ_NAME

class SoulsCollectorSound(object):

    def __init__(self, collectorComp):
        self._soulsCollectorSoundObject = SoundGroups.g_instance.WWgetSoundObject(SOULS_COLLECTOR_OBJ_NAME, collectorComp.entity.matrix)
        self._soulsCollectingInProgress = False
        self._soulsCollectorSoundObject.play(SoulsCollectorSounds.LOOP)

    def destroy(self):
        if self._soulsCollectorSoundObject:
            self._soulsCollectorSoundObject.stopAll()
            self._soulsCollectorSoundObject = None
        return

    def updateSoulsCollectorState(self, collected, capacity, isCollecting):
        self._soulsCollectorSoundObject.setRTPC(SoulsCollectorSounds.RTPC, float(collected) / capacity * 100)
        if not isCollecting and self._soulsCollectingInProgress:
            self._soulsCollectorSoundObject.play(SoulsCollectorSounds.STOP)
        if isCollecting and not self._soulsCollectingInProgress:
            self._soulsCollectorSoundObject.play(SoulsCollectorSounds.START)
        self._soulsCollectingInProgress = isCollecting