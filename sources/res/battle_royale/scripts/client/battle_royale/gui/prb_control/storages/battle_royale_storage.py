from gui.prb_control.storages.local_storage import SessionStorage
from helpers import dependency
from skeletons.gui.game_control import IBattleRoyaleController

class BattleRoyaleStorage(SessionStorage):

    def _determineSelection(self, arenaVisitor):
        battleRoyale = dependency.instance(IBattleRoyaleController)
        return battleRoyale.wasInLobby() and arenaVisitor.gui.isBattleRoyale()