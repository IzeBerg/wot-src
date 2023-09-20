from frameworks.wulf import ViewFlags
from gui.Scaleform.daapi.view.meta.WTEventEntryPointMeta import WTEventEntryPointMeta
from gui.impl.lobby.wt_event.wt_event_entry_point import WTEventEntryPoint

class WTEventBattlesEntryPoint(WTEventEntryPointMeta):

    def _makeInjectView(self):
        return WTEventEntryPoint(flags=ViewFlags.COMPONENT)