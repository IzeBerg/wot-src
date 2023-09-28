from frameworks.wulf import ViewFlags
from gui.Scaleform.daapi.view.meta.RankedBattlesEntryPointMeta import RankedBattlesEntryPointMeta
from gui.impl.lobby.ranked.ranked_entry_point import RankedEntryPoint

class RankedBattlesEntryPoint(RankedBattlesEntryPointMeta):

    def _makeInjectView(self):
        self.__view = RankedEntryPoint(flags=ViewFlags.VIEW)
        return self.__view