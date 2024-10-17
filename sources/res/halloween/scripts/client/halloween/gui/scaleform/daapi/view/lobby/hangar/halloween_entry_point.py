from frameworks.wulf import ViewFlags
from halloween.gui.impl.lobby.feature.halloween_entry_point_view import HalloweenEntryPointView
from halloween.gui.scaleform.daapi.view.meta.HalloweenEntryPointMeta import HalloweenEntryPointMeta

class HalloweenEntryPoint(HalloweenEntryPointMeta):

    def _makeInjectView(self):
        return HalloweenEntryPointView(ViewFlags.VIEW)