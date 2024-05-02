from typing import TYPE_CHECKING
from visual_script.dependency import dependencyImporter
lobbyViewModel, = dependencyImporter('cosmic_event.gui.impl.gen.view_models.views.lobby.cosmic_lobby_view.cosmic_lobby_view_model')

def play2DSoundEvent(name):
    import SoundGroups
    return SoundGroups.g_instance.playSound2D(name)


def play3DSoundEvent(name, point):
    import SoundGroups
    return SoundGroups.g_instance.playSoundPos(name, point)


if TYPE_CHECKING:
    from Math import Vector3

class CosmicHangarSounds(object):
    _LOBBY_ENTER = 'ev_cosmic_2024_lobby_enter'
    _LOBBY_EXIT = 'ev_cosmic_2024_lobby_exit'
    _ARTEFACT_ENTER = 'ev_cosmic_2024_lobby_artefact_enter'
    _ARTEFACT_EXIT = 'ev_cosmic_2024_lobby_artefact_exit'
    _PROGRESS_ENTER = 'ev_cosmic_2024_progression_screen_enter'
    _PROGRESS_EXIT = 'ev_cosmic_2024_progression_screen_exit'
    _PROGRESS_PAGES = 'ev_cosmic_2024_progression_screen_page'
    _BRIEF_ENTER = 'ev_cosmic_2024_brief_enter'
    _BRIEF_EXIT = 'ev_cosmic_2024_brief_exit'
    _PRB_ENTER = 'ev_cosmic_2024_battle'
    _PRB_EXIT = 'ev_cosmic_2024_leave_battle'
    _PBS_ENTER = 'ev_cosmic_2024_pbs_enter'
    _PBS_EXIT = 'ev_cosmic_2024_pbs_exit'
    _PBS_STOP_SCORE_SOUND = 'ev_cosmic_2024_pbs_score_stop'
    _RESEARCH_ENTER = 'ev_cosmic_2024_results_enter'
    _RESEARCH_EXIT = 'ev_cosmic_2024_results_exit'
    _PROGRESS_ROUTES = [
     lobbyViewModel.LobbyRouteEnum.KIRK,
     lobbyViewModel.LobbyRouteEnum.SPOCK,
     lobbyViewModel.LobbyRouteEnum.UHURA]

    @classmethod
    def playLobbyEnter(cls):
        play2DSoundEvent(cls._LOBBY_ENTER)

    @classmethod
    def playLobbyExit(cls):
        play2DSoundEvent(cls._LOBBY_EXIT)

    @classmethod
    def playArtefactEnter(cls):
        play2DSoundEvent(cls._ARTEFACT_ENTER)

    @classmethod
    def playArtefactExit(cls):
        play2DSoundEvent(cls._ARTEFACT_EXIT)

    @classmethod
    def playProgressEnter(cls):
        play2DSoundEvent(cls._PROGRESS_ENTER)

    @classmethod
    def playProgressExit(cls):
        play2DSoundEvent(cls._PROGRESS_EXIT)

    @classmethod
    def playProgressPagesSwitch(cls):
        play2DSoundEvent(cls._PROGRESS_PAGES)

    @classmethod
    def playBriefEnter(cls):
        play2DSoundEvent(cls._BRIEF_ENTER)

    @classmethod
    def playBriefExit(cls):
        play2DSoundEvent(cls._BRIEF_EXIT)

    @classmethod
    def playPrebattleEnter(cls):
        play2DSoundEvent(cls._PRB_ENTER)

    @classmethod
    def playPrebattleExit(cls):
        play2DSoundEvent(cls._PRB_EXIT)

    @classmethod
    def playPostbattleScreenEnter(cls):
        play2DSoundEvent(cls._PBS_ENTER)

    @classmethod
    def playPostbattleScreenExit(cls):
        play2DSoundEvent(cls._PBS_EXIT)

    @classmethod
    def playPostbattleStopScoreSound(cls):
        play2DSoundEvent(cls._PBS_STOP_SCORE_SOUND)

    @classmethod
    def playResearchEnter(cls):
        play2DSoundEvent(cls._RESEARCH_ENTER)

    @classmethod
    def playResearchExit(cls):
        play2DSoundEvent(cls._RESEARCH_EXIT)

    @classmethod
    def handleLobbyRouteChange(cls, oldRoute, newRoute):
        if oldRoute == newRoute:
            return
        if oldRoute == lobbyViewModel.LobbyRouteEnum.RESEARCH:
            cls.playResearchExit()
        if oldRoute == lobbyViewModel.LobbyRouteEnum.MISSIONBRIEF:
            cls.playBriefExit()
        if oldRoute == lobbyViewModel.LobbyRouteEnum.ARTEFACT:
            cls.playArtefactExit()
        if newRoute not in cls._PROGRESS_ROUTES and oldRoute in cls._PROGRESS_ROUTES:
            cls.playProgressExit()
        if newRoute in cls._PROGRESS_ROUTES and oldRoute not in cls._PROGRESS_ROUTES:
            cls.playProgressEnter()
        if newRoute in cls._PROGRESS_ROUTES and oldRoute in cls._PROGRESS_ROUTES:
            cls.playProgressPagesSwitch()
        if newRoute == lobbyViewModel.LobbyRouteEnum.ARTEFACT:
            cls.playArtefactEnter()
        if newRoute == lobbyViewModel.LobbyRouteEnum.MISSIONBRIEF:
            cls.playBriefEnter()
        if newRoute == lobbyViewModel.LobbyRouteEnum.RESEARCH:
            cls.playResearchEnter()


class CosmicBattleSounds(object):
    _ABILITY_PICK_UP_NOTIFICATION = 'ev_cosmic_pickup_notification'
    _ENEMY_KILLED_NOTIFICATION = 'ev_cosmic_enemy_killed'
    _ABILITY_PICK_UP = 'ev_cosmic_ability_pickup'
    _BATTLE_PERIOD_MUSIC = 'ev_cosmic_2024_music_exploration'
    _AFTERBATTLE_PERIOD_MUSIC = 'ev_cosmic_2024_music_end_battle'
    _RAMMING = 'ev_cosmic_tank_ram'

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
        _RESPAWN_PROTECTION_ACTIVATED = 'ev_cosmic_ability_respawn_protection_start'
        _RESPAWN_PROTECTION_ELAPSED = 'ev_cosmic_ability_respawn_protection_stop'
        _VORTEX_ACTIVATED = 'ev_cosmic_ability_charge'
        _VORTEX_CANCELED = 'ev_cosmic_ability_cancel'
        _REPULSOR_ACTIVATED = 'ev_cosmic_ability_charge'
        _REPULSOR_CANCELED = 'ev_cosmic_ability_cancel'
        _JUMP_ACTIVATED = 'ev_cosmic_ability_charge'
        _JUMP_CANCELED = 'ev_cosmic_ability_cancel'
        _MINES_DEPLOYED = 'ev_cosmic_ability_charge'

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
        def playRespawnProtectionActivated(cls):
            play2DSoundEvent(cls._RESPAWN_PROTECTION_ACTIVATED)

        @classmethod
        def playRespawnProtectionElapsed(cls):
            play2DSoundEvent(cls._RESPAWN_PROTECTION_ELAPSED)

        @classmethod
        def vortexActivated(cls, reset):
            if reset:
                play2DSoundEvent(cls._VORTEX_CANCELED)
            else:
                play2DSoundEvent(cls._VORTEX_ACTIVATED)

        @classmethod
        def repulsorActivated(cls, reset):
            if reset:
                play2DSoundEvent(cls._REPULSOR_CANCELED)
            else:
                play2DSoundEvent(cls._REPULSOR_ACTIVATED)

        @classmethod
        def jumpActivated(cls, reset):
            if reset:
                play2DSoundEvent(cls._JUMP_CANCELED)
            else:
                play2DSoundEvent(cls._JUMP_ACTIVATED)

        @classmethod
        def playMinesDeployed(cls):
            play2DSoundEvent(cls._MINES_DEPLOYED)

    class Fragment(object):
        FRAGMENT_PICK_UP = 'ev_cosmic_2024_fragment_pickup'
        FRAGMENT_FULL = 'ev_cosmic_2024_fragment_full'

        @classmethod
        def playFragmentPickup(cls):
            play2DSoundEvent(cls.FRAGMENT_PICK_UP)

        @classmethod
        def playFragmentFull(cls):
            play2DSoundEvent(cls.FRAGMENT_FULL)

    class Zones(object):
        _DELIVERY_FINISHED_MUSIC = 'ev_cosmic_2024_music_exploration'
        _DELIVERY_STARTED_MUSIC = 'ev_cosmic_2024_music_delivery'
        _EVACUATION_STARTED_MUSIC = 'ev_cosmic_2024_coda'
        _EVACUATION_STARTED_SOUND = 'ev_cosmic_evacuation_alert_start'
        _ON_VEHICLE_ENTER = 'ev_cosmic_evacuation_alert_stop'
        _ON_FRAGMENTS_DELIVERED = 'ev_cosmic_2024_fragment_delivered'

        @classmethod
        def playDeliveryStarted(cls):
            play2DSoundEvent(cls._DELIVERY_STARTED_MUSIC)

        @classmethod
        def playDeliveryFinished(cls):
            play2DSoundEvent(cls._DELIVERY_FINISHED_MUSIC)

        @classmethod
        def playEvacuationStarted(cls):
            play2DSoundEvent(cls._EVACUATION_STARTED_MUSIC)
            play2DSoundEvent(cls._EVACUATION_STARTED_SOUND)

        @classmethod
        def playOnVehicleEnter(cls):
            play2DSoundEvent(cls._ON_VEHICLE_ENTER)

        @classmethod
        def playOnVehicleLeave(cls):
            play2DSoundEvent(cls._EVACUATION_STARTED_SOUND)

        @classmethod
        def playOnFragmentsDelivered(cls):
            play2DSoundEvent(cls._ON_FRAGMENTS_DELIVERED)

    @classmethod
    def playAbilityPickup(cls):
        play2DSoundEvent(cls._ABILITY_PICK_UP_NOTIFICATION)
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