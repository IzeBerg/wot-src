from gui.battle_control.arena_info.interfaces import IArenaLoadController
from gui.battle_control.battle_constants import BATTLE_CTRL_ID

class ArenaInfoController(IArenaLoadController):
    __slots__ = ()

    def getControllerID(self):
        return BATTLE_CTRL_ID.ARENA_INFO_CTRL