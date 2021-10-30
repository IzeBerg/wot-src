from arena_components.epic_battle_player_data_component import EpicBattlePlayerDataComponent
from player_data_component import PlayerDataComponent
from advanced_chat_component import AdvancedChatComponent
from arena_component_system.epic_sector_warning_component import EpicSectorWarningComponent
from arena_component_system.arena_equipment_component import ArenaEquipmentComponent
from arena_component_system.overtime_component import OvertimeComponent
from arena_component_system.arena_game_event_component import GameEventComponent
from arena_components.effects_list_cache import EffectsListCacheComponent

def getPlayerTypeSpecificComponentsForEpicRandom():
    return {'playerDataComponent': PlayerDataComponent}


def getPlayerTypeSpecificComponentsForEpicBattle():
    return {'playerDataComponent': EpicBattlePlayerDataComponent, 
       'sectorWarningComponent': EpicSectorWarningComponent, 
       'overtimeComponent': OvertimeComponent}


def getDefaultComponents():
    return {'arenaEquipmentComponent': ArenaEquipmentComponent, 
       'advancedChatComponent': AdvancedChatComponent}


def getPlayerTypeSpecificComponentsForEventBattle():
    return {'gameEventComponent': GameEventComponent, 
       'effectsListCache': EffectsListCacheComponent}