from battle_royale.gui.impl.lobby.views.battle_royale_entry_point import BattleRoyaleEntryPoint
from frameworks.wulf import ViewFlags
from gui.Scaleform.daapi.view.meta.ResizableEntryPointMeta import ResizableEntryPointMeta

class BattleRoyaleEntryPointInject(ResizableEntryPointMeta):

    def isSingle(self, value):
        if self.__view:
            self.__view.setIsSingle(value)

    def _makeInjectView(self):
        self.__view = BattleRoyaleEntryPoint(flags=ViewFlags.VIEW)
        return self.__view