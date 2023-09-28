from gui.prb_control.storages.local_storage import SessionStorage
from halloween_common.halloween_constants import ARENA_GUI_TYPE

class HalloweenStorage(SessionStorage):
    _GUI_TYPE = ARENA_GUI_TYPE.HALLOWEEN_BATTLES