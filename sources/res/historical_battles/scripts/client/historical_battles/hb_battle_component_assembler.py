from arena_component_system.client_arena_component_assembler import ClientArenaComponentAssembler
from arena_components.player_type_specific_components import getPlayerTypeSpecificComponentsForEventBattle

class HBBattleComponentAssembler(ClientArenaComponentAssembler):

    @staticmethod
    def assembleComponents(componentSystem):
        ClientArenaComponentAssembler._assembleBonusCapsComponents(componentSystem)
        ClientArenaComponentAssembler._addArenaComponents(componentSystem, getPlayerTypeSpecificComponentsForEventBattle())