from arena_components.epic_battle_player_data_component import EpicBattlePlayerDataComponent
from player_data_component import PlayerDataComponent
from advanced_chat_component import AdvancedChatComponent
from arena_component_system.epic_sector_warning_component import EpicSectorWarningComponent
from arena_component_system.arena_equipment_component import ArenaEquipmentComponent
from arena_component_system.overtime_component import OvertimeComponent

def getPlayerTypeSpecificComponentsForEpicRandom():
    return {'playerDataComponent': PlayerDataComponent}


def getPlayerTypeSpecificComponentsForEpicBattle():
    return {'playerDataComponent': EpicBattlePlayerDataComponent, 
       'sectorWarningComponent': EpicSectorWarningComponent, 
       'overtimeComponent': OvertimeComponent}


def getDefaultComponents():
    return {'arenaEquipmentComponent': ArenaEquipmentComponent, 
       'advancedChatComponent': AdvancedChatComponent}