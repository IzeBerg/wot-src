from white_tiger_common.wt_constants import QUEUE_TYPE
from gui.hangar_presets.hangar_presets_getters import DefaultPresetsGetter

class WhiteTigerPresetsGetter(DefaultPresetsGetter):
    __slots__ = ()
    _QUEUE_TYPE = QUEUE_TYPE.WHITE_TIGER