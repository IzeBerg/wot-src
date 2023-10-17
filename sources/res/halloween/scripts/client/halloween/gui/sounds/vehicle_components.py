import BigWorld
from halloween.gui.sounds import SoundComponentBase, playSound
from halloween.gui.sounds.sound_constants import BossBattleSound, BOTS_ENGINE, BOTS_EXPLOSION, VehicleSoulsContainerSounds as SoulsSounds
from halloween_common.halloween_constants import HalloweenSoulsChangeReason
from HWBuffBossAuraComponent import HWBuffBossAuraComponent

class HWBossBattle3DSounds(SoundComponentBase):

    def __init__(self, parent):
        super(HWBossBattle3DSounds, self).__init__(parent)
        self._arenaBonusType = BigWorld.player().arena.bonusType

    def onAvatarReady(self):
        if self._containsAuraComponent():
            self.parent.soundObject.play(BossBattleSound.AURA_ACTIVATION)

    def onBossHealthChanged(self):
        self.parent.soundObject.play(BossBattleSound.getBossDamageEvent(self._arenaBonusType))

    def _containsAuraComponent(self):
        return HWBuffBossAuraComponent in set([ type(value) for value in self.parent.entity.dynamicComponents.values() ])


class HWCommonEnemySounds(SoundComponentBase):

    def onAvatarReady(self):
        engineEvent = BOTS_ENGINE.get(self.parent.entity.typeDescriptor.name)
        if engineEvent is not None:
            self.parent.soundObject.play(engineEvent)
        return

    def onVehicleKilled(self, victimID, *_):
        if self.parent.entity.id == victimID:
            destroyEvent = BOTS_EXPLOSION.get(self.parent.entity.typeDescriptor.name)
            if destroyEvent is not None:
                self.parent.soundObject.play(destroyEvent)
        return


class HWSoulsContainerSounds(SoundComponentBase):

    def __init__(self, parent):
        super(HWSoulsContainerSounds, self).__init__(parent)
        self._souls = 0

    def onAvatarReady(self):
        vehicleSoulsContainer = self.parent.hwSoulsContainer
        if not vehicleSoulsContainer:
            return
        vehicleSoulsContainer.onChangeSoulsCount += self._onVehicleSoulsChanged
        self._souls = vehicleSoulsContainer.souls

    def onDestroy(self):
        vehicleSoulsContainer = self.parent.hwSoulsContainer
        if vehicleSoulsContainer is not None:
            vehicleSoulsContainer.onChangeSoulsCount -= self._onVehicleSoulsChanged
        return

    def _onVehicleSoulsChanged(self, souls, reason):
        sound = SoulsSounds.Player if self.parent.entity.isPlayerVehicle else SoulsSounds.Ally
        if souls == 0:
            self.parent.soundObject.play(sound.OFF)
        else:
            if reason == HalloweenSoulsChangeReason.PICK_UP:
                self._playPickUpSound()
            if self._souls == 0:
                self.parent.soundObject.play(sound.ON)
        self._souls = souls

    def _playPickUpSound(self):
        if self.parent.entity.isPlayerVehicle:
            playSound(SoulsSounds.Player.PICKUP)
        else:
            self.parent.soundObject.play(SoulsSounds.Ally.PICKUP)