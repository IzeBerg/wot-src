from gui.prb_control.storages.local_storage import SessionStorage

class BattleRoyaleStorage(SessionStorage):

    def _determineSelection(self, arenaVisitor):
        return arenaVisitor.gui.isBattleRoyale()