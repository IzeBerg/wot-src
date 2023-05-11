import WWISE
from typing import TYPE_CHECKING

def play2DSoundEvent(name):
    import SoundGroups
    return SoundGroups.g_instance.playSound2D(name)


def play3DSoundEvent(name, point):
    import SoundGroups
    return SoundGroups.g_instance.playSoundPos(name, point)


if TYPE_CHECKING:
    from Math import Vector3

class CosmicHangarSounds(object):
    _COSMIC_PRB_ENTER = 'ev_cosmic_lobby_enter'
    _COSMIC_PRB_EXIT = 'ev_cosmic_lobby_exit'
    _COSMIC_BATTLE_RESULTS = 'ev_cosmic_music_pbs'

    @classmethod
    def playCosmicPrbEnter(cls):
        play2DSoundEvent(cls._COSMIC_PRB_ENTER)

    @classmethod
    def playCosmicPrbExit(cls):
        play2DSoundEvent(cls._COSMIC_PRB_EXIT)

    @classmethod
    def playCosmicBattleResultsEnter(cls):
        play2DSoundEvent(cls._COSMIC_BATTLE_RESULTS)


class CosmicBattleSounds(object):
    _SCORE_NOTIFICATION = 'ev_cosmic_score_notification'
    _ABILITY_PICK_UP_NOTIFICATION = 'ev_cosmic_pickup_notification'
    _ENEMY_KILLED_NOTIFICATION = 'ev_cosmic_enemy_killed'
    _ABILITY_PICK_UP = 'ev_cosmic_ability_pickup'
    _ABILITY_PICK_UP_MUSIC = 'ev_cosmic_music_pickup'
    _BATTLE_PERIOD_MUSIC = 'ev_cosmic_music_start_battle'
    _AFTERBATTLE_PERIOD_MUSIC = 'ev_cosmic_music_end_battle'
    _RAMMING = 'ev_cosmic_tank_ram'

    class ScanningZone(object):
        _STATE_GROUP = 'STATE_ev_cosmic_object'
        _ACTIVE_STATE_VAL = 'STATE_ev_cosmic_object_active_on'
        _INACTIVE_STATE_VAL = 'STATE_ev_cosmic_object_active_off'
        _FINAL_CYCLE = 'ev_cosmic_coda'
        _SCANNING_ZONE_ACTIVE = 'ev_cosmic_music_object_active'
        _SCANNING_ZONE_INACTIVE = 'ev_cosmic_music_object_inactive'

        @classmethod
        def setActive(cls, isLast):
            WWISE.WW_setState(cls._STATE_GROUP, cls._ACTIVE_STATE_VAL)
            if isLast:
                play2DSoundEvent(cls._FINAL_CYCLE)
            else:
                play2DSoundEvent(cls._SCANNING_ZONE_ACTIVE)

        @classmethod
        def setInactive(cls, isLast):
            cls.switchInactiveState()
            if not isLast:
                play2DSoundEvent(cls._SCANNING_ZONE_INACTIVE)

        @classmethod
        def switchInactiveState(cls):
            WWISE.WW_setState(cls._STATE_GROUP, cls._INACTIVE_STATE_VAL)

    class Announcements(object):
        PICK_UP_ANNOUNCE_START = 'ev_cosmic_ability_announce'
        PICK_UP_ANNOUNCE_END = 'ev_cosmic_ability_appear'
        _STEP = 'ev_cosmic_timer_1shot'
        FINISHED = 'ev_cosmic_timer_last'

        @classmethod
        def playStep(cls):
            play2DSoundEvent(cls._STEP)

        @classmethod
        def playFinish(cls):
            play2DSoundEvent(cls.FINISHED)

    class Abilities(object):
        _NOT_READY = 'ev_cosmic_ability_not_ready'
        _ACTIVATED = 'ev_cosmic_ability_apply'
        _BOOSTER_ACTIVATED = 'ev_cosmic_ability_booster'
        _DPM_ACTIVATED = 'ev_cosmic_ability_overcharge_shot_start'
        _DPM_ELAPSED = 'ev_cosmic_ability_overcharge_shot_stop'
        _BLACK_HOLE_ACTIVATED = 'ev_cosmic_ability_supernova_charge'
        _BLACK_HOLE_CANCELED = 'ev_cosmic_ability_supernova_cancel'
        _RESPAWN_PROTECTION_ACTIVATED = 'ev_cosmic_ability_respawn_protection_start'
        _RESPAWN_PROTECTION_ELAPSED = 'ev_cosmic_ability_respawn_protection_stop'

        @classmethod
        def playActivated(cls):
            play2DSoundEvent(cls._ACTIVATED)

        @classmethod
        def playNotReady(cls):
            play2DSoundEvent(cls._NOT_READY)

        @classmethod
        def playBoosterActivated(cls):
            play2DSoundEvent(cls._BOOSTER_ACTIVATED)

        @classmethod
        def playDpmIncreaseActivated(cls):
            play2DSoundEvent(cls._DPM_ACTIVATED)

        @classmethod
        def playDpmIncreaseElapsed(cls):
            play2DSoundEvent(cls._DPM_ELAPSED)

        @classmethod
        def blackHoleActivated(cls, reset):
            if reset:
                play2DSoundEvent(cls._BLACK_HOLE_CANCELED)
            else:
                play2DSoundEvent(cls._BLACK_HOLE_ACTIVATED)

        @classmethod
        def playRespawnProtectionActivated(cls):
            play2DSoundEvent(cls._RESPAWN_PROTECTION_ACTIVATED)

        @classmethod
        def playRespawnProtectionElapsed(cls):
            play2DSoundEvent(cls._RESPAWN_PROTECTION_ELAPSED)

    @classmethod
    def playScoreNotification(cls):
        play2DSoundEvent(cls._SCORE_NOTIFICATION)

    @classmethod
    def playAbilityPickup(cls):
        play2DSoundEvent(cls._ABILITY_PICK_UP_NOTIFICATION)
        play2DSoundEvent(cls._ABILITY_PICK_UP_MUSIC)
        play2DSoundEvent(cls._ABILITY_PICK_UP)

    @classmethod
    def playEnemyKilled(cls):
        play2DSoundEvent(cls._ENEMY_KILLED_NOTIFICATION)

    @classmethod
    def startBattlePeriodMusic(cls):
        play2DSoundEvent(cls._BATTLE_PERIOD_MUSIC)

    @classmethod
    def startAfterBattlePeriodMusic(cls):
        play2DSoundEvent(cls._AFTERBATTLE_PERIOD_MUSIC)

    @classmethod
    def playRammingSound(cls, point):
        play3DSoundEvent(cls._RAMMING, point)