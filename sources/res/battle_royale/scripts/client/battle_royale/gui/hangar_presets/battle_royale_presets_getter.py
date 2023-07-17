from constants import QUEUE_TYPE
from gui.hangar_presets.hangar_presets_getters import DefaultPresetsGetter

class BattleRoyalePresetsGetter(DefaultPresetsGetter):
    __slots__ = ()
    _QUEUE_TYPE = QUEUE_TYPE.BATTLE_ROYALE


class BattleRoyaleTournamentPresetsGetter(DefaultPresetsGetter):
    __slots__ = ()
    _QUEUE_TYPE = QUEUE_TYPE.BATTLE_ROYALE_TOURNAMENT