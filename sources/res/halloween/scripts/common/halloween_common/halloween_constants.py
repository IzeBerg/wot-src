import enum, constants, UnitBase, arena_bonus_type_caps
from constants_utils import ConstInjector, AbstractBattleMode
from halloween_common.battle_results import halloween_results
from BattleFeedbackCommon import BATTLE_EVENT_TYPE as BET

class ARENA_GUI_TYPE(constants.ARENA_GUI_TYPE, ConstInjector):
    HALLOWEEN = 101


class ARENA_BONUS_TYPE(constants.ARENA_BONUS_TYPE, ConstInjector):
    HALLOWEEN = 101
    HALLOWEEN_MEDIUM = 102
    HALLOWEEN_HARD = 103


class QUEUE_TYPE(constants.QUEUE_TYPE, ConstInjector):
    HALLOWEEN = 101
    HALLOWEEN_MEDIUM = 102
    HALLOWEEN_HARD = 103


class PREBATTLE_TYPE(constants.PREBATTLE_TYPE, ConstInjector):
    HALLOWEEN = 101


class UNIT_MGR_FLAGS(UnitBase.UNIT_MGR_FLAGS, ConstInjector):
    HALLOWEEN = 2097152


class ROSTER_TYPE(UnitBase.ROSTER_TYPE, ConstInjector):
    HALLOWEEN = UNIT_MGR_FLAGS.SQUAD | UNIT_MGR_FLAGS.HALLOWEEN


class INVITATION_TYPE(constants.INVITATION_TYPE, ConstInjector):
    HALLOWEEN = PREBATTLE_TYPE.HALLOWEEN


class CLIENT_UNIT_CMD(UnitBase.CLIENT_UNIT_CMD, ConstInjector):
    SET_UNIT_DIFFICULTY_LEVEL = 2001


UNIT_HALLOWEEN_EXTRA_DATA_KEY = 'halloweenData'
UNIT_DIFFICULTY_LEVELS_KEY = 'difficultyLevels'
UNIT_BLOCKED_RENT_VEHICLES_KEY = 'blockedRentVehicles'

class ATTACK_REASON(constants.ATTACK_REASON, ConstInjector):
    _const_type = str
    HALLOWEEN_BOMBER_EXPLOSION = 'halloween_bomber_explosion'
    HALLOWEEN_ABILITY_VAMPIRE = 'halloween_ability_vampire'
    HALLOWEEN_ABILITY_AOE_DAMAGE = 'halloween_ability_aoe_damage'
    HALLOWEEN_ABILITY_IGNITE = 'halloween_ability_ignite'
    HALLOWEEN_PHASE_TIMER = 'halloween_phase_timer'
    HALLOWEEN_PASSIVE_IGNITE = 'halloween_passive_ignite'
    HALLOWEEN_PASSIVE_VAMPIRE = 'halloween_passive_vampire'
    HALLOWEEN_BOSS_AURA = 'halloween_boss_aura'
    HALLOWEEN_DEATH_PIT = 'halloween_death_pit'


DAMAGE_INFO_CODES_PER_ATTACK_REASON = {ATTACK_REASON.HALLOWEEN_BOMBER_EXPLOSION: 'DEATH_FROM_BOMBER_EXPLOSION', 
   ATTACK_REASON.HALLOWEEN_ABILITY_VAMPIRE: 'DEATH_FROM_ABILITY_VAMPIRE', 
   ATTACK_REASON.HALLOWEEN_ABILITY_AOE_DAMAGE: 'DEATH_FROM_ABILITY_AOE_DAMAGE', 
   ATTACK_REASON.HALLOWEEN_ABILITY_IGNITE: 'DEATH_FROM_ABILITY_IGNITE', 
   ATTACK_REASON.HALLOWEEN_PHASE_TIMER: 'DEATH_FROM_PHASE_TIMER', 
   ATTACK_REASON.HALLOWEEN_PASSIVE_IGNITE: 'DEATH_FROM_FIRE', 
   ATTACK_REASON.HALLOWEEN_PASSIVE_VAMPIRE: 'DEATH_FROM_PASSIVE_VAMPIRE', 
   ATTACK_REASON.HALLOWEEN_BOSS_AURA: 'DEATH_FROM_HALLOWEEN_BOSS_AURA', 
   ATTACK_REASON.HALLOWEEN_DEATH_PIT: 'DEATH_FROM_HALLOWEEN_DEATH_PIT'}

class ARENA_BONUS_TYPE_CAPS(arena_bonus_type_caps.ARENA_BONUS_TYPE_CAPS, ConstInjector):
    _const_type = str
    HALLOWEEN = 'HALLOWEEN'


HALLOWEEN_GAME_PARAMS_KEY = 'halloween_config'
NITRO_BUILTIN_EXTRA_PATTERN = 'nitroRamDamage'
BOSS_ROLE_TAG = 'hwrole_boss'
ENEMY_ROLE_TAG_PREFIX = 'hwrole_'
HALLOWEEN_BOMBER_ACTIVATE_REASON = (
 ATTACK_REASON.SHOT, ATTACK_REASON.HALLOWEEN_ABILITY_AOE_DAMAGE, ATTACK_REASON.HALLOWEEN_ABILITY_VAMPIRE)
PLAYERS_TEAM = 1
INVALID_BATTLE_PLACE = -1

class HalloweenBattleMode(AbstractBattleMode):
    _PREBATTLE_TYPE = PREBATTLE_TYPE.HALLOWEEN
    _QUEUE_TYPE = QUEUE_TYPE.HALLOWEEN
    _ARENA_BONUS_TYPE = ARENA_BONUS_TYPE.HALLOWEEN
    _ARENA_GUI_TYPE = ARENA_GUI_TYPE.HALLOWEEN
    _INVITATION_TYPE = INVITATION_TYPE.HALLOWEEN
    _BATTLE_MGR_NAME = 'HalloweenBattlesMgr'
    _UNIT_MGR_NAME = 'HalloweenUnitMgr'
    _UNIT_MGR_FLAGS = UNIT_MGR_FLAGS.HALLOWEEN
    _ROSTER_TYPE = ROSTER_TYPE.HALLOWEEN
    _GAME_PARAMS_KEY = HALLOWEEN_GAME_PARAMS_KEY
    _BATTLE_RESULTS_CONFIG = halloween_results
    _REQUIRED_VEHICLE_TAGS = ('event_battles', )
    _FORBIDDEN_VEHICLE_TAGS = constants.BATTLE_MODE_VEHICLE_TAGS - {'event_battles'}
    _SM_TYPE_ARTEFACT_REWARD_CONGRATS = 'hwArtefactRewardCongrats'
    _SM_TYPE_DIFFICULTY_REWARD_CONGRATS = 'hwDifficultyRewardCongrats'
    _SM_TYPE_DIFFICULTY_OPEN_MESSAGE = 'hwDifficultyOpenMessage'
    _SM_TYPE_VEHICLE_RENT_MESSAGE = 'hwVehicleRentMessage'
    _SM_TYPE_ARTEFACT_KEYS_MESSAGE = 'hwArtefactKeysMessage'
    _SM_TYPE_PURCHASE_BUNDLE_FOR_GOLD_MESSAGE = 'hwPurchaseBundleForGold'
    _SM_TYPE_BATTLE_RESULT = 'hwBattleResults'
    _SM_TYPE_BATTLE_PASS_POINTS_MESSAGE = 'hwBattlePassPointsMessage'
    _SM_TYPES = [
     _SM_TYPE_ARTEFACT_REWARD_CONGRATS,
     _SM_TYPE_DIFFICULTY_REWARD_CONGRATS,
     _SM_TYPE_VEHICLE_RENT_MESSAGE,
     _SM_TYPE_ARTEFACT_KEYS_MESSAGE,
     _SM_TYPE_BATTLE_RESULT]
    _CLIENT_SM_TYPES = [
     _SM_TYPE_PURCHASE_BUNDLE_FOR_GOLD_MESSAGE,
     _SM_TYPE_DIFFICULTY_OPEN_MESSAGE,
     _SM_TYPE_BATTLE_PASS_POINTS_MESSAGE]

    @property
    def _ROSTER_CLASS(self):
        from halloween_common.halloween_roster_config import HalloweenRoster
        return HalloweenRoster


def registerLoggingParams(personality):
    from server_constants import BONUSES_WITH_HEATMAPS
    BONUSES_WITH_HEATMAPS.update({'halloween': (
                   constants.ARENA_BONUS_MASK.TYPE_BITS[ARENA_BONUS_TYPE.HALLOWEEN], False), 
       'halloween_medium': (
                          constants.ARENA_BONUS_MASK.TYPE_BITS[ARENA_BONUS_TYPE.HALLOWEEN_MEDIUM], False), 
       'halloween_hard': (
                        constants.ARENA_BONUS_MASK.TYPE_BITS[ARENA_BONUS_TYPE.HALLOWEEN_HARD], False)})


CURRENT_QUEUE_TYPE_KEY = 'currentQueueType'

class DifficultyLevelToken(object):
    EASY = 'hw23_difficulty_level:easy'
    MEDIUM = 'hw23_difficulty_level:medium'
    HARD = 'hw23_difficulty_level:hard'
    ALWAYS_AVIABLED = (
     EASY,)
    ACCESS_REQUIRED = (MEDIUM, HARD)
    ALL_LEVELS = (EASY, MEDIUM, HARD)


TOKEN_DIFFICULTY_LEVEL_TO_QUEUE_TYPE = {DifficultyLevelToken.EASY: QUEUE_TYPE.HALLOWEEN, 
   DifficultyLevelToken.MEDIUM: QUEUE_TYPE.HALLOWEEN_MEDIUM, 
   DifficultyLevelToken.HARD: QUEUE_TYPE.HALLOWEEN_HARD}
QUEUE_TYPE_TO_TOKEN_DIFFICULTY_LEVEL = {QUEUE_TYPE.HALLOWEEN: DifficultyLevelToken.EASY, 
   QUEUE_TYPE.HALLOWEEN_MEDIUM: DifficultyLevelToken.MEDIUM, 
   QUEUE_TYPE.HALLOWEEN_HARD: DifficultyLevelToken.HARD}
ARENA_BONUS_TYPE_TO_LEVEL = {ARENA_BONUS_TYPE.HALLOWEEN: 1, 
   ARENA_BONUS_TYPE.HALLOWEEN_MEDIUM: 2, 
   ARENA_BONUS_TYPE.HALLOWEEN_HARD: 3}

class ShopSettings(object):
    SHOP_BUNDLE_PREFFIX = 'hw23keysShopBundle'
    PURCHASED_SUFFIX = ':purchased'
    WG_MONEY_CALLBACK = 'purchaseEventShopBundleWGMoney'


class ArtefactsSettings(object):
    ARTEFACT = 'hw23_artefact'
    QUEST_PREFIX = 'hw23_artefact:'
    TOKEN_PREFIX = 'hw23_artefact:'
    KEY_TOKEN = 'hw23_artefact:key'
    KEY_NOTIFY_TOKEN = 'hw23_artefact:notifyKey'
    MEMORY = 'img:hw23_artefact:memory'
    CREW_100 = 'hw23_bonus_crew:100'
    KEY_TOKEN_TTL = 2160
    KEY_TOKEN_LIMIT = 10000


class ArtefactType(object):
    TEXT = 'text'
    SOUND = 'sound'
    FINAL = 'final'


RENT_VEHICLE_PREFIX = 'hw23_rent_vehicle'
KEY_DAILY_QUEST_TPL = 'hw23_key_daily_quest:{intCD}'

class HalloweenSoulsChangeReason(object):
    CHEAT = 0
    COLLECTOR = 1
    BOSS_AURA = 2
    PICK_UP = 3
    VEHICLE_DEATH = 5
    COLLECTOR_RESET = 6


class HWBuffSequenceVisibilityMode(enum.IntEnum):
    NONE = 0
    SELF = 1
    OTHERS = 2
    ALL = 3


class BATTLE_EVENT_TYPE(BET, ConstInjector):
    HW_GAMEPLAY_ACTION = 101


class HalloweenMarkersType(object):
    SOULS_COLLECTOR = 'SOULS_COLLECTOR'
    CAMP = 'CAMP'


class DamageResistanceReason(constants.DamageResistanceReason, ConstInjector):
    NITRO = 101
    DAMAGE_SHIELD = 102
    MODULES_INVULNERABILITY_BUFF = 103
    BOSS_DAMAGE_SHIELD = 104


class HWRepairReason(object):
    NONE = 0
    BASIC_REPAIR = 1
    REPAIR_BY_AOE_ABILITY_VAMPIRE = 2
    REPAIR_BY_PASSIVE_VAMPIRE = 3
    REPAIR_BY_INFINITE_REGENERATION = 4
    REPAIR_BY_AOE_TEAM_REPAIR_KIT = 5


HALLOWEEN_CHAT_CHANNEL = '#halloween.halloween_chat:channels/halloween'
HW_EMPTY_SLOTS_EQ = ('halloweenEmptySlot0', 'halloweenEmptySlot1', 'halloweenEmptySlot2')
HW_BUILT_IN_EQUIPMENT = ('nitroRamDamage', )
INVALID_PHASE = 0