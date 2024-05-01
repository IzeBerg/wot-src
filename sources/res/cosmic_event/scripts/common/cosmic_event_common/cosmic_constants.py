import constants, BattleFeedbackCommon
from constants_utils import ConstInjector, AbstractBattleMode
from battle_results import cosmic_event
import arena_bonus_type_caps
COSMIC_EVENT_ROCKET_BOOSTER = 'cosmic_event_rocket_booster'
COSMIC_EVENT_SHIELD = 'cosmic_event_shield'
COSMIC_EVENT_VORTEX = 'cosmic_event_vortex'
COSMIC_EVENT_REPULSOR = 'cosmic_event_repulsor'
COSMIC_EVENT_JUMP = 'cosmic_event_jump'
COSMIC_EVENT_MINES = 'cosmic_event_mines'
VEHICLE_TELEPORTATION_TIMEOUT = 0.55

class ARENA_GUI_TYPE(constants.ARENA_GUI_TYPE, ConstInjector):
    COSMIC_EVENT = 32


class ARENA_BONUS_TYPE(constants.ARENA_BONUS_TYPE, ConstInjector):
    COSMIC_EVENT = 45


class PREBATTLE_TYPE(constants.PREBATTLE_TYPE, ConstInjector):
    COSMIC_EVENT = 25


class QUEUE_TYPE(constants.QUEUE_TYPE, ConstInjector):
    COSMIC_EVENT = 31


class GameSeasonType(constants.GameSeasonType, ConstInjector):
    COSMIC_EVENT = 8


class BATTLE_EVENT_TYPE(BattleFeedbackCommon.BATTLE_EVENT_TYPE, ConstInjector):
    COSMIC_KILL = 25
    COSMIC_RAMMING = 26
    COSMIC_PICKUP_ABILITY = 27
    COSMIC_ABILITY_HIT = 28
    COSMIC_SHOT = 29
    COSMIC_FRAGMENT_PICKUP = 30
    COSMIC_FRAGMENT_CARRYING = 31
    COSMIC_FRAGMENT_DELIVERING = 32
    COSMIC_KILL_ASSIST = 33
    COSMIC_FRAGMENT_HOLDER_KILL = 34
    COSMIC_EVACUATION = 35


class LOOT_TYPE(constants.LOOT_TYPE, ConstInjector):
    COSMIC_VORTEX = 5
    COSMIC_REPULSOR = 6
    COSMIC_JUMP = 7
    COSMIC_MINES = 8


class PhaseTypes(object):
    NONE = 'none'
    PREBATTLE = 'prebattle'
    IDLE = 'idle'
    DELIVERY = 'delivery'
    EVACUATION = 'evacuation'


class ZoneTypes(object):
    STATIC = 'static'
    EVACUATION = 'evacuation'


class DailyQuestsDecorations(constants.DailyQuestsDecorations, ConstInjector):
    COSMIC_DESTROY_TANK = 'cosmic_kill_vehicles'
    COSMIC_PLAY_BATTLES = 'cosmic_play_battles'
    COSMIC_MARS_POINTS = 'cosmic_mars_points'


class ARENA_BONUS_TYPE_CAPS(arena_bonus_type_caps.ARENA_BONUS_TYPE_CAPS, ConstInjector):
    _const_type = str
    COSMIC_EVENT = 'COSMIC_EVENT'


DailyQuestDecorationMap = {13: DailyQuestsDecorations.COSMIC_PLAY_BATTLES, 
   14: DailyQuestsDecorations.COSMIC_DESTROY_TANK, 
   15: DailyQuestsDecorations.COSMIC_MARS_POINTS}
COSMIC_EVENT_GAME_PARAMS_KEY = 'cosmic_event_battles_config'
COSMIC_EVENT_CONFIG = 'cosmic_event_config'
COSMIC_CGF_CATEGORY = 'Cosmic'

def registerDailyQuestsDecorations(personality):
    DailyQuestsDecorations.inject(personality)
    for decorator_id in DailyQuestDecorationMap:
        msg = ('Quest decorator id collision: {}').format(decorator_id)

    constants.DailyQuestDecorationMap = constants.DailyQuestDecorationMap.update(DailyQuestDecorationMap)


def registerLootTypes(personality):
    LOOT_TYPE.inject(personality)


class CosmicEventBattleMode(AbstractBattleMode):
    _PREBATTLE_TYPE = PREBATTLE_TYPE.COSMIC_EVENT
    _QUEUE_TYPE = QUEUE_TYPE.COSMIC_EVENT
    _ARENA_BONUS_TYPE = ARENA_BONUS_TYPE.COSMIC_EVENT
    _ARENA_GUI_TYPE = ARENA_GUI_TYPE.COSMIC_EVENT
    _BATTLE_MGR_NAME = 'CosmicEventBattlesMgr'
    _SINGLETON_MGR_GROUP = 6
    _GAME_PARAMS_KEY = COSMIC_EVENT_GAME_PARAMS_KEY
    _SEASON_TYPE_BY_NAME = 'cosmic_event_battle'
    _SEASON_TYPE = GameSeasonType.COSMIC_EVENT
    _SEASON_MANAGER_TYPE = (GameSeasonType.COSMIC_EVENT, COSMIC_EVENT_CONFIG)
    _BATTLE_RESULTS_CONFIG = cosmic_event
    _SM_TYPE_BATTLE_RESULT = 'cosmicEventBattleResults'
    _SM_TYPES = [_SM_TYPE_BATTLE_RESULT]

    @property
    def _battleMgrConfig(self):
        return (self._BATTLE_MGR_NAME, 0.2, self._SINGLETON_MGR_GROUP, ('periphery', 'standalone'))