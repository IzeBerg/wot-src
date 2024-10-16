from gui.impl.gen import R
from gui.impl.common.tabs_controller import tabUpdateFunc
from gui.impl.common.ammunition_panel.ammunition_groups_controller import AmmunitionGroupsController, GroupData
from gui.impl.common.ammunition_panel.base import BaseAmmunitionPanel
from gui.impl.common.ammunition_panel.ammunition_blocks_controller import BaseAmmunitionBlocksController
from gui.impl.common.ammunition_panel.ammunition_panel_blocks import ConsumablesBlock, ShellsBlock, OptDeviceBlock, BattleBoostersBlock
from gui.impl.gen.view_models.views.lobby.tank_setup.common.ammunition_panel_constants import AmmunitionPanelConstants
from gui.impl.gen.view_models.views.lobby.tank_setup.tank_setup_constants import TankSetupConstants
from gui.impl.gen.view_models.views.lobby.tank_setup.common.ammunition_items_section import AmmunitionItemsSection
from gui.impl.lobby.tank_setup.ammunition_panel.base_view import BaseAmmunitionPanelView
from halloween.gui.impl.lobby.tooltips.ability_tooltip import AbilityTooltipView
from halloween.gui.impl.lobby.tank_setup import HWTankSetupConstants
from halloween.gui.halloween_gui_constants import HALLOWEEN_ABILITY_TOOLTIP, HALLOWEEN_MAIN_SHELL
from gui.Scaleform.genConsts.TOOLTIPS_CONSTANTS import TOOLTIPS_CONSTANTS
from gui.impl.backport import TooltipData
from halloween.gui.shared import isHalloweenDefenceSelected
from HWAccountEquipmentController import getHWConsumables
from halloween.gui.impl.gen.view_models.views.lobby.hw_ammunition_panel_view_model import HwAmmunitionPanelViewModel
HW_GROUPS = (
 GroupData(AmmunitionPanelConstants.EQUIPMENT_AND_SHELLS, (
  HWTankSetupConstants.HW_CONSUMABLES, TankSetupConstants.SHELLS)),
 GroupData(AmmunitionPanelConstants.OPTIONAL_DEVICES_AND_BOOSTERS, ()))
HW_DEF_GROUPS = (
 GroupData(AmmunitionPanelConstants.EQUIPMENT_AND_SHELLS, (
  HWTankSetupConstants.HW_CONSUMABLES, TankSetupConstants.OPT_DEVICES,
  TankSetupConstants.BATTLE_BOOSTERS, TankSetupConstants.SHELLS)),
 GroupData(AmmunitionPanelConstants.OPTIONAL_DEVICES_AND_BOOSTERS, ()))
_TOOLTIPS_OVERRIDES = {TOOLTIPS_CONSTANTS.HANGAR_MODULE: HALLOWEEN_ABILITY_TOOLTIP, 
   TOOLTIPS_CONSTANTS.TECH_MAIN_SHELL: HALLOWEEN_MAIN_SHELL}

class HWAmmunitionPanelView(BaseAmmunitionPanelView):
    _VIEW_MODEL = HwAmmunitionPanelViewModel

    def createToolTipContent(self, event, contentID):
        if contentID == R.views.halloween.lobby.tooltips.AbilityTooltip():
            abilityName = event.getArgument('abilityName')
            return AbilityTooltipView(abilityName=abilityName)
        return super(HWAmmunitionPanelView, self).createToolTipContent(event, contentID)

    def _onLoaded(self, *args, **kwargs):
        super(HWAmmunitionPanelView, self)._onLoaded(*args, **kwargs)
        self.viewModel.setIsDefenseMode(isHalloweenDefenceSelected())

    def _createAmmunitionPanel(self):
        return HWAmmunitionPanel(self.viewModel.ammunitionPanel, self.vehItem)

    def _getBackportTooltipData(self, event):
        data = super(HWAmmunitionPanelView, self)._getBackportTooltipData(event)
        override = _TOOLTIPS_OVERRIDES.get(data.specialAlias, data.specialAlias)
        return TooltipData(data.tooltip, data.isSpecial, override, data.specialArgs, data.isWulfTooltip)

    def _currentVehicleChanged(self):
        super(HWAmmunitionPanelView, self)._currentVehicleChanged()
        self.viewModel.setIsDefenseMode(isHalloweenDefenceSelected())


class HWAmmunitionPanel(BaseAmmunitionPanel):

    def _createAmmunitionGroupsController(self, vehicle):
        return HWHangarAmmunitionGroupsController(vehicle, ctx=self._ctx)


class HWConsumablesBlock(ConsumablesBlock):

    def _getSectionName(self):
        return HWTankSetupConstants.HW_CONSUMABLES

    def _getKeySettings(self):
        return ('CMD_AMMO_CHOICE_1', 'CMD_AMMO_CHOICE_2', 'CMD_AMMO_CHOICE_3')


class HWDefConsumablesBlock(HWConsumablesBlock):

    def _getKeySettings(self):
        return ('CMD_AMMO_CHOICE_1', 'CMD_AMMO_CHOICE_2', 'CMD_AMMO_CHOICE_3')

    def _getInstalled(self):
        return getHWConsumables(self._vehicle).installed

    def _getLayout(self):
        return getHWConsumables(self._vehicle).layout


class HWShellsBlock(ShellsBlock):

    def _updateSlotWithItem(self, model, idx, slotItem):
        super(HWShellsBlock, self)._updateSlotWithItem(model, idx, slotItem)
        model.setIsInfinity(not slotItem.descriptor.isForceFinite)


class HWAmmunitionBlocksController(BaseAmmunitionBlocksController):

    @tabUpdateFunc(TankSetupConstants.SHELLS)
    def _updateShells(self, viewModel, isFirst=False):
        HWShellsBlock(self._vehicle, self._currentSection).adapt(viewModel, isFirst)

    @tabUpdateFunc(HWTankSetupConstants.HW_CONSUMABLES)
    def _updateHWConsumables(self, viewModel, isFirst=False):
        if isHalloweenDefenceSelected():
            HWDefConsumablesBlock(self._vehicle, self._currentSection).adapt(viewModel, isFirst)
            return
        HWConsumablesBlock(self._vehicle, self._currentSection).adapt(viewModel, isFirst)

    @tabUpdateFunc(TankSetupConstants.OPT_DEVICES)
    def _updateOptDevices(self, viewModel, isFirst=False):
        OptDeviceBlock(self._vehicle, self._currentSection, ctx=self._ctx).adapt(viewModel, isFirst)

    @tabUpdateFunc(TankSetupConstants.BATTLE_BOOSTERS)
    def _updateBattleBoosters(self, viewModel, isFirst=False):
        BattleBoostersBlock(self._vehicle, self._currentSection).adapt(viewModel, isFirst)

    def _createViewModel(self, name):
        return AmmunitionItemsSection()


class HWHangarAmmunitionGroupsController(AmmunitionGroupsController):

    def _getGroups(self):
        if self._vehicle is None:
            return []
        else:
            if isHalloweenDefenceSelected():
                return HW_DEF_GROUPS
            return HW_GROUPS

    def _createAmmunitionBlockController(self, vehicle, ctx=None):
        return HWAmmunitionBlocksController(vehicle, ctx=ctx)