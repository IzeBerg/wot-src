from BWUtil import AsyncReturn
from async import async
from gui.impl.lobby.tank_setup.intro_ammunition_setup_view import showIntro
from gui.impl.lobby.tank_setup.main_tank_setup.base import MainTankSetupView

class HangarMainTankSetupView(MainTankSetupView):
    __slots__ = ()

    @async
    def _doSwitch(self, setupName, slotID):
        yield showIntro(setupName)
        if self._viewModel is not None:
            yield super(HangarMainTankSetupView, self)._doSwitch(setupName, slotID)
        raise AsyncReturn(None)
        return