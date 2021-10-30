from frameworks.wulf import ViewFlags, ViewSettings
from CurrentVehicle import g_currentVehicle
from gui.impl.backport.backport_tooltip import createTooltipData, BackportTooltipWindow
from gui.impl.gen import R
from gui.impl.gen.view_models.views.battle_royale.commander_cmp_perk_model import CommanderCmpPerkModel
from gui.impl.gen.view_models.views.battle_royale.commander_cmp_view_model import CommanderCmpViewModel
from gui.impl.gen.view_models.views.battle_royale.commander_cmp_tooltips import CommanderCmpTooltips
from gui.impl.pub import ViewImpl
from gui.Scaleform.daapi.view.common.battle_royale.br_helpers import isIncorrectVehicle
from gui.Scaleform.framework.entities.inject_component_adaptor import InjectComponentAdaptor
from gui.Scaleform.genConsts.TOOLTIPS_CONSTANTS import TOOLTIPS_CONSTANTS
from helpers import dependency
from skeletons.gui.game_control import IBattleRoyaleController
_R_SKILLS_ICONS = R.images.gui.maps.icons.tankmen.skills.big

class CommanderComponent(InjectComponentAdaptor):

    def _makeInjectView(self):
        return CommanderView(R.views.lobby.battleRoyale.commander_cmp.CommanderCmp())


class CommanderView(ViewImpl):
    _RU_REALM_TAG = 'cis'
    __brControl = dependency.descriptor(IBattleRoyaleController)

    def __init__(self, viewKey, viewModelClazz=CommanderCmpViewModel):
        settings = ViewSettings(viewKey)
        settings.flags = ViewFlags.COMPONENT
        settings.model = viewModelClazz()
        super(CommanderView, self).__init__(settings)

    @property
    def viewModel(self):
        return super(CommanderView, self).getViewModel()

    def createToolTip(self, event):
        if event.contentID == R.views.common.tooltip_window.backport_tooltip_content.BackportTooltipContent():
            tooltipData = self.__getTooltipData(event)
            window = BackportTooltipWindow(tooltipData, self.getParentWindow()) if tooltipData is not None else None
            if window is not None:
                window.load()
            return window
        return super(CommanderView, self).createToolTip(event)

    def _initialize(self):
        super(CommanderView, self)._initialize()
        self.__addListeners()
        self.__updateModel()

    def _finalize(self):
        self.__removeListeners()
        super(CommanderView, self)._finalize()

    def __addListeners(self):
        g_currentVehicle.onChanged += self.__onCurrentVehicleChanged

    def __removeListeners(self):
        g_currentVehicle.onChanged -= self.__onCurrentVehicleChanged

    def __onCurrentVehicleChanged(self):
        self.__updateModel()

    def __updateModel(self):
        vehicle = g_currentVehicle.item
        if isIncorrectVehicle(vehicle):
            return
        with self.viewModel.transaction() as (model):
            model.setNation(vehicle.nationName)
            perkList = model.getPerkList()
            perkList.clear()
            commanderSkills = self.__brControl.getBrCommanderSkills()
            for skill in commanderSkills:
                skillName = skill.name
                perkModel = CommanderCmpPerkModel()
                perkModel.setIcon(_R_SKILLS_ICONS.dyn(skillName)())
                perkModel.setTooltipID(skillName)
                perkList.addViewModel(perkModel)
                perkList.invalidate()

    def __getTooltipData(self, event):
        tooltipId = event.getArgument('tooltipId')
        if tooltipId is None:
            return
        else:
            commanderID = self.__getCommanderID()
            if commanderID is None:
                return
            if tooltipId == CommanderCmpTooltips.TOOLTIP_TANKMAN:
                return createTooltipData(isSpecial=True, specialAlias=TOOLTIPS_CONSTANTS.BATTLE_ROYALE_TANKMAN, specialArgs=(
                 commanderID, False))
            return createTooltipData(isSpecial=True, specialAlias=TOOLTIPS_CONSTANTS.TANKMAN_SKILL, specialArgs=(
             tooltipId, commanderID))

    @staticmethod
    def __getCommanderID():
        vehicle = g_currentVehicle.item
        if vehicle is None:
            return
        else:
            crew = vehicle.crew
            if crew is None:
                return
            return crew[0][1].invID