from cosmic_event.skeletons.battle_controller import ICosmicEventBattleController
from gui.battle_control.arena_info.arena_descrs import ArenaWithBasesDescription
from helpers import dependency

class CosmicArenaDescription(ArenaWithBasesDescription):
    _cosmicController = dependency.descriptor(ICosmicEventBattleController)

    def getScreenIcon(self):
        return self._cosmicController.prbHintManager.getHintImagePath()