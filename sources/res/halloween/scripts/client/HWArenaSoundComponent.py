import WWISE, BigWorld, SoundGroups
from constants import ARENA_PERIOD
from PlayerEvents import g_playerEvents
from script_component.DynamicScriptComponent import DynamicScriptComponent
from HWArenaPhasesComponent import HWArenaPhasesComponent
from halloween_common.halloween_constants import INVALID_PHASE, ARENA_BONUS_TYPE
from halloween.gui.sounds.sound_constants import BOTS_SPAWN, DEFAULT_BOT_SPAWN, BATTLE_START, ACTIVE_PHASE_RTPC, BATTLE_FINISH, PHASE_CHANGED, ActivePhaseState, DifficultyState
from halloween.gui.sounds.arena_components import HWStaticDeathZoneSounds, HWPostMortemSounds, HWBattleSounds, HWBossBattleMusic, HWEquipmentPanelSounds, HWBuffsPanelSounds, HWPersonalDeathZoneSounds, HWVoiceovers, HWTeamFightVoiceovers, HWDefVoiceovers, HWTeamFightDefVoiceovers, HWDefBattleMusic
from halloween.gui.sounds import playSound, ComponentsHolder
from helpers import dependency
from skeletons.gui.battle_session import IBattleSessionProvider
_ARENA_SOUND_COMPONENTS_SHARED = [
 HWStaticDeathZoneSounds,
 HWPostMortemSounds,
 HWEquipmentPanelSounds,
 HWBuffsPanelSounds,
 HWPersonalDeathZoneSounds]
_ARENA_SOUND_COMPONENTS_CLASSIC = [
 HWBattleSounds,
 HWBossBattleMusic,
 HWVoiceovers,
 HWTeamFightVoiceovers]
_ARENA_SOUND_COMPONENTS_DEFENSE = [
 HWDefVoiceovers,
 HWTeamFightDefVoiceovers,
 HWDefBattleMusic]
_PHASE_END_WARNING_TIME_OFFSET = 62
_PHASE_END_WARNING_TIME_OFFSET_DELTA = 2
_DEFENSE_MODE_WORLD = 1

class HWArenaSoundComponent(DynamicScriptComponent):
    _sessionProvider = dependency.descriptor(IBattleSessionProvider)

    def __init__(self):
        super(HWArenaSoundComponent, self).__init__()
        self._components = ComponentsHolder(_ARENA_SOUND_COMPONENTS_SHARED, self)
        if self.isDefence:
            self._components.addComponents(_ARENA_SOUND_COMPONENTS_DEFENSE)
        else:
            self._components.addComponents(_ARENA_SOUND_COMPONENTS_CLASSIC)
        self._shouldTriggerPhaseEndWarningEvent = False
        self._bossAuraIntersectionsCounter = 0

    def onDestroy(self):
        HWArenaPhasesComponent.onPhaseChanged -= self._onPhaseChanged
        HWArenaPhasesComponent.onPhaseTimeChanged -= self._onPhaseTimeChanged
        g_playerEvents.onArenaPeriodChange -= self._onArenaPeriodChaned
        if BigWorld.player().arena.period == ARENA_PERIOD.BATTLE:
            playSound(BATTLE_FINISH)
        self._components.onDestroy()
        super(HWArenaSoundComponent, self).onDestroy()

    def _onAvatarReady(self):
        HWArenaPhasesComponent.onPhaseChanged += self._onPhaseChanged
        HWArenaPhasesComponent.onPhaseTimeChanged += self._onPhaseTimeChanged
        g_playerEvents.onArenaPeriodChange += self._onArenaPeriodChaned
        arena = BigWorld.player().arena
        if arena.period == ARENA_PERIOD.BATTLE:
            playSound(BATTLE_START)
        self._setPhaseStates(HWArenaPhasesComponent.getInstance().activePhase)
        self._components.onAvatarReady()
        WWISE.WW_setState(DifficultyState.GROUP, DifficultyState.VALUE(arena.bonusType))

    def onBotCreated(self, vehicleType, position):
        spawnEvent = BOTS_SPAWN.get(vehicleType, DEFAULT_BOT_SPAWN)
        if spawnEvent is not None:
            SoundGroups.g_instance.playSoundPos(spawnEvent, position)
        return

    def onShotAtBoss(self, attackerID):
        self._components.call('onShotAtBoss', attackerID)

    def onBossEnterWorld(self, bossEntity):
        self._components.call('onBossEnterWorld', bossEntity)

    @property
    def isDefence(self):
        return self._sessionProvider.arenaVisitor.getArenaBonusType() == ARENA_BONUS_TYPE.HALLOWEEN_DEFENCE

    def _onPhaseChanged(self, arenaPhases):
        activePhase = arenaPhases.activePhase
        self._setPhaseStates(activePhase)
        self._components.call('onPhaseChanged', activePhase)
        if activePhase > 1:
            playSound(PHASE_CHANGED)

    def _setPhaseStates(self, activePhase):
        if activePhase == INVALID_PHASE:
            return
        self._shouldTriggerPhaseEndWarningEvent = True
        phase = _DEFENSE_MODE_WORLD if self.isDefence else activePhase
        WWISE.WW_setRTCPGlobal(ACTIVE_PHASE_RTPC, phase)
        WWISE.WW_setState(ActivePhaseState.GROUP, ActivePhaseState.getStateByPhase(phase))

    def _onPhaseTimeChanged(self, timeLeft, _, lastPhase):
        if self._shouldTriggerPhaseEndWarningEvent and 0 < timeLeft <= _PHASE_END_WARNING_TIME_OFFSET:
            self._shouldTriggerPhaseEndWarningEvent = False
            isInDelta = _PHASE_END_WARNING_TIME_OFFSET - timeLeft < _PHASE_END_WARNING_TIME_OFFSET_DELTA
            self._components.call('oneMinuteLeft', lastPhase, isInDelta)

    def _onArenaPeriodChaned(self, period, *_):
        if period == ARENA_PERIOD.BATTLE:
            playSound(BATTLE_START)
        elif period == ARENA_PERIOD.AFTERBATTLE:
            playSound(BATTLE_FINISH)

    def onBossAuraIntersect(self, vehicleId, entered):
        if entered:
            if self._bossAuraIntersectionsCounter == 0:
                self._components.call('onBossAuraIntersectEvent', vehicleId, True)
            self._bossAuraIntersectionsCounter += 1
        else:
            self._bossAuraIntersectionsCounter -= 1
            if self._bossAuraIntersectionsCounter == 0:
                self._components.call('onBossAuraIntersectEvent', vehicleId, False)