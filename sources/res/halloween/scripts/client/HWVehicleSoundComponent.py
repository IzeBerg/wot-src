import BigWorld, SoundGroups
from HWArenaInfoBossHealthBarComponent import getArenaInfoBossHealthBarComponent
from helpers import dependency
from script_component.DynamicScriptComponent import DynamicScriptComponent
from halloween_common.halloween_constants import BOSS_ROLE_TAG, PLAYERS_TEAM
from halloween.gui.sounds import ComponentsHolder
from halloween.gui.sounds.vehicle_components import HWBossBattle3DSounds, HWCommonEnemySounds, HWSoulsContainerSounds
from halloween.gui.sounds.sound_constants import VEHICLE_OBJ_NAME_PATTERN
from skeletons.gui.battle_session import IBattleSessionProvider
_VEHICLE_SOUND_COMPONENTS = [
 (
  HWBossBattle3DSounds, lambda parent: parent.isBoss),
 (
  HWCommonEnemySounds, lambda parent: parent.isEnemy),
 (
  HWSoulsContainerSounds, lambda parent: parent.hwSoulsContainer is not None)]

class HWVehicleSoundComponent(DynamicScriptComponent):
    sessionProvider = dependency.descriptor(IBattleSessionProvider)

    def __init__(self):
        super(HWVehicleSoundComponent, self).__init__()
        componentList = [ component for component, condition in _VEHICLE_SOUND_COMPONENTS if condition(self) ]
        self._components = ComponentsHolder(componentList, self)
        self._soundObject = SoundGroups.g_instance.WWgetSoundObject(VEHICLE_OBJ_NAME_PATTERN.format(self.entity.id), self.entity.matrix)

    def onDestroy(self):
        self._components.onDestroy()
        self.soundObject.stopAll()
        if self.isBoss:
            self.entity.onShowDamageFromShot -= self._onShowDamageFromShot
        BigWorld.player().arena.onVehicleKilled -= self._onVehicleKilled
        bossHBComp = getArenaInfoBossHealthBarComponent()
        if bossHBComp is not None:
            bossHBComp.onBossLivesChanged -= self._onBossLivesChanged
            bossHBComp.onBossHealthChanged -= self._onBossHealthChanged
        super(HWVehicleSoundComponent, self).onDestroy()
        return

    @property
    def soundObject(self):
        return self._soundObject

    @property
    def isBoss(self):
        return BOSS_ROLE_TAG in self.entity.typeDescriptor.type.tags

    @property
    def isEnemy(self):
        return self.sessionProvider.getArenaDP().getVehicleInfo(self.entity.id).team != PLAYERS_TEAM

    @property
    def hwSoulsContainer(self):
        return self.entity.dynamicComponents.get('hwSoulsContainer')

    def _onAvatarReady(self):
        self._components.onAvatarReady()
        if self.isBoss:
            self.entity.onShowDamageFromShot += self._onShowDamageFromShot
            arenaSoundComponent = self._arenaSoundComponent
            if arenaSoundComponent is not None:
                arenaSoundComponent.onBossEnterWorld(self.entity)
        BigWorld.player().arena.onVehicleKilled += self._onVehicleKilled
        bossHBComp = getArenaInfoBossHealthBarComponent()
        if bossHBComp is not None:
            bossHBComp.onBossLivesChanged += self._onBossLivesChanged
            bossHBComp.onBossHealthChanged += self._onBossHealthChanged
        return

    def _onShowDamageFromShot(self, attackerID, *_):
        arenaSoundComponent = self._arenaSoundComponent
        if arenaSoundComponent is not None:
            arenaSoundComponent.onShotAtBoss(attackerID)
        return

    def _onVehicleKilled(self, victimID, *args):
        if self.entity.id == victimID:
            self.soundObject.stopAll()
        self._components.call('onVehicleKilled', victimID, *args)

    def _onBossHealthChanged(self):
        self._components.call('onBossHealthChanged')

    def _onBossLivesChanged(self):
        self.soundObject.stopAll()
        self._components.call('onBossLivesChanged')

    @property
    def _arenaSoundComponent(self):
        return BigWorld.player().arena.arenaInfo.dynamicComponents.get('HWArenaSoundComponent')