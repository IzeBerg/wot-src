from frameworks.wulf import ViewFlags
from gui.Scaleform.daapi.view.meta.WTEventEntryPointMeta import WTEventEntryPointMeta
from gui.impl.lobby.wt_event.wt_event_entry_point import WTEventEntryPoint

class WTEventBattlesEntryPoint(WTEventEntryPointMeta):

    def _makeInjectView(self):
        self.__view = WTEventEntryPoint(flags=ViewFlags.VIEW)
        return self.__view

    def isSingle(self, value):
        if self.__view:
            self.__view.setIsSingle(value)