from cosmic_event.skeletons.battle_controller import ICosmicEventBattleController
from gui.Scaleform.daapi.view.battle.shared.battle_loading import BattleLoading
from helpers import dependency

class CosmicBattleLoading(BattleLoading):
    _cosmicController = dependency.descriptor(ICosmicEventBattleController)

    def _populate(self):
        super(CosmicBattleLoading, self)._populate()
        self.as_setTipS(self._cosmicController.prbHintManager.getHintText())
        self._cosmicController.prbHintManager.incrementAndSave()

    def invalidateArenaInfo(self):
        pass

    def _setTipsInfo(self):
        pass

    def _addArenaTypeData(self):
        pass