from gui.Scaleform.daapi.view.battle.shared.battle_loading import BattleLoading
from helpers import dependency
from skeletons.gui.lobby_context import ILobbyContext

class EpicBattleLoading(BattleLoading):
    lobbyContext = dependency.descriptor(ILobbyContext)

    def _getBattlesCount(self):
        return self.lobbyContext.getEpicBattlesCount()