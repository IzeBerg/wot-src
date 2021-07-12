from BWUtil import AsyncReturn
from async import async
from gui.impl.gen.view_models.views.lobby.tank_setup.tank_setup_constants import TankSetupConstants
from gui.impl.lobby.tank_setup.intro_ammunition_setup_view import showIntroAmmunitionSetupWindow, isIntroAmmunitionSetupShown
from gui.impl.lobby.tank_setup.main_tank_setup.base import MainTankSetupView

class HangarMainTankSetupView(MainTankSetupView):
    __slots__ = ()

    @async
    def _doSwitch(self, setupName, slotID):
        if setupName == TankSetupConstants.OPT_DEVICES and not isIntroAmmunitionSetupShown():
            yield showIntroAmmunitionSetupWindow()
        if self._viewModel is not None:
            yield super(HangarMainTankSetupView, self)._doSwitch(setupName, slotID)
        raise AsyncReturn(None)
        return