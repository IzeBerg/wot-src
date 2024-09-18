from arena_component_system.client_arena_component_assembler import ClientArenaComponentAssembler

class EventBattlesComponentAssembler(ClientArenaComponentAssembler):

    @staticmethod
    def assembleComponents(componentSystem):
        ClientArenaComponentAssembler._assembleBonusCapsComponents(componentSystem)