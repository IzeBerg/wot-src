from battle_modifiers.gui.impl.lobby.tooltips.modifiers_domain_tooltip_view import ModifiersDomainTooltipView
from comp7.gui.feature.comp7_modifiers_data_provider import Comp7ModifiersDataProvider
from helpers import dependency
from skeletons.gui.game_control import IComp7Controller

class Comp7ModifiersDomainTooltipView(ModifiersDomainTooltipView):
    __comp7Controller = dependency.descriptor(IComp7Controller)

    def getModifiersDataProvider(self):
        return Comp7ModifiersDataProvider(self.__comp7Controller.battleModifiers)