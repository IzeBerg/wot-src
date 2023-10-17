from frameworks.wulf import ViewFlags
from gui.impl.gen import R
from gui.impl.lobby.tank_setup.ammunition_setup.base_hangar import BaseHangarAmmunitionSetupView
from gui.impl.lobby.tank_setup.main_tank_setup.hangar import HangarMainTankSetupView
from gui.impl.lobby.tank_setup.tank_setup_builder import HangarTankSetupBuilder
from halloween.gui.impl.lobby.tooltips.ability_tooltip import AbilityTooltipView
from halloween.gui.sounds import playSound
from halloween.gui.sounds.sound_constants import CONSUMABLES_VIEW_EXIT, CONSUMABLES_VIEW_ENTER
from halloween.gui.impl.lobby.tank_setup.sub_view import HalloweenSetupSubView
from halloween.gui.impl.lobby.tank_setup.interactor import HalloweenInteractor
from halloween.gui.impl.lobby.hw_ammunition_panel_view import HWAmmunitionPanel

class HWHangarAmmunitionSetupView(BaseHangarAmmunitionSetupView):
    _VIEW_FLAG = ViewFlags.LOBBY_TOP_SUB_VIEW

    def createToolTipContent(self, event, contentID):
        if contentID == R.views.halloween.lobby.tooltips.AbilityTooltip():
            abilityName = event.getArgument('abilityName')
            return AbilityTooltipView(abilityName=abilityName)
        return super(HWHangarAmmunitionSetupView, self).createToolTipContent(event, contentID)

    def _initialize(self, *args, **kwargs):
        self._ammunitionPanel.initialize()
        self._tankSetup.initialize()
        self._addListeners()
        playSound(CONSUMABLES_VIEW_ENTER)

    def _createMainTankSetup(self):
        return HangarMainTankSetupView(self.viewModel.tankSetup, self.__getTankSetupBuilder()(self._vehItem))

    def _createAmmunitionPanel(self):
        ctx = {'specializationClickable': True}
        return HWAmmunitionPanel(self.viewModel.ammunitionPanel, self._vehItem.getItem(), ctx=ctx)

    def _closeWindow(self):
        self._isClosed = True
        self.viewModel.setShow(False)
        playSound(CONSUMABLES_VIEW_EXIT)
        self.destroyWindow()

    def __getTankSetupBuilder(self):
        return HWTankSetupBuilder


class HWTankSetupBuilder(HangarTankSetupBuilder):
    __slots__ = ()

    def configureComponents(self, viewModel):
        components = []
        self.addComponent(components, viewModel.consumablesSetup, HalloweenSetupSubView, HalloweenInteractor(self._vehItem))
        return components