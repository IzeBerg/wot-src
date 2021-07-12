from gui.prb_control.storages.local_storage import SessionStorage

class RankedStorage(SessionStorage):

    def _determineSelection(self, arenaVisitor):
        return arenaVisitor.gui.isRankedBattle()