import BigWorld, SoundGroups
from halloween.gui.halloween_gui_constants import BATTLE_CTRL_ID
from helpers import dependency
from script_component.DynamicScriptComponent import DynamicScriptComponent
from halloween_common.halloween_constants import BOSS_ROLE_TAG, PLAYERS_TEAM, ATTACK_REASON, ARENA_BONUS_TYPE
from halloween.gui.sounds import ComponentsHolder
from halloween.gui.sounds.vehicle_components import HWBossBattle3DSounds, HWCommonEnemySounds, HWSoulsContainerSounds, HWLootSounds
from halloween.gui.sounds.sound_constants import VEHICLE_OBJ_NAME_PATTERN
from skeletons.gui.battle_session import IBattleSessionProvider
_VEHICLE_SOUND_COMPONENTS_SHARED = [
 (
  HWBossBattle3DSounds, lambda parent: parent.isBoss),
 (
  HWCommonEnemySounds, lambda parent: parent.isEnemy),
 (
  HWLootSounds, lambda parent: True)]
_VEHICLE_SOUND_COMPONENTS_CLASSIC = [
 (
  HWSoulsContainerSounds, lambda parent: parent.hwSoulsContainer is not None)]
_VEHICLE_SOUND_COMPONENTS_DEFENSE = []

class HWVehicleSoundComponent(DynamicScriptComponent):
    sessionProvider = dependency.descriptor(IBattleSessionProvider)

    def __init__(self):
        super(HWVehicleSoundComponent, self).__init__()
        componentList = _VEHICLE_SOUND_COMPONENTS_SHARED[:]
        if self.isDefence:
            componentList.extend(_VEHICLE_SOUND_COMPONENTS_DEFENSE)
        else:
            componentList.extend(_VEHICLE_SOUND_COMPONENTS_CLASSIC)
        self._components = ComponentsHolder([ component for component, condition in componentList if condition(self) ], self)
        self._soundObject = SoundGroups.g_instance.WWgetSoundObject(VEHICLE_OBJ_NAME_PATTERN.format(self.entity.id), self.entity.matrix)

    def onDestroy(self):
        self._components.onDestroy()
        self.soundObject.stopAll()
        BigWorld.player().arena.onVehicleKilled -= self._onVehicleKilled
        hwBattleGuiCtrl = self.hwBattleGuiCtrl
        if hwBattleGuiCtrl:
            hwBattleGuiCtrl.onBossLivesChanged -= self._onBossLivesChanged
        super(HWVehicleSoundComponent, self).onDestroy()

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

    @property
    def isDefence(self):
        return self.sessionProvider.arenaVisitor.getArenaBonusType() == ARENA_BONUS_TYPE.HALLOWEEN_DEFENCE

    @property
    def hwBattleGuiCtrl(self):
        return self.sessionProvider.dynamic.getControllerByID(BATTLE_CTRL_ID.HW_BATTLE_GUI_CTRL)

    def onLootFailed(self, lootID):
        self._components.call('onLootFailed', lootID)

    def onLootSucceed(self, lootID):
        self._components.call('onLootSucceed', lootID)

    def _onAvatarReady(self):
        self._components.onAvatarReady()
        if self.isBoss:
            arenaSoundComponent = self._arenaSoundComponent
            if arenaSoundComponent is not None:
                arenaSoundComponent.onBossEnterWorld(self.entity)
        BigWorld.player().arena.onVehicleKilled += self._onVehicleKilled
        hwBattleGuiCtrl = self.hwBattleGuiCtrl
        if hwBattleGuiCtrl:
            hwBattleGuiCtrl.onBossLivesChanged += self._onBossLivesChanged
        return

    def onBossDamageReceived(self, attackerID, attackReasonID, damage):
        attackReason = ATTACK_REASON.getValue(attackReasonID)
        arenaSoundComponent = self._arenaSoundComponent
        if arenaSoundComponent is not None:
            arenaSoundComponent.onShotAtBoss(attackerID)
        if damage > 0 and attackReason in (ATTACK_REASON.SHOT,
         ATTACK_REASON.HALLOWEEN_SHOT_AOE_DAMAGE,
         ATTACK_REASON.HALLOWEEN_SHOT_AOE_DRAIN_ENEMY_HP):
            self._components.call('onBossHealthChanged')
        return

    def _onVehicleKilled(self, victimID, *args):
        if self.entity.id == victimID:
            self.soundObject.stopAll()
        self._components.call('onVehicleKilled', victimID, *args)

    def _onBossLivesChanged(self):
        self.soundObject.stopAll()
        self._components.call('onBossLivesChanged')

    @property
    def _arenaSoundComponent(self):
        return BigWorld.player().arena.arenaInfo.dynamicComponents.get('HWArenaSoundComponent')