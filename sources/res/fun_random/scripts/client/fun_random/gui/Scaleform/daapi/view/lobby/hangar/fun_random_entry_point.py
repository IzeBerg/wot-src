from frameworks.wulf import ViewFlags
from fun_random.gui.impl.lobby.feature.fun_random_entry_point_view import FunRandomEntryPointView
from gui.Scaleform.daapi.view.meta.FunRandomEntryPointMeta import FunRandomEntryPointMeta

class FunRandomEntryPoint(FunRandomEntryPointMeta):

    def _makeInjectView(self):
        return FunRandomEntryPointView(ViewFlags.COMPONENT)