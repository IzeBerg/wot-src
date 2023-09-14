from fun_random.gui.feature.util.fun_mixins import FunAssetPacksMixin
from gui.battle_results.components.common import RegularArenaFullNameItem, makeArenaFullName

class FunRandomArenaFullNameItem(RegularArenaFullNameItem, FunAssetPacksMixin):
    __slots__ = ()

    def _convert(self, record, reusable):
        arenaType = reusable.common.arenaType
        return makeArenaFullName(arenaType.getName(), self.getModeUserName())