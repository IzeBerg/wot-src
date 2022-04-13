from gui.prb_control.storages.local_storage import SessionStorage
from constants import ARENA_BONUS_TYPE

class RTSBattlesStorage(SessionStorage):

    def __init__(self):
        super(RTSBattlesStorage, self).__init__()
        self.errors = {}

    def clear(self):
        super(RTSBattlesStorage, self).clear()
        self.errors.clear()

    def _determineSelection(self, arenaVisitor):
        return arenaVisitor.getArenaBonusType() == ARENA_BONUS_TYPE.RTS