from gui.impl.gen import R
from gui.impl.common.tabs_controller import tabUpdateFunc
from gui.impl.common.ammunition_panel.ammunition_groups_controller import AmmunitionGroupsController, GroupData
from gui.impl.common.ammunition_panel.base import BaseAmmunitionPanel
from gui.impl.common.ammunition_panel.ammunition_blocks_controller import BaseAmmunitionBlocksController
from gui.impl.common.ammunition_panel.ammunition_panel_blocks import ConsumablesBlock, ShellsBlock
from gui.impl.gen.view_models.views.lobby.tank_setup.common.ammunition_panel_constants import AmmunitionPanelConstants
from gui.impl.gen.view_models.views.lobby.tank_setup.tank_setup_constants import TankSetupConstants
from gui.impl.gen.view_models.views.lobby.tank_setup.common.ammunition_items_section import AmmunitionItemsSection
from gui.impl.lobby.tank_setup.ammunition_panel.base_view import BaseAmmunitionPanelView
from halloween.gui.impl.lobby.tooltips.ability_tooltip import AbilityTooltipView
from halloween.gui.impl.lobby.tank_setup import HWTankSetupConstants
HW_GROUPS = (
 GroupData(AmmunitionPanelConstants.EQUIPMENT_AND_SHELLS, (
  HWTankSetupConstants.HW_CONSUMABLES, TankSetupConstants.SHELLS)),
 GroupData(AmmunitionPanelConstants.OPTIONAL_DEVICES_AND_BOOSTERS, ()))

class HWAmmunitionPanelView(BaseAmmunitionPanelView):

    def createToolTipContent(self, event, contentID):
        if contentID == R.views.halloween.lobby.tooltips.AbilityTooltip():
            abilityName = event.getArgument('abilityName')
            return AbilityTooltipView(abilityName=abilityName)
        return super(HWAmmunitionPanelView, self).createToolTipContent(event, contentID)

    def _createAmmunitionPanel(self):
        return HWAmmunitionPanel(self.viewModel.ammunitionPanel, self.vehItem)


class HWAmmunitionPanel(BaseAmmunitionPanel):

    def _createAmmunitionGroupsController(self, vehicle):
        return HWHangarAmmunitionGroupsController(vehicle, ctx=self._ctx)


class HWConsumablesBlock(ConsumablesBlock):

    def _getSectionName(self):
        return HWTankSetupConstants.HW_CONSUMABLES

    def _getKeySettings(self):
        return ('CMD_AMMO_CHOICE_1', 'CMD_AMMO_CHOICE_2', 'CMD_AMMO_CHOICE_3')


class HWAmmunitionBlocksController(BaseAmmunitionBlocksController):

    @tabUpdateFunc(TankSetupConstants.SHELLS)
    def _updateShells(self, viewModel, isFirst=False):
        ShellsBlock(self._vehicle, self._currentSection).adapt(viewModel, isFirst)

    @tabUpdateFunc(HWTankSetupConstants.HW_CONSUMABLES)
    def _updateHWConsumables(self, viewModel, isFirst=False):
        HWConsumablesBlock(self._vehicle, self._currentSection).adapt(viewModel, isFirst)

    def _createViewModel(self, name):
        return AmmunitionItemsSection()


class HWHangarAmmunitionGroupsController(AmmunitionGroupsController):

    def _getGroups(self):
        if self._vehicle is None:
            return []
        else:
            return HW_GROUPS

    def _createAmmunitionBlockController(self, vehicle, ctx=None):
        return HWAmmunitionBlocksController(vehicle, ctx=ctx)