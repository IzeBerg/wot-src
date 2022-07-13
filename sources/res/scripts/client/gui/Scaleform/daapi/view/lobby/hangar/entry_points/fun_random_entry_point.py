from frameworks.wulf import ViewFlags
from gui.Scaleform.daapi.view.meta.FunRandomEntryPointMeta import FunRandomEntryPointMeta
from gui.impl.lobby.fun_random.fun_random_entry_point_view import FunRandomEntryPointView

class FunRandomEntryPoint(FunRandomEntryPointMeta):

    def _makeInjectView(self):
        return FunRandomEntryPointView(ViewFlags.COMPONENT)