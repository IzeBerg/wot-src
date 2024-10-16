import BigWorld, WWISE
from helpers import dependency
from constants import FINISH_REASON, EQUIPMENT_STAGES, ARENA_PERIOD
from StaticDeathZone import StaticDeathZone
from PlayerEvents import g_playerEvents
from skeletons.gui.battle_session import IBattleSessionProvider
from gui.battle_control.battle_constants import BATTLE_CTRL_ID, VEHICLE_VIEW_STATE
from halloween_common.halloween_constants import PLAYERS_TEAM, INVALID_PHASE
from halloween.gui.sounds import playSound, SoundComponentBase, playVoiceover
from halloween.gui.sounds.sound_constants import DeathZoneSounds, PostMortemSounds, BossBattleMusic, BattleEquipmentPanelSounds, BattleBuffsPanelSounds, BossBattleSound, PersonalDeathZoneSounds, PersonalDeathZoneAbilityBossState, DefVO, VO, PhaseStartedVoiceover, DefBattleMusic, ARENA_PHASE_END_WARNING_EVENT_PREFIX
from HWArenaPhasesComponent import HWArenaPhasesComponent
from HWArenaInfoBossHealthBarComponent import getArenaInfoBossHealthBarComponent
from VehicleRespawnComponent import VehicleRespawnComponent
_NITRO_EQUIPMENT_NAME = 'nitroRamDamage'
_HW_EQUIPMENT = 'hwEquipment'
_HW_EMPTY_SLOT = 'hwEmptySlot'

class HWStaticDeathZoneSounds(SoundComponentBase):
    sessionProvider = dependency.descriptor(IBattleSessionProvider)

    def onAvatarReady(self):
        StaticDeathZone.onVehicleEntered += self._onVehicleEnteredInDeathZone
        StaticDeathZone.onVehicleLeft += self._onVehicleLeftInDeathZone
        StaticDeathZone.onDamage += self._onVehicleReceiveDamageByDeathZone
        vehicleStateCtrl = self._sessionProvider.shared.vehicleState
        if vehicleStateCtrl is not None:
            deathZoneState = vehicleStateCtrl.getStateValue(VEHICLE_VIEW_STATE.DEATHZONE)
            if deathZoneState and deathZoneState[0] is True:
                playSound(DeathZoneSounds.ENTER)
        return

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
        VehicleRespawnComponent.onVehicleRespawned += self._onVehicleRespawned
        vehicleStateCtrl = self._sessionProvider.shared.vehicleState
        if vehicleStateCtrl is not None:
            vehicleStateCtrl.onPostMortemSwitched += self._onPostMortemSwitched
            if vehicleStateCtrl.isInPostmortem:
                playSound(PostMortemSounds.ON)
        return

    def onDestroy(self):
        VehicleRespawnComponent.onVehicleRespawned -= self._onVehicleRespawned
        vehicleStateCtrl = self._sessionProvider.shared.vehicleState
        if vehicleStateCtrl is not None:
            vehicleStateCtrl.onPostMortemSwitched -= self._onPostMortemSwitched
        return

    def _onPostMortemSwitched(self, noRespawnPossible, respawnAvailable):
        playSound(PostMortemSounds.ON)

    def _onVehicleRespawned(self, vehicle):
        if vehicle.id == BigWorld.player().playerVehicleID:
            playSound(PostMortemSounds.OFF)


class HWBossBattleMusic(SoundComponentBase):

    def __init__(self, parent):
        super(HWBossBattleMusic, self).__init__(parent)
        self._arenaBonusType = BigWorld.player().arena.bonusType
        self._bossReceivesFirstDamageOnPhase = False

    def onAvatarReady(self):
        g_playerEvents.onRoundFinished += self._onRoundFinished
        if self.hwBattleGuiCtrl:
            self.hwBattleGuiCtrl.onBossLivesChanged += self._onBossLivesChanged
        if HWArenaPhasesComponent.getInstance().isLastPhase():
            playSound(BossBattleMusic.BOSS_FIGHT_START(self._arenaBonusType))
            bossHBComp = getArenaInfoBossHealthBarComponent()
            if bossHBComp is not None and bossHBComp.livesLeft < bossHBComp.maxLives:
                playSound(BossBattleMusic.PHASE_1_FINISH(self._arenaBonusType))
        return

    def onDestroy(self):
        g_playerEvents.onRoundFinished -= self._onRoundFinished
        if self.hwBattleGuiCtrl:
            self.hwBattleGuiCtrl.onBossLivesChanged -= self._onBossLivesChanged

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

    def onPhaseChanged(self, activePhase):
        if HWArenaPhasesComponent.getInstance().isLastPhase():
            playSound(BossBattleMusic.BOSS_FIGHT_START(self._arenaBonusType))

    def _onRoundFinished(self, winnerTeam, reason):
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

    def __init__(self, parent):
        super(HWEquipmentPanelSounds, self).__init__(parent)
        self._readyEquipment = set()
        self._nextTickEvents = set()
        self._nextTickCB = None
        return

    @property
    def vehicle(self):
        player = BigWorld.player()
        if player is not None:
            return player.vehicle
        else:
            return

    def onAvatarReady(self):
        ctrl = self._sessionProvider.shared.equipments
        if ctrl is not None:
            ctrl.onEquipmentUpdated += self._onEquipmentUpdated
        if self.hwBattleGuiCtrl:
            self.hwBattleGuiCtrl.onHandleEquipmentPressed += self._onHandleEquipmentPressed
        vehicleSoulsContainer = self._getPlayerVehicleSoulsContainer()
        if vehicleSoulsContainer:
            vehicleSoulsContainer.onChangeSoulsCount += self._onSoulsChanged
        nitroComp = BigWorld.player().hwNitroAccelerationControl
        if nitroComp:
            nitroComp.onActivate += self._onNitroActivate
        vehicleCtrl = self._sessionProvider.shared.vehicleState
        if vehicleCtrl is not None:
            vehicleCtrl.onVehicleStateUpdated += self._onVehicleStateUpdated
        return

    def onDestroy(self):
        ctrl = self._sessionProvider.shared.equipments
        if ctrl is not None:
            ctrl.onEquipmentUpdated -= self._onEquipmentUpdated
        if self.hwBattleGuiCtrl:
            self.hwBattleGuiCtrl.onHandleEquipmentPressed -= self._onHandleEquipmentPressed
        vehicleSoulsContainer = self._getPlayerVehicleSoulsContainer()
        if vehicleSoulsContainer:
            vehicleSoulsContainer.onChangeSoulsCount -= self._onSoulsChanged
        vehicleCtrl = self._sessionProvider.shared.vehicleState
        if vehicleCtrl is not None:
            vehicleCtrl.onVehicleStateUpdated -= self._onVehicleStateUpdated
        self._nextTickEvents.clear()
        self._clearCB()
        nitroComp = BigWorld.player().hwNitroAccelerationControl
        if nitroComp:
            nitroComp.onActivate -= self._onNitroActivate
        return

    def _onEquipmentUpdated(self, _, item):
        if item.getPrevStage() == EQUIPMENT_STAGES.READY and item.getStage() in self.ACTIVE_EQUIPMENT_STAGES:
            playSound(BattleEquipmentPanelSounds.ACTIVATE)
        elif self._checkEquipmentState(item) and self._isPlayerAlive():
            self._play(BattleEquipmentPanelSounds.READY)

    def _onSoulsChanged(self, newCount, reason):
        self._updateAbilities()

    def _onVehicleStateUpdated(self, state, value):
        if state == VEHICLE_VIEW_STATE.HEALTH:
            self._updateAbilities()

    def _updateAbilities(self):
        played = False
        if self.vehicle is None or self.vehicle.setups is None:
            return
        for equipmentId in self.vehicle.setups['eqsSetups'][0]:
            if not self._sessionProvider.shared.equipments.hasEquipment(equipmentId):
                continue
            isReady = self._checkEquipmentState(self._sessionProvider.shared.equipments.getEquipment(equipmentId))
            if isReady and not played:
                played = True
                self._play(BattleEquipmentPanelSounds.READY)

        return

    def _onNitroActivate(self):
        item = self._getNitroEquipment()
        if item is None:
            return
        else:
            if not self._isAbilityReady(item):
                self._play(BattleEquipmentPanelSounds.NOT_READY)
            return

    def _getNitroEquipment(self):
        if self.vehicle is None:
            return
        else:
            for intCD in self.vehicle.setups['eqsSetups'][0]:
                item = self._sessionProvider.shared.equipments.getEquipment(intCD)
                if item.getDescriptor().name == _NITRO_EQUIPMENT_NAME:
                    return item

            return

    def _checkEquipmentState(self, item):
        if item is None:
            return False
        else:
            equipmentID = item.getEquipmentID()
            prevIsReady = equipmentID in self._readyEquipment
            isReady = self._isAbilityReady(item)
            if isReady:
                self._readyEquipment.add(equipmentID)
            else:
                self._readyEquipment.discard(equipmentID)
            if isReady and not prevIsReady:
                return True
            return False

    def _isAbilityReady(self, item):
        return item.getStage() != EQUIPMENT_STAGES.COOLDOWN and item.canActivate()[0] and not self._isHalloweenEmptySlot(item)

    def _isHalloweenEmptySlot(self, item):
        return self._isHalloweenEquipment(item) and _HW_EMPTY_SLOT in item.getDescriptor().tags

    def _isHalloweenEquipment(self, item):
        return _HW_EQUIPMENT in item.getDescriptor().tags

    def _onHandleEquipmentPressed(self, intCD):
        item = self._sessionProvider.shared.equipments.getEquipment(intCD)
        if not self._isAbilityReady(item):
            self._play(BattleEquipmentPanelSounds.NOT_READY)

    def _getPlayerVehicleSoulsContainer(self):
        vehicle = self.vehicle
        if vehicle:
            return vehicle.dynamicComponents.get('hwSoulsContainer')
        else:
            return

    def _isPlayerAlive(self):
        vehicle = self.vehicle
        return vehicle and vehicle.isAlive()

    def _play(self, event):
        if event not in self._nextTickEvents:
            self._nextTickEvents.add(event)
        if self._nextTickCB is None:
            self._nextTickCB = BigWorld.callback(0, self._playOnNextTick)
        return

    def _playOnNextTick(self):
        for event in self._nextTickEvents:
            playSound(event)

        self._nextTickEvents.clear()
        self._clearCB()

    def _clearCB(self):
        if self._nextTickCB is not None:
            BigWorld.cancelCallback(self._nextTickCB)
            self._nextTickCB = None
        return


class HWBuffsPanelSounds(SoundComponentBase):

    def __init__(self, parent):
        super(HWBuffsPanelSounds, self).__init__(parent)
        self._isNotificationActive = False
        self._playShowIconCB = None
        return

    def onAvatarReady(self):
        if self.hwBattleGuiCtrl:
            self.hwBattleGuiCtrl.onApplyBuff += self._handleBuffApply
            self.hwBattleGuiCtrl.onShowPanelBuffNotification += self._onShowPanelBuffNotification

    def onDestroy(self):
        if self.hwBattleGuiCtrl:
            self.hwBattleGuiCtrl.onApplyBuff -= self._handleBuffApply
            self.hwBattleGuiCtrl.onShowPanelBuffNotification -= self._onShowPanelBuffNotification
        self._clearCB()

    def _handleBuffApply(self, _):
        if self._playShowIconCB is None:
            self._playShowIconCB = BigWorld.callback(0, self._playShowIcon)
        return

    def _onShowPanelBuffNotification(self, isActive):
        if isActive:
            self._playActivation()
        else:
            self._playDeactivation()

    def _playShowIcon(self):
        playSound(BattleBuffsPanelSounds.SHOW_ICON)
        self._clearCB()

    def _playActivation(self):
        if not self._isNotificationActive:
            self._isNotificationActive = True
            playSound(BattleBuffsPanelSounds.ACTIVATE)

    def _playDeactivation(self):
        if self._isNotificationActive:
            self._isNotificationActive = False
            playSound(BattleBuffsPanelSounds.DEACTIVATE)

    def _clearCB(self):
        if self._playShowIconCB is not None:
            BigWorld.cancelCallback(self._playShowIconCB)
            self._playShowIconCB = None
        return


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


class HWBattleSounds(SoundComponentBase):

    def oneMinuteLeft(self, lastPhase, isInDelta):
        if not lastPhase:
            playSound(ARENA_PHASE_END_WARNING_EVENT_PREFIX.format(phase=HWArenaPhasesComponent.getInstance().activePhase))


class HWVoiceovers(SoundComponentBase):
    _PHASE_END_NOTIFY_TIME_OFFSET = 60
    _COLLECTOR_FILLED_PERCENT_NOTIFY = 50

    def __init__(self, parent):
        super(HWVoiceovers, self).__init__(parent)
        self._shotAtBossPerformed = False
        self._needNotifyOneMinLeftToGetMirium = True
        self._needNotifyCollectorHalfFilled = True
        self._needNotifyCollectorFullFilled = True
        self._needNotifyBossAppearing = True
        self._playersSoulsAtStart = 0

    def onAvatarReady(self):
        HWArenaPhasesComponent.onPhaseTimeChanged += self._onPhaseTimeChanged
        if self.hwBattleGuiCtrl:
            self.hwBattleGuiCtrl.onSoulCollectorProgress += self._onCollectorSoulsChanged
            self.hwBattleGuiCtrl.onBossLivesChanged += self._onBossLivesChanged
        self._resetNotificationHandlers()

    def onDestroy(self):
        HWArenaPhasesComponent.onPhaseTimeChanged -= self._onPhaseTimeChanged
        if self.hwBattleGuiCtrl:
            self.hwBattleGuiCtrl.onSoulCollectorProgress -= self._onCollectorSoulsChanged
            self.hwBattleGuiCtrl.onBossLivesChanged -= self._onBossLivesChanged

    def onShotAtBoss(self, attackerID):
        if BigWorld.player().playerVehicleID == attackerID and not self._shotAtBossPerformed and not self.arenaPhases.isLastPhase():
            self._shotAtBossPerformed = True
            VO.FIRST_SHOT_AT_BOSS_BEFORE_BOSS_BATTLE.play()

    def onBossEnterWorld(self, bossEntity):
        lastPhase = self.arenaPhases.isLastPhase()
        if self._needNotifyBossAppearing and not lastPhase:
            self._needNotifyBossAppearing = False
            playVoiceover(VO.BOSS_APPEARING.get(bossEntity.typeDescriptor.name))

    def onPhaseChanged(self, activePhase):
        voiceover = PhaseStartedVoiceover.get(activePhase)
        if voiceover is not None:
            voiceover.play()
        self._resetNotificationHandlers()
        return

    @staticmethod
    def _onBossLivesChanged():
        bossHBComp = getArenaInfoBossHealthBarComponent()
        if bossHBComp is not None and bossHBComp.livesLeft > 0:
            playVoiceover(VO.BOSS_FIGHT_PHASE_2)
        return

    def _resetNotificationHandlers(self):
        if HWArenaPhasesComponent.getInstance().isLastPhase():
            return
        self._needNotifyOneMinLeftToGetMirium = True
        self._needNotifyCollectorHalfFilled = True
        self._needNotifyCollectorFullFilled = True
        self._needNotifyBossAppearing = True

    def _onPhaseTimeChanged(self, timeLeft, prev, isLastPhase):
        if isLastPhase:
            return
        if self._needNotifyOneMinLeftToGetMirium and 0 < timeLeft <= self._PHASE_END_NOTIFY_TIME_OFFSET:
            self._needNotifyOneMinLeftToGetMirium = False
            VO.PHASE_ONE_MINUTE_LEFT.play()

    def _onCollectorSoulsChanged(self, collected, capacity, isFull):
        if self._needNotifyCollectorFullFilled and isFull:
            self._needNotifyCollectorFullFilled = False
            VO.COLLECTOR_FULL_FILLED.play()
        elif not isFull:
            if self._needNotifyCollectorHalfFilled and collected is not None and capacity is not None:
                if collected * 100.0 / capacity >= self._COLLECTOR_FILLED_PERCENT_NOTIFY:
                    self._needNotifyCollectorHalfFilled = False
                    VO.COLLECTOR_HALF_FILLED.play()
        return


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
        elif alliesAliveCount > 0:
            VO.getAllyTanksLeftVO(alliesAliveCount).play()


class HWTeamFightDefVoiceovers(HWTeamFightVoiceovers):

    def _onArenaVehicleKilled(self, vehicleID, *_):
        if not self.arenaDP.isAlly(vehicleID):
            return
        alliesAliveCount = self._getAlliesAliveCount()
        if vehicleID == BigWorld.player().playerVehicleID:
            if alliesAliveCount > 0 and HWArenaPhasesComponent.getInstance().isRespawnEnabled:
                playVoiceover(DefVO.PLAYER_DEAD)
        elif alliesAliveCount > 0:
            DefVO.getAllyTanksLeftVO(alliesAliveCount).play()


class HWDefVoiceovers(SoundComponentBase):

    def onAvatarReady(self):
        super(HWDefVoiceovers, self).onAvatarReady()
        if self.hwBattleGuiCtrl:
            self.hwBattleGuiCtrl.onEnemiesInfoChanged += self._onEnemiesInfoChanged
        g_playerEvents.onArenaPeriodChange += self._onArenaPeriodChaned

    def onDestroy(self):
        if self.hwBattleGuiCtrl:
            self.hwBattleGuiCtrl.onEnemiesInfoChanged -= self._onEnemiesInfoChanged
        g_playerEvents.onArenaPeriodChange -= self._onArenaPeriodChaned
        super(HWDefVoiceovers, self).onDestroy()

    def onPhaseChanged(self, activePhase):
        vo = DefVO.getWaveStartedVO(activePhase)
        if vo is not None:
            playVoiceover(vo)
        return

    def oneMinuteLeft(self, lastPhase, isInDelta):
        if isInDelta:
            playVoiceover(DefVO.ONE_MINUTE_LEFT)

    def _onEnemiesInfoChanged(self, info):
        if info['totalEnemies'] > 0 and info['aliveEnemies'] == 0 and not HWArenaPhasesComponent.getInstance().isLastPhase():
            DefVO.WAVE_FINISHED.play()

    def _onArenaPeriodChaned(self, period, *_):
        if period == ARENA_PERIOD.BATTLE:
            playSound(DefVO.BATTLE_STARTED)


class HWDefBattleMusic(SoundComponentBase):

    def __init__(self, parent):
        super(HWDefBattleMusic, self).__init__(parent)
        self._currentMusicEvent = None
        return

    def onAvatarReady(self):
        super(HWDefBattleMusic, self).onAvatarReady()
        if self.hwBattleGuiCtrl:
            self.hwBattleGuiCtrl.onEnemiesInfoChanged += self._onEnemiesInfoChanged
            phasesComp = HWArenaPhasesComponent.getInstance()
            if phasesComp.activePhase != INVALID_PHASE:
                self._changeMusicByEnemiesInfo(self.hwBattleGuiCtrl.getEnemiesInfo())

    def onDestroy(self):
        if self.hwBattleGuiCtrl:
            self.hwBattleGuiCtrl.onEnemiesInfoChanged -= self._onEnemiesInfoChanged
        super(HWDefBattleMusic, self).onDestroy()

    def onPhaseChanged(self, activePhase):
        self._playMusic(DefBattleMusic.WAVE_STARTED)

    def _onEnemiesInfoChanged(self, info):
        self._changeMusicByEnemiesInfo(info)

    def _changeMusicByEnemiesInfo(self, info):
        if not info or info['totalEnemies'] <= 0:
            return
        if info['aliveEnemies'] == 0:
            if HWArenaPhasesComponent.getInstance().isLastPhase():
                self._playMusic(DefBattleMusic.WIN)
            else:
                self._playMusic(DefBattleMusic.BOTS_DESTROYED)
        else:
            self._playMusic(DefBattleMusic.WAVE_STARTED)

    def _playMusic(self, event):
        if self._currentMusicEvent != event:
            self._currentMusicEvent = event
            playSound(event)