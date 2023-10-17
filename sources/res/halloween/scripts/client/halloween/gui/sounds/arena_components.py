import BigWorld, WWISE
from helpers import dependency
from constants import FINISH_REASON, EQUIPMENT_STAGES
from StaticDeathZone import StaticDeathZone
from PlayerEvents import g_playerEvents
from skeletons.gui.battle_session import IBattleSessionProvider
from gui.battle_control.battle_constants import BATTLE_CTRL_ID
from gui.battle_control.avatar_getter import isVehicleAlive
from halloween_common.halloween_constants import PLAYERS_TEAM
from halloween.gui.halloween_gui_constants import DifficultyLevel
from halloween.gui.sounds import playSound, SoundComponentBase, playVoiceover
from halloween.gui.sounds.sound_constants import DeathZoneSounds, PostMortemSounds, BossBattleMusic, BattleEquipmentPanelSounds, BattleBuffsPanelSounds, BossBattleSound, PersonalDeathZoneSounds, PersonalDeathZoneAbilityBossState, VO
from HWArenaPhasesComponent import HWArenaPhasesComponent
from HWTeamInfoStatsComponent import HWTeamInfoStatsComponent
from HWArenaInfoBossHealthBarComponent import getArenaInfoBossHealthBarComponent
from halloween.skeletons.difficulty_level_controller import IDifficultyLevelController

class HWStaticDeathZoneSounds(SoundComponentBase):

    def onAvatarReady(self):
        StaticDeathZone.onVehicleEntered += self._onVehicleEnteredInDeathZone
        StaticDeathZone.onVehicleLeft += self._onVehicleLeftInDeathZone
        StaticDeathZone.onDamage += self._onVehicleReceiveDamageByDeathZone

    def onDestroy(self):
        StaticDeathZone.onVehicleEntered -= self._onVehicleEnteredInDeathZone
        StaticDeathZone.onVehicleLeft -= self._onVehicleLeftInDeathZone
        StaticDeathZone.onDamage -= self._onVehicleReceiveDamageByDeathZone

    def _onVehicleEnteredInDeathZone(self, zoneId, vehicleId):
        player = BigWorld.player()
        if player.playerVehicleID == vehicleId:
            playSound(DeathZoneSounds.ENTER)

    def _onVehicleLeftInDeathZone(self, zoneId, vehicleId):
        player = BigWorld.player()
        if player.playerVehicleID == vehicleId:
            playSound(DeathZoneSounds.LEAVE)

    def _onVehicleReceiveDamageByDeathZone(self, zoneId, vehicleId):
        player = BigWorld.player()
        if player.playerVehicleID == vehicleId:
            playSound(DeathZoneSounds.DAMAGE)


class HWPostMortemSounds(SoundComponentBase):

    def onAvatarReady(self):
        vehicleStateCtrl = self._sessionProvider.shared.vehicleState
        if vehicleStateCtrl is not None:
            vehicleStateCtrl.onPostMortemSwitched += self._onPostMortemSwitched
            vehicleStateCtrl.onRespawnBaseMoving += self._onRespawnBaseMoving
            if vehicleStateCtrl.isInPostmortem:
                playSound(PostMortemSounds.ON)
        return

    def onDestroy(self):
        vehicleStateCtrl = self._sessionProvider.shared.vehicleState
        if vehicleStateCtrl is not None:
            vehicleStateCtrl.onPostMortemSwitched -= self._onPostMortemSwitched
            vehicleStateCtrl.onRespawnBaseMoving -= self._onRespawnBaseMoving
        return

    def _onPostMortemSwitched(self, noRespawnPossible, respawnAvailable):
        playSound(PostMortemSounds.ON)

    def _onRespawnBaseMoving(self):
        playSound(PostMortemSounds.OFF)


class HWBossBattleMusic(SoundComponentBase):

    def __init__(self, parent):
        super(HWBossBattleMusic, self).__init__(parent)
        self._arenaBonusType = BigWorld.player().arena.bonusType
        self._bossReceivesFirstDamageOnPhase = False

    def onAvatarReady(self):
        HWArenaPhasesComponent.onPhaseChanged += self._onPhaseChanged
        g_playerEvents.onRoundFinished += self._onRoundFinished
        if HWArenaPhasesComponent.getInstance().isLastPhase():
            playSound(BossBattleMusic.BOSS_FIGHT_START(self._arenaBonusType))
        bossHBComp = getArenaInfoBossHealthBarComponent()
        if bossHBComp is not None:
            bossHBComp.onBossLivesChanged += self._onBossLivesChanged
        return

    def onDestroy(self):
        HWArenaPhasesComponent.onPhaseChanged -= self._onPhaseChanged
        g_playerEvents.onRoundFinished -= self._onRoundFinished
        bossHBComp = getArenaInfoBossHealthBarComponent()
        if bossHBComp is not None:
            bossHBComp.onBossLivesChanged -= self._onBossLivesChanged
        return

    def onShotAtBoss(self, attackerID):
        if BigWorld.player().playerVehicleID == attackerID and not self._bossReceivesFirstDamageOnPhase and HWArenaPhasesComponent.getInstance().isLastPhase():
            self._bossReceivesFirstDamageOnPhase = True
            bossHBComp = getArenaInfoBossHealthBarComponent()
            if bossHBComp is not None:
                playSound(BossBattleMusic.getFirstDamageEventByBossLives(bossHBComp.livesLeft)(BigWorld.player().arena.bonusType))
        return

    def _onBossLivesChanged(self):
        bossHBComp = getArenaInfoBossHealthBarComponent()
        if bossHBComp is not None and bossHBComp.livesLeft > 0:
            playSound(BossBattleSound.getBossTeleportationEvent(self._arenaBonusType))
            playSound(BossBattleMusic.PHASE_1_FINISH(self._arenaBonusType))
            self._bossReceivesFirstDamageOnPhase = False
        return

    def _onPhaseChanged(self, arenaPhases):
        if arenaPhases.isLastPhase():
            playSound(BossBattleMusic.BOSS_FIGHT_START(self._arenaBonusType))

    def _onRoundFinished(self, winnerTeam, reason, extraData):
        if winnerTeam == PLAYERS_TEAM:
            playSound(BossBattleMusic.BOSS_KILLED(self._arenaBonusType))
        elif reason == FINISH_REASON.EXTERMINATION:
            bossHBComp = getArenaInfoBossHealthBarComponent()
            if bossHBComp is not None and bossHBComp.isActive:
                playSound(BossBattleMusic.getLoseEvent(self._bossReceivesFirstDamageOnPhase, bossHBComp.livesLeft)(self._arenaBonusType))
        return


class HWEquipmentPanelSounds(SoundComponentBase):
    ACTIVE_EQUIPMENT_STAGES = (EQUIPMENT_STAGES.DEPLOYING, EQUIPMENT_STAGES.PREPARING, EQUIPMENT_STAGES.ACTIVE,
     EQUIPMENT_STAGES.COOLDOWN)

    def onAvatarReady(self):
        ctrl = self._sessionProvider.shared.equipments
        if ctrl is not None:
            ctrl.onEquipmentUpdated += self._onEquipmentUpdated
        if self.hwBattleGuiCtrl:
            self.hwBattleGuiCtrl.onHandleEquipmentPressed += self._onHandleEquipmentPressed
        return

    def onDestroy(self):
        ctrl = self._sessionProvider.shared.equipments
        if ctrl is not None:
            ctrl.onEquipmentUpdated -= self._onEquipmentUpdated
        if self.hwBattleGuiCtrl:
            self.hwBattleGuiCtrl.onHandleEquipmentPressed -= self._onHandleEquipmentPressed
        return

    def _onEquipmentUpdated(self, _, item):
        if item.getPrevStage() == EQUIPMENT_STAGES.READY and item.getStage() in self.ACTIVE_EQUIPMENT_STAGES:
            playSound(BattleEquipmentPanelSounds.ACTIVATE)
        elif item.getPrevStage() == EQUIPMENT_STAGES.COOLDOWN and item.getStage() == EQUIPMENT_STAGES.READY:
            playSound(BattleEquipmentPanelSounds.READY)

    def _onHandleEquipmentPressed(self, intCD):
        item = self._sessionProvider.shared.equipments.getEquipment(intCD)
        if item.getStage() == EQUIPMENT_STAGES.COOLDOWN:
            playSound(BattleEquipmentPanelSounds.NOT_READY)


class HWBuffsPanelSounds(SoundComponentBase):

    def onAvatarReady(self):
        if self.hwBattleGuiCtrl:
            self.hwBattleGuiCtrl.onApplyBuff += self._handleBuffApply
            self.hwBattleGuiCtrl.onShowPanelBuffNotification += self._onShowPanelBuffNotification

    def onDestroy(self):
        if self.hwBattleGuiCtrl:
            self.hwBattleGuiCtrl.onApplyBuff -= self._handleBuffApply
            self.hwBattleGuiCtrl.onShowPanelBuffNotification -= self._onShowPanelBuffNotification

    def _handleBuffApply(self, _):
        playSound(BattleBuffsPanelSounds.SHOW_ICON)

    def _onShowPanelBuffNotification(self, isActive):
        event = BattleBuffsPanelSounds.ACTIVATE if isActive else BattleBuffsPanelSounds.DEACTIVATE
        playSound(event)


class HWPersonalDeathZoneSounds(SoundComponentBase):
    sessionProvider = dependency.descriptor(IBattleSessionProvider)

    def onAvatarReady(self):
        personalDeathZonesCtrl = self._personalDeathZonesCtrl
        if personalDeathZonesCtrl:
            personalDeathZonesCtrl.onPlayerEnteredDeathZone += self._onPlayerEnteredDeathZone
            personalDeathZonesCtrl.onPlayerLeftDeathZone += self._onPlayerLeftDeathZone

    def onDestroy(self):
        personalDeathZonesCtrl = self._personalDeathZonesCtrl
        if personalDeathZonesCtrl:
            personalDeathZonesCtrl.onPlayerEnteredDeathZone -= self._onPlayerEnteredDeathZone
            personalDeathZonesCtrl.onPlayerLeftDeathZone -= self._onPlayerLeftDeathZone

    def onBossAuraIntersectEvent(self, vehicleId, entered):
        player = BigWorld.player()
        if player.playerVehicleID == vehicleId:
            playSound(BossBattleSound.getAuraIntersectionEvent(entered))

    def _onPlayerEnteredDeathZone(self, _):
        if len(self._personalDeathZonesCtrl.enteredDeathZones) == 1:
            WWISE.WW_setState(PersonalDeathZoneAbilityBossState.GROUP, PersonalDeathZoneAbilityBossState.ENTER)
            playSound(PersonalDeathZoneSounds.ACTIVATION)

    def _onPlayerLeftDeathZone(self, _):
        if not self._personalDeathZonesCtrl.enteredDeathZones:
            WWISE.WW_setState(PersonalDeathZoneAbilityBossState.GROUP, PersonalDeathZoneAbilityBossState.EXIT)
            playSound(PersonalDeathZoneSounds.DEACTIVATION)

    @property
    def _personalDeathZonesCtrl(self):
        return self.sessionProvider.dynamic.getControllerByID(BATTLE_CTRL_ID.PERSONAL_DEATH_ZONES_GUI_CTRL)


class HWVoiceovers(SoundComponentBase):
    _PHASE_END_NOTIFY_TIME_OFFSET = 60
    _FIRST_MIN_NOTIFY_TIME_OFFSET = 60
    _COLLECTOR_FILLED_PERCENT_NOTIFY = 50
    _difficultyCtrl = dependency.descriptor(IDifficultyLevelController)

    def __init__(self, parent):
        super(HWVoiceovers, self).__init__(parent)
        self._shotAtBossPerformed = False
        self._needNotifyOneMinLeftToGetMirium = True
        self._needNotifyFirstMinPassedNoMirium = True
        self._needNotifyCollectorHalfFilled = True
        self._needNotifyCollectorFullFilled = True
        self._needNotifyEnoughMirium = True
        self._needNotifyBossAppearing = True
        self._playersSoulsAtStart = 0
        self._bossEnteredVOState = 0

    @property
    def teamInfoStats(self):
        return HWTeamInfoStatsComponent.getInstance()

    def onAvatarReady(self):
        HWArenaPhasesComponent.onPhaseTimeChanged += self._onPhaseTimeChanged
        HWArenaPhasesComponent.onPhaseChanged += self._onPhaseChanged
        if self.hwBattleGuiCtrl:
            self.hwBattleGuiCtrl.onSoulCollectorProgress += self._onCollectorSoulsChanged
        if self.teamInfoStats:
            self.teamInfoStats.onTeamSoulsUpdated += self._onTeamSoulsUpdated
        bossHBComp = getArenaInfoBossHealthBarComponent()
        if bossHBComp is not None:
            bossHBComp.onBossLivesChanged += self._onBossLivesChanged
            bossHBComp.onBossHealthChanged += self._onBossHealthChanged
        self._onPhaseChanged(self.arenaPhases)
        return

    def onDestroy(self):
        HWArenaPhasesComponent.onPhaseTimeChanged -= self._onPhaseTimeChanged
        HWArenaPhasesComponent.onPhaseChanged -= self._onPhaseChanged
        if self.hwBattleGuiCtrl:
            self.hwBattleGuiCtrl.onSoulCollectorProgress -= self._onCollectorSoulsChanged
        if self.teamInfoStats:
            self.teamInfoStats.onTeamSoulsUpdated -= self._onTeamSoulsUpdated
        bossHBComp = getArenaInfoBossHealthBarComponent()
        if bossHBComp is not None:
            bossHBComp.onBossLivesChanged -= self._onBossLivesChanged
            bossHBComp.onBossHealthChanged -= self._onBossHealthChanged
        return

    def onShotAtBoss(self, attackerID):
        if BigWorld.player().playerVehicleID == attackerID and not self._shotAtBossPerformed and not self.arenaPhases.isLastPhase():
            self._shotAtBossPerformed = True
            playVoiceover(VO.FIRST_SHOT_AT_BOSS_BEFORE_BOSS_BATTLE)

    def onBossEnterWorld(self, bossEntity):
        lastPhase = self.arenaPhases.isLastPhase()
        if self._needNotifyBossAppearing and not lastPhase:
            self._needNotifyBossAppearing = False
            playVoiceover(VO.BOSS_APPEARING.get(bossEntity.typeDescriptor.name))
        if not self._isHardDifficulty or not lastPhase:
            return
        bossHBComp = getArenaInfoBossHealthBarComponent()
        if bossHBComp is None:
            return
        else:
            livesLeft = bossHBComp.livesLeft
            if livesLeft != self._bossEnteredVOState:
                playVoiceover(VO.getBossSpawnVO(livesLeft))
                self._bossEnteredVOState = livesLeft
            return

    @staticmethod
    def _onBossLivesChanged():
        bossHBComp = getArenaInfoBossHealthBarComponent()
        if bossHBComp is not None and bossHBComp.livesLeft > 0:
            playVoiceover(VO.BOSS_FIGHT_PHASE_2)
        return

    def _onBossHealthChanged(self):
        if not self._isHardDifficulty or not self.arenaPhases.isLastPhase():
            return
        healthBarComponent = getArenaInfoBossHealthBarComponent()
        for bossHealth, bossHealthVO in VO.BOSS_FIGHT_HARD_VO_BY_HEALTH.iteritems():
            if healthBarComponent.lastHealth <= bossHealth <= healthBarComponent.prevHealth:
                playVoiceover(bossHealthVO)

    def _onPhaseChanged(self, arenaPhases):
        if arenaPhases.isLastPhase():
            return
        self._needNotifyOneMinLeftToGetMirium = True
        self._needNotifyFirstMinPassedNoMirium = True
        self._needNotifyCollectorHalfFilled = True
        self._needNotifyCollectorFullFilled = True
        self._needNotifyEnoughMirium = True
        self._needNotifyBossAppearing = True
        self._playersSoulsAtStartPhase = self.teamInfoStats.getSouls(BigWorld.player().playerVehicleID)
        self._onTeamSoulsUpdated()

    def _onPhaseTimeChanged(self, timeLeft, prev, isLastPhase):
        if isLastPhase:
            return
        if self._needNotifyOneMinLeftToGetMirium and 0 < timeLeft <= self._PHASE_END_NOTIFY_TIME_OFFSET:
            self._needNotifyOneMinLeftToGetMirium = False
            playVoiceover(VO.PHASE_ONE_MINUTE_LEFT)
        phaseDuration = self.arenaPhases.phaseDuration
        if self._needNotifyFirstMinPassedNoMirium and phaseDuration - prev < self._FIRST_MIN_NOTIFY_TIME_OFFSET <= phaseDuration - timeLeft:
            self._needNotifyFirstMinPassedNoMirium = False
            playVoiceover(VO.PHASE_FIRST_MINUTE_NO_MIRIUM)

    def _onTeamSoulsUpdated(self):
        if self.arenaPhases.isLastPhase():
            return
        else:
            if self.teamInfoStats.getSouls(BigWorld.player().playerVehicleID) > self._playersSoulsAtStartPhase:
                self._needNotifyFirstMinPassedNoMirium = False
            collected, capacity = self.hwBattleGuiCtrl.getCurrentCollectorSoulsInfo()
            if collected is None or capacity is None:
                return
            teamSouls = sum(data.value for data in self.teamInfoStats.souls)
            if self._needNotifyEnoughMirium:
                if collected < capacity <= teamSouls + collected:
                    self._needNotifyEnoughMirium = False
                    playVoiceover(VO.PHASE_MIRIUM_IS_ENOUGH)
            elif teamSouls + collected < capacity:
                self._needNotifyEnoughMirium = True
            return

    def _onCollectorSoulsChanged(self, isFull):
        if self._needNotifyCollectorFullFilled and isFull:
            self._needNotifyCollectorFullFilled = False
            playVoiceover(VO.COLLECTOR_FULL_FILLED)
        elif self.hwBattleGuiCtrl and not isFull:
            collected, capacity = self.hwBattleGuiCtrl.getCurrentCollectorSoulsInfo()
            if self._needNotifyCollectorHalfFilled and collected is not None and capacity is not None:
                if collected * 100.0 / capacity >= self._COLLECTOR_FILLED_PERCENT_NOTIFY:
                    self._needNotifyCollectorHalfFilled = False
                    playVoiceover(VO.COLLECTOR_HALF_FILLED)
        return

    @property
    def _isHardDifficulty(self):
        return self._difficultyCtrl.getSelectedLevel() == DifficultyLevel.HARD


class HWTeamFightVoiceovers(SoundComponentBase):
    _BOSS_LIVES_LEFT = 2
    _MAX_ALLIES_REMAINED_SIZE = 4

    @property
    def arenaDP(self):
        return self._sessionProvider.getArenaDP()

    def onAvatarReady(self):
        BigWorld.player().arena.onVehicleKilled += self._onArenaVehicleKilled

    def onDestroy(self):
        BigWorld.player().arena.onVehicleKilled -= self._onArenaVehicleKilled

    def _getAlliesAliveCount(self):
        vehInfoIterator = self.arenaDP.getVehiclesInfoIterator()
        return len([ v for v in vehInfoIterator if v.team == PLAYERS_TEAM and v.isAlive() ])

    def _onArenaVehicleKilled(self, vehicleID, *_):
        if not self.arenaDP.isAlly(vehicleID):
            return
        alliesAliveCount = self._getAlliesAliveCount()
        if vehicleID == BigWorld.player().playerVehicleID:
            if alliesAliveCount > 0:
                bossHBComp = getArenaInfoBossHealthBarComponent()
                if self.arenaPhases.isLastPhase() and bossHBComp and bossHBComp.isActive and bossHBComp.livesLeft == self._BOSS_LIVES_LEFT:
                    playVoiceover(VO.PLAYER_DEAD_FIRST_PART_BOSSFIGHT)
                elif not self.arenaPhases.isLastPhase():
                    playVoiceover(VO.PLAYER_DEAD_BEFORE_BOSSFIGHT)
        elif alliesAliveCount == 1 and isVehicleAlive():
            playVoiceover(VO.PLAYER_IS_LAST_ALIVE)
        elif 1 < alliesAliveCount <= self._MAX_ALLIES_REMAINED_SIZE:
            playVoiceover(VO.ALLY_TANKS_LEFT.format(alliesAliveCount))