from frameworks.wulf import ViewFlags
from gui.impl.backport import TooltipData
from gui.impl.gen import R
from gui.impl.lobby.tank_setup.ammunition_setup.base_hangar import BaseHangarAmmunitionSetupView
from gui.impl.lobby.tank_setup.main_tank_setup.hangar import HangarMainTankSetupView
from gui.impl.lobby.tank_setup.tank_setup_builder import HangarTankSetupBuilder
from halloween.gui.impl.lobby.tooltips.ability_tooltip import AbilityTooltipView
from halloween.gui.sounds import playSound
from halloween.gui.sounds.sound_constants import CONSUMABLES_VIEW_EXIT, CONSUMABLES_VIEW_ENTER
from halloween.gui.impl.lobby.tank_setup.sub_view import HalloweenSetupSubView
from halloween.gui.impl.lobby.tank_setup.interactor import HalloweenInteractor, HalloweenDefInteractor
from halloween.gui.impl.lobby.hw_ammunition_panel_view import HWAmmunitionPanel
from halloween.gui.halloween_gui_constants import HALLOWEEN_ABILITY_TOOLTIP, HALLOWEEN_MAIN_SHELL
from gui.Scaleform.genConsts.TOOLTIPS_CONSTANTS import TOOLTIPS_CONSTANTS
from gui.impl.lobby.tank_setup.interactors.battle_booster import BattleBoosterInteractor
from gui.impl.lobby.tank_setup.interactors.opt_device import OptDeviceInteractor
from gui.impl.lobby.tank_setup.interactors.shell import ShellInteractor
from gui.impl.lobby.tank_setup.sub_views.battle_booster_setup import BattleBoosterSetupSubView
from gui.impl.lobby.tank_setup.sub_views.opt_device_setup import OptDeviceSetupSubView
from gui.impl.lobby.tank_setup.sub_views.shell_setup import ShellSetupSubView
from halloween.gui.shared import isHalloweenDefenceSelected
from halloween.gui.impl.gen.view_models.views.lobby.hw_ammunition_setup_view_model import HwAmmunitionSetupViewModel

class HWHangarAmmunitionSetupView(BaseHangarAmmunitionSetupView):
    _VIEW_FLAG = ViewFlags.LOBBY_TOP_SUB_VIEW
    _VIEW_MODEL = HwAmmunitionSetupViewModel

    def createToolTipContent(self, event, contentID):
        if contentID == R.views.halloween.lobby.tooltips.AbilityTooltip():
            abilityName = event.getArgument('abilityName')
            return AbilityTooltipView(abilityName=abilityName)
        return super(HWHangarAmmunitionSetupView, self).createToolTipContent(event, contentID)

    def _createBlur(self):
        return

    def _onLoading(self, **kwargs):
        super(HWHangarAmmunitionSetupView, self)._onLoading(**kwargs)
        self.viewModel.setIsDefenseMode(isHalloweenDefenceSelected())

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

    def _getBackportTooltipData(self, event):
        data = super(HWHangarAmmunitionSetupView, self)._getBackportTooltipData(event)
        if data.specialAlias in (TOOLTIPS_CONSTANTS.HANGAR_MODULE, TOOLTIPS_CONSTANTS.HANGAR_CARD_MODULE):
            return TooltipData(data.tooltip, data.isSpecial, HALLOWEEN_ABILITY_TOOLTIP, data.specialArgs, data.isWulfTooltip)
        if data.specialAlias == TOOLTIPS_CONSTANTS.TECH_MAIN_SHELL:
            return TooltipData(data.tooltip, data.isSpecial, HALLOWEEN_MAIN_SHELL, data.specialArgs, data.isWulfTooltip)
        return data

    def __getTankSetupBuilder(self):
        if isHalloweenDefenceSelected():
            return HWDefTankSetupBuilder
        return HWTankSetupBuilder


class HWTankSetupBuilder(HangarTankSetupBuilder):
    __slots__ = ()

    def configureComponents(self, viewModel):
        components = []
        self.addComponent(components, viewModel.consumablesSetup, HalloweenSetupSubView, HalloweenInteractor(self._vehItem))
        return components


class HWDefTankSetupBuilder(HangarTankSetupBuilder):
    __slots__ = ()

    def configureComponents(self, viewModel):
        components = []
        self.addComponent(components, viewModel.shellsSetup, ShellSetupSubView, ShellInteractor(self._vehItem))
        self.addComponent(components, viewModel.consumablesSetup, HalloweenSetupSubView, HalloweenDefInteractor(self._vehItem))
        self.addComponent(components, viewModel.optDevicesSetup, OptDeviceSetupSubView, OptDeviceInteractor(self._vehItem))
        self.addComponent(components, viewModel.battleBoostersSetup, BattleBoosterSetupSubView, BattleBoosterInteractor(self._vehItem))
        return components