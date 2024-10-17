from enum import IntEnum
from constants_utils import ConstInjector
from gui.battle_control.controllers.battle_hints.queues import BattleHintQueueParams
from gui.prb_control import settings
from gui.Scaleform.daapi.settings import views
from halloween_common.halloween_constants import QUEUE_TYPE, HALLOWEEN_CHAT_CHANNEL
from gui.battle_control.battle_constants import FEEDBACK_EVENT_ID as _FET, BATTLE_CTRL_ID as _BASE_CTRL_ID
from messenger.m_constants import LAZY_CHANNEL as CHANNEL

class PREBATTLE_ACTION_NAME(settings.PREBATTLE_ACTION_NAME, ConstInjector):
    _const_type = str
    HALLOWEEN = 'halloween'
    HALLOWEEN_SQUAD = 'halloween_squad'


class FUNCTIONAL_FLAG(settings.FUNCTIONAL_FLAG, ConstInjector):
    HALLOWEEN = 4294967296


class SELECTOR_BATTLE_TYPES(settings.SELECTOR_BATTLE_TYPES, ConstInjector):
    _const_type = str
    HALLOWEEN = 'halloween'


class VIEW_ALIAS(views.VIEW_ALIAS, ConstInjector):
    _const_type = str
    HALLOWEEN_BATTLE_PAGE = 'HalloweenBattlePage'
    HW_OVERLAY_WEB_STORE = 'hwOverlayWebStore'
    HALLOWEEN_DEFENCE_BATTLE_PAGE = 'HalloweenDefenceBattlePage'


class DifficultyLevel(IntEnum):
    EASY = 1
    MEDIUM = 2
    HARD = 3
    DEFENCE = 4


QUEUE_TYPE_TO_DIFFICULTY_LEVEL = {QUEUE_TYPE.HALLOWEEN: DifficultyLevel.EASY, 
   QUEUE_TYPE.HALLOWEEN_MEDIUM: DifficultyLevel.MEDIUM, 
   QUEUE_TYPE.HALLOWEEN_HARD: DifficultyLevel.HARD, 
   QUEUE_TYPE.HALLOWEEN_DEFENCE: DifficultyLevel.DEFENCE}

class FEEDBACK_EVENT_ID(_FET, ConstInjector):
    HW_GAMEPLAY_ACTION = 101
    HW_VEHICLE_MARKER_HEALTH = 102


class SoulsCollectorMarkerStates(IntEnum):
    NOT_ENOUGHT_SOULS = 0
    MOVE_TO_SOULS_COLLECTOR = 1


class BATTLE_CTRL_ID(_BASE_CTRL_ID, ConstInjector):
    HW_BATTLE_GUI_CTRL = 101


HALLOWEEN_CAROUSEL_VEHICLE_TOOLTIP = 'halloweenCarouselVehicle'
HALLOWEEN_CAROUSEL_VEHICLE_TOOLTIP_DEF = 'halloweenCarouselVehicleDef'
HALLOWEEN_ABILITY_TOOLTIP = 'halloweenAbility'
HALLOWEEN_MAIN_SHELL = 'halloweenMainShell'
HALLOWEEN_TOOLTIP_SET = [
 HALLOWEEN_CAROUSEL_VEHICLE_TOOLTIP,
 HALLOWEEN_ABILITY_TOOLTIP,
 HALLOWEEN_MAIN_SHELL,
 HALLOWEEN_CAROUSEL_VEHICLE_TOOLTIP_DEF]

class LAZY_CHANNEL(CHANNEL, ConstInjector):
    _const_type = str
    HALLOWEEN_GLOBAL_CHANNEL = HALLOWEEN_CHAT_CHANNEL


HALLOWEEN_BATTLE_HINTS_QUEUE_ID = BattleHintQueueParams(name='halloween', withFadeOut=True)
LUI_RULE_HW_ENTRY_POINT = 'HalloweenEntryPoint'
LUI_RULES_HW = [LUI_RULE_HW_ENTRY_POINT]