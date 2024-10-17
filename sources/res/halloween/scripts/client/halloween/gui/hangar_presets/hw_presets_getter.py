from halloween_common.halloween_constants import QUEUE_TYPE, ARENA_BONUS_TYPE
from halloween.gui.scaleform.daapi.view.lobby.header.helpers.controls_helpers import HalloweenLobbyHeaderHelper
from gui.hangar_presets.hangar_presets_getters import DefaultPresetsGetter

class HalloweenPresetsGetter(DefaultPresetsGetter):
    __slots__ = ()
    _QUEUE_TYPE = QUEUE_TYPE.HALLOWEEN
    _BONUS_TYPES = (ARENA_BONUS_TYPE.HALLOWEEN,)
    _LOBBY_HEADER_HELPER = HalloweenLobbyHeaderHelper


class HalloweenMediumPresetsGetter(HalloweenPresetsGetter):
    __slots__ = ()
    _QUEUE_TYPE = QUEUE_TYPE.HALLOWEEN_MEDIUM
    _BONUS_TYPES = (ARENA_BONUS_TYPE.HALLOWEEN_MEDIUM,)


class HalloweenHardPresetsGetter(HalloweenPresetsGetter):
    __slots__ = ()
    _QUEUE_TYPE = QUEUE_TYPE.HALLOWEEN_HARD
    _BONUS_TYPES = (ARENA_BONUS_TYPE.HALLOWEEN_HARD,)


class HalloweenDefencePresetsGetter(HalloweenPresetsGetter):
    __slots__ = ()
    _QUEUE_TYPE = QUEUE_TYPE.HALLOWEEN_DEFENCE
    _BONUS_TYPES = (ARENA_BONUS_TYPE.HALLOWEEN_DEFENCE,)