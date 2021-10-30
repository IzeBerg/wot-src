from gui.prb_control.storages.local_storage import SessionStorage

class EpicStorage(SessionStorage):

    def _determineSelection(self, arenaVisitor):
        return arenaVisitor.gui.isEpicBattle()