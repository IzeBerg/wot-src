from halloween.gui.halloween_gui_constants import DifficultyLevel
from shared_utils import CONST_CONTAINER
from sound_gui_manager import CommonSoundSpaceSettings
from gui.sounds.filters import States, StatesGroup
from gui.Scaleform.daapi.view.lobby.hangar.Hangar import Hangar
from halloween_common.halloween_constants import ARENA_BONUS_TYPE
from halloween.gui.sounds.voiceovers import Voiceover

class SoundLanguage(CONST_CONTAINER):
    RU_VOICEOVER_REALM_CODES = ('RU', 'ST', 'QA', 'DEV', 'SB')
    VOICEOVER_LOCALIZATION_SWITCH = 'SWITCH_ext_ev_hw_vo'
    VOICEOVER_CN = 'SWITCH_ext_ev_hw_vo_CN'
    VOICEOVER_RU = 'SWITCH_ext_ev_hw_vo_RU'
    VOICEOVER_UA = 'SWITCH_ext_ev_hw_vo_UA'
    VOICEOVER_EN = 'SWITCH_ext_ev_hw_vo_EN'
    LANGUAGE_UA = 'uk'
    LANGUAGE_RU = 'ru'


PROMO_ENTER = 'ev_hw_hangar_promo_screen_enter'
PROMO_EXIT = 'ev_hw_hangar_promo_screen_exit'
HW_ENTER_EVENT = 'ev_hw_main_enter'
HW_EXIT_EVENT = 'ev_hw_main_exit'
ABOUT_GAME_MODE_ENTER = 'ev_hw_hangar_info_gamemode_enter'
ABOUT_GAME_MODE_EXIT = 'ev_hw_hangar_info_gamemode_exit'
REWARD_PATH_ENTER = 'ev_hw_hangar_reward_path_enter'
REWARD_PATH_EXIT = 'ev_hw_hangar_reward_path_exit'
META_INTRO_ENTER = 'ev_hw_hangar_info_missions_enter'
META_INTRO_EXIT = 'ev_hw_hangar_info_missions_exit'
CONSUMABLES_VIEW_ENTER = 'ev_hw_hangar_consumables_enter'
CONSUMABLES_VIEW_EXIT = 'ev_hw_hangar_consumables_exit'
COMPARISON_VIEW_ENTER = 'ev_hw_mirny13_hangar_comparison_enter'
COMPARISON_VIEW_EXIT = 'ev_hw_mirny13_hangar_comparison_exit'
PRE_QUEUE_ENTER = 'ev_hw_hangar_matchmaker_enter'
PRE_QUEUE_EXIT = 'ev_hw_hangar_matchmaker_exit'
HW_PREVIEW_ENTER = 'ev_hw_hangar_tank_preview_enter'
HW_PREVIEW_EXIT = 'ev_hw_hangar_tank_preview_exit'
META_QUANTUM_OPEN_SOUND = 'ev_hw_meta_quantum{}_enter'
META_QUANTUM_CLOSE_SOUND = 'ev_hw_meta_quantum{}_exit'
META_VOICEOVER_UNMUTE = 'ev_hw_meta_quantum_sound_on'
META_VOICEOVER_MUTE = 'ev_hw_meta_quantum_sound_off'
META_VOICEOVER_BUTTON_CLICK_UNMUTE = 'ev_hw_meta_quantum_button_sound_on'
META_VOICEOVER_BUTTON_CLICK_MUTE = 'ev_hw_meta_quantum_button_sound_off'
PBS_ENTER = 'ev_hw_pbs_screen_enter'
PBS_EXIT = 'ev_hw_pbs_screen_exit'
REWARD_SCREEN_ENTER = 'ev_hw_mirny13_reward_screen_enter'
REWARD_SCREEN_EXIT = 'ev_hw_mirny13_reward_screen_exit'
KING_REWARD_WINDOW_ENTER = 'ev_hw_mirny13_king_reward_screen_enter'
KING_REWARD_WINDOW_EXIT = 'ev_hw_mirny13_king_reward_screen_exit'
ARENA_PHASE_END_WARNING_EVENT_PREFIX = 'ev_hw_mirny13_music_gp_1min_{phase:02d}'
DIFFICULTY_SCREEN = {DifficultyLevel.MEDIUM: 'ev_hw_hangar_difficulty_open_hard', 
   DifficultyLevel.HARD: 'ev_hw_hangar_difficulty_open_nightmare', 
   DifficultyLevel.DEFENCE: 'ev_hw_hangar_difficulty_open_defense'}

class DifficultyWindowState(CONST_CONTAINER):
    GROUP = 'STATE_hangar_filtered'
    OPEN = 'STATE_hangar_filtered_on'
    CLOSE = 'STATE_hangar_filtered_off'


class KingRewardState(CONST_CONTAINER):
    GROUP = 'STATE_overlay_hangar_general'
    GENERAL_ON = 'STATE_overlay_hangar_general_on'
    GENERAL_OFF = 'STATE_overlay_hangar_general_off'


class PersonalDeathZoneAbilityBossState(CONST_CONTAINER):
    GROUP = 'STATE_ev_halloween_2021_ability_boss'
    ENTER = 'STATE_ev_halloween_2021_ability_boss_enter'
    EXIT = 'STATE_ev_halloween_2021_ability_boss_exit'


BOTS_SPAWN = {'germany:G64_Panther_II_Hall_minion': 'ev_halloween_2019_gameplay_spawn_hunter', 
   'usa:A100_T49_HW_BOT': 'ev_hw_mirny13_gameplay_lost_spawn', 
   'germany:G25_PzII_Luchs_HELL_HALL': 'ev_halloween_2019_gameplay_spawn_bunny', 
   'germany:G25_PzII_Luchs_HELL': 'ev_halloween_2019_gameplay_spawn_bunny', 
   'germany:G00_Bomber_Hell': 'ev_halloween_2019_gameplay_spawn_yorsh', 
   'germany:G00_K_bomber__HW_21_AI': 'ev_halloween_2021_gameplay_bomber_queen_spawn', 
   'france:F110_Lynx_6x6_HW_BOT': 'ev_hw_gameplay_spawn_trapper', 
   'germany:G146_E100_Hell_Boss': None, 
   'usa:A66_M103_Boss_HW23': None, 
   'ussr:R205_Rozanov_Boss_HW23': None}
DEFAULT_BOT_SPAWN = 'ev_halloween_2019_gameplay_spawn_default'
BOTS_ENGINE = {'usa:A100_T49_HW_BOT': 'ev_hw_mirny13_gameplay_lost_engine', 
   'germany:G114_Rheinmetall_Skorpian_HW_BOT': 'ev_hw_mirny13_gameplay_miniboss_engine', 
   'germany:G99_RhB_Waffentrager_HW_BOT': 'ev_hw_mirny13_gameplay_miniboss_engine', 
   'germany:G97_Waffentrager_IV_HW_BOT': 'ev_hw_mirny13_gameplay_miniboss_engine', 
   'germany:G54_E-50_Hall_minion': 'ev_hw_mirny13_gameplay_miniboss_engine', 
   'uk:GB81_FV4004_HW_BOT': 'ev_hw_mirny13_gameplay_miniboss_engine', 
   'uk:GB83_FV4005_HELL': 'ev_hw_mirny13_gameplay_miniboss_engine', 
   'germany:G73_E50_Ausf_M_Hall_minion': 'ev_hw_mirny13_gameplay_miniboss_engine'}
BOTS_EXPLOSION = {'germany:G00_Bomber_Hell': 'ev_halloween_2019_gameplay_bomber_explosion', 
   'germany:G00_K_bomber__HW_21_AI': 'ev_halloween_2021_gameplay_bomber_queen_explosion', 
   'usa:A100_T49_HW_BOT': 'ev_hw_mirny13_gameplay_lost_explosion', 
   'germany:G114_Rheinmetall_Skorpian_HW_BOT': 'ev_hw_mirny13_gameplay_miniboss_explosion', 
   'germany:G99_RhB_Waffentrager_HW_BOT': 'ev_hw_mirny13_gameplay_miniboss_explosion', 
   'germany:G97_Waffentrager_IV_HW_BOT': 'ev_hw_mirny13_gameplay_miniboss_explosion', 
   'germany:G54_E-50_Hall_minion': 'ev_hw_mirny13_gameplay_miniboss_explosion', 
   'uk:GB81_FV4004_HW_BOT': 'ev_hw_mirny13_gameplay_miniboss_explosion', 
   'uk:GB83_FV4005_HELL': 'ev_hw_mirny13_gameplay_miniboss_explosion', 
   'germany:G73_E50_Ausf_M_Hall_minion': 'ev_hw_mirny13_gameplay_miniboss_explosion'}

class VehicleSoulsContainerSounds(CONST_CONTAINER):

    class Player(CONST_CONTAINER):
        ON = 'ev_hw_mirny13_gameplay_mini_collector_on'
        OFF = 'ev_hw_mirny13_gameplay_mini_collector_off'

    class Ally(CONST_CONTAINER):
        ON = 'ev_hw_mirny13_gameplay_mini_collector_on_npc'
        OFF = 'ev_hw_mirny13_gameplay_mini_collector_off_npc'


class SoulsCollectorSounds(CONST_CONTAINER):
    RTPC = 'RTPC_ext_hw19_collector_capacity'
    LOOP = 'ev_halloween_2019_gameplay_collector_loop'
    COLLECT = 'ev_hw_gameplay_collect_mirium'


BATTLE_START = 'ev_halloween_2019_gameplay_start'
BATTLE_FINISH = 'ev_halloween_2019_gameplay_stop'
PHASE_CHANGED = 'ev_halloween_2019_gameplay_teleportation'

class DeathZoneSounds(CONST_CONTAINER):
    ENTER = 'ev_halloween_2021_red_zone_red_enter'
    LEAVE = 'ev_halloween_2021_red_zone_red_exit'
    DAMAGE = 'ev_halloween_2021_red_zone_red_damage'


class PersonalDeathZoneSounds(CONST_CONTAINER):
    ACTIVATION = 'ev_halloween_2021_ability_death_zone_activation'
    DEACTIVATION = 'ev_halloween_2021_ability_death_zone_deactivation'


class PostMortemSounds(CONST_CONTAINER):
    ON = 'ev_halloween_2021_postmortem_on'
    OFF = 'ev_halloween_2021_postmortem_off'


ACTIVE_PHASE_RTPC = 'RTPC_ext_hw19_world'

class ActivePhaseState(CONST_CONTAINER):
    GROUP = 'STATE_ev_halloween_2019_world'
    PHASE_1 = 'STATE_ev_halloween_2019_world_m1'
    PHASE_2 = 'STATE_ev_halloween_2019_world_m2'
    PHASE_3 = 'STATE_ev_halloween_2019_world_m3'
    PHASE_4 = PHASE_1
    DEFAULT = PHASE_1
    _STATE_PATTERN = 'PHASE_{}'

    @classmethod
    def getStateByPhase(cls, phaseID):
        return getattr(cls, cls._STATE_PATTERN.format(phaseID), cls.DEFAULT)


SOULS_COLLECTOR_OBJ_NAME = 'hwSoulsCollector'
VEHICLE_OBJ_NAME_PATTERN = 'hwVehicleSound_{}'

class Difficulty(CONST_CONTAINER):
    EASY = 'normal'
    MEDIUM = 'hard'
    HARD = 'nightmare'
    DEFENCE = 'defense'
    DEFAULT = EASY
    _DIFFICULTY_BY_ARENA_BONUS_TYPE = {ARENA_BONUS_TYPE.HALLOWEEN: EASY, 
       ARENA_BONUS_TYPE.HALLOWEEN_MEDIUM: MEDIUM, 
       ARENA_BONUS_TYPE.HALLOWEEN_HARD: HARD, 
       ARENA_BONUS_TYPE.HALLOWEEN_DEFENCE: DEFENCE}

    @classmethod
    def getDifficultyByArenaBonusType(cls, arenaBonusType):
        return cls._DIFFICULTY_BY_ARENA_BONUS_TYPE.get(arenaBonusType, cls.DEFAULT)


class DifficultyFormatter(object):

    def __init__(self, str_):
        self._str = str_

    def __call__(self, arenaBonusType):
        return self._str.format(dif=Difficulty.getDifficultyByArenaBonusType(arenaBonusType))


class DifficultyState(CONST_CONTAINER):
    GROUP = 'STATE_ev_hw_difficulty'
    VALUE = DifficultyFormatter('STATE_ev_hw_difficulty_{dif}')


class BossBattleMusic(CONST_CONTAINER):
    BOSS_FIGHT_START = DifficultyFormatter('ev_hw_music_bf_{dif}_start')
    FIRST_DAMAGE_2_LIVES_LEFT = DifficultyFormatter('ev_hw_music_bf_{dif}_1_2')
    FIRST_DAMAGE_1_LIVES_LEFT = DifficultyFormatter('ev_hw_music_bf_{dif}_2_2')
    PHASE_1_FINISH = DifficultyFormatter('ev_hw_music_bf_{dif}_2_1')
    BOSS_KILLED = DifficultyFormatter('ev_hw_music_bf_{dif}_win')
    LOSE_2_LIVES_LEFT_BEFORE_1_SHOT = DifficultyFormatter('ev_hw_music_bf_{dif}_lose_1_1')
    LOSE_2_LIVES_LEFT_AFTER_1_SHOT = DifficultyFormatter('ev_hw_music_bf_{dif}_lose_1_2')
    LOSE_1_LIVES_LEFT_BEFORE_1_SHOT = DifficultyFormatter('ev_hw_music_bf_{dif}_lose_2_1')
    LOSE_1_LIVES_LEFT_AFTER_1_SHOT = DifficultyFormatter('ev_hw_music_bf_{dif}_lose_2_2')

    @classmethod
    def getFirstDamageEventByBossLives(cls, livesLeft):
        return getattr(cls, ('FIRST_DAMAGE_{}_LIVES_LEFT').format(livesLeft), cls.FIRST_DAMAGE_2_LIVES_LEFT)

    @classmethod
    def getLoseEvent(cls, isFirstShotPerformed, livesLeft):
        state = 'AFTER' if isFirstShotPerformed else 'BEFORE'
        return getattr(cls, ('LOSE_{}_LIVES_LEFT_{}_1_SHOT').format(livesLeft, state), cls.LOSE_2_LIVES_LEFT_BEFORE_1_SHOT)


class BattleEquipmentPanelSounds(CONST_CONTAINER):
    ACTIVATE = 'ev_halloween_2019_ui_ability_button'
    READY = 'ev_halloween_2019_ui_ability_button_ready'
    NOT_READY = 'ev_halloween_2019_ui_ability_button_not_ready'


class BattleBuffsPanelSounds(CONST_CONTAINER):
    ACTIVATE = 'ev_hw_mirny13_gameplay_random_buff_hud_on'
    DEACTIVATE = 'ev_hw_mirny13_gameplay_random_buff_hud_off'
    SHOW_ICON = 'ev_hw_mirny13_gameplay_random_buff_icon'


class BossBattleSound(CONST_CONTAINER):
    PLAYER_ENTERED_AURA = 'ev_halloween_2019_gameplay_boss_eating_start'
    PLAYER_LEAVED_AURA = 'ev_halloween_2019_gameplay_boss_eating_stop'
    AURA_ACTIVATION = 'ev_halloween_2019_gameplay_boss_aura'
    _BOSS_TELEPORT = {ARENA_BONUS_TYPE.HALLOWEEN: 'ev_hw_gameplay_boss_1_teleport', 
       ARENA_BONUS_TYPE.HALLOWEEN_MEDIUM: 'ev_hw_gameplay_boss_2_teleport', 
       ARENA_BONUS_TYPE.HALLOWEEN_HARD: 'ev_hw_gameplay_boss_3_teleport'}
    _BOSS_DAMAGE = {ARENA_BONUS_TYPE.HALLOWEEN: 'ev_hw_gameplay_boss_1_damage', 
       ARENA_BONUS_TYPE.HALLOWEEN_MEDIUM: 'ev_hw_gameplay_boss_2_damage', 
       ARENA_BONUS_TYPE.HALLOWEEN_HARD: 'ev_hw_gameplay_boss_3_damage'}

    @classmethod
    def getAuraIntersectionEvent(cls, entered):
        action = 'ENTERED' if entered else 'LEAVED'
        return getattr(cls, ('PLAYER_{}_AURA').format(action))

    @classmethod
    def getBossTeleportationEvent(cls, arenaType):
        return cls._BOSS_TELEPORT[arenaType]

    @classmethod
    def getBossDamageEvent(cls, arenaType):
        return cls._BOSS_DAMAGE[arenaType]


class PhaseStartedVoiceover(CONST_CONTAINER):
    PHASE_1 = Voiceover('ev_hw_mirny13_vo_phase1_intro', 'ev_hw_mirny13_vo_phase1_exposition_intro')
    PHASE_2 = Voiceover('ev_hw_mirny13_vo_phase2_intro')
    PHASE_3 = Voiceover('ev_hw_mirny13_vo_phase3_intro')
    PHASE_4 = Voiceover('ev_hw_mirny13_vo_bossfight_intro', 'ev_hw_mirny13_vo_bossfight_exposition_intro')
    PHASE_5 = Voiceover('ev_hw_mirny13_vo_phase3_intro')

    @classmethod
    def get(cls, phaseIndex):
        return getattr(cls, ('PHASE_{}').format(phaseIndex), None)


class VO(CONST_CONTAINER):
    BOSS_APPEARING = {'germany:G146_E100_Hell_Boss': 'ev_hw_mirny13_vo_phase_boss_approaching', 
       'usa:A66_M103_Boss_HW23': 'ev_hw_mirny13_vo_phase_boss_approaching', 
       'ussr:R205_Rozanov_Boss_HW23': 'ev_hw_mirny13_vo_phase_boss_approaching'}
    WIN = Voiceover('ev_hw_vo_bossfight_win', 'ev_hw_vo_bossfight_exposition_win', False)
    LOSE_BEFORE_BOSS_BATTLE = 'ev_hw_vo_phase_lose'
    FIRST_SHOT_AT_BOSS_BEFORE_BOSS_BATTLE = Voiceover('ev_hw_mirny13_vo_phase_boss_shooting', aliveOnly=True)
    BOSS_FIGHT_PHASE_2 = 'ev_hw_mirny13_vo_bossfight_phase2'
    LOSE_BOSS_FIGHT = 'ev_hw_vo_bossfight_lose'
    PHASE_ONE_MINUTE_LEFT = Voiceover('ev_hw_mirny13_vo_phase_one_minute_timer', aliveOnly=True)
    COLLECTOR_HALF_FILLED = Voiceover('ev_hw_mirny13_vo_phase_collector_half', aliveOnly=True)
    COLLECTOR_FULL_FILLED = Voiceover('ev_hw_mirny13_vo_phase_collector_full', aliveOnly=True)
    PLAYER_DEAD_BEFORE_BOSSFIGHT = 'ev_hw_mirny13_vo_player_dead'
    PLAYER_DEAD_FIRST_PART_BOSSFIGHT = 'ev_hw_mirny13_vo_player_bossfight_dead'
    ALLY_4_TANKS_LEFT = Voiceover('ev_hw_mirny13_vo_4_tanks_left', aliveOnly=True)
    ALLY_3_TANKS_LEFT = Voiceover('ev_hw_mirny13_vo_3_tanks_left', aliveOnly=True)
    ALLY_2_TANKS_LEFT = Voiceover('ev_hw_mirny13_vo_2_tanks_left', aliveOnly=True)
    ALLY_1_TANKS_LEFT = Voiceover('ev_hw_mirny13_vo_player_last', aliveOnly=True)

    @classmethod
    def getAllyTanksLeftVO(cls, alliesAliveCount):
        return getattr(cls, ('ALLY_{}_TANKS_LEFT').format(alliesAliveCount), None)


class LootSounds(CONST_CONTAINER):
    PICKUP_SUCCEED = {'lootSoulsSmall': 'ev_halloween_2019_gameplay_collect', 
       'lootSoulsMedium': 'ev_halloween_2019_gameplay_collect', 
       'lootSoulsBig': 'ev_halloween_2019_gameplay_collect', 
       'lootShells': 'ev_halloween_2020_gameplay_collect_buff'}


HANGAR_SOUND_SETTINGS = CommonSoundSpaceSettings(name='hwHangar', entranceStates={Hangar.SOUND_STATE_PLACE: Hangar.SOUND_STATE_PLACE_GARAGE, StatesGroup.HANGAR_FILTERED: States.HANGAR_FILTERED_OFF}, exitStates={}, persistentSounds=(), stoppableSounds=(), priorities=(), autoStart=True, enterEvent='', exitEvent='')

class DefVO(CONST_CONTAINER):
    PLAYER_DEAD = 'ev_hw_vo_def_player_dead'
    ALLY_4_TANKS_LEFT = Voiceover('ev_hw_vo_def_4_tanks_left', aliveOnly=True)
    ALLY_3_TANKS_LEFT = Voiceover('ev_hw_vo_def_3_tanks_left', aliveOnly=True)
    ALLY_2_TANKS_LEFT = Voiceover('ev_hw_vo_def_2_tanks_left', aliveOnly=True)
    ALLY_1_TANKS_LEFT = Voiceover('ev_hw_vo_def_player_last', aliveOnly=True)
    BATTLE_STARTED = 'ev_hw_vo_def_start'
    WAVE_2_STARTED = 'ev_hw_vo_def_bots_spawn_02'
    WAVE_3_STARTED = 'ev_hw_vo_def_bots_spawn_03'
    WAVE_4_STARTED = 'ev_hw_vo_def_bots_spawn_04'
    WAVE_5_STARTED = 'ev_hw_vo_def_final_bots_spawn'
    WAVE_FINISHED = Voiceover('ev_hw_vo_def_destroyed_all_bots', aliveOnly=True)
    ONE_MINUTE_LEFT = 'ev_hw_vo_def_1min'
    WIN = 'ev_hw_vo_def_win'
    LOSE = 'ev_hw_vo_def_lose'

    @classmethod
    def getWaveStartedVO(cls, phase):
        return getattr(cls, ('WAVE_{}_STARTED').format(phase), None)

    @classmethod
    def getAllyTanksLeftVO(cls, alliesAliveCount):
        return getattr(cls, ('ALLY_{}_TANKS_LEFT').format(alliesAliveCount), None)


class DefBattleMusic(CONST_CONTAINER):
    WAVE_STARTED = 'ev_hw_music_def_battle'
    BOTS_DESTROYED = 'ev_hw_music_def_exploration'
    WIN = 'ev_hw_music_def_end'