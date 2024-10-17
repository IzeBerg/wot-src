from frameworks.wulf import ViewSettings
from gui.impl.gen import R
from gui.impl.pub import ViewImpl
from halloween.gui.impl.gen.view_models.views.lobby.tooltips.ability_tooltip_view_model import AbilityTooltipViewModel

class AbilityTooltipView(ViewImpl):
    __slots__ = ('__abilityName', )

    def __init__(self, abilityName, layoutID=R.views.halloween.lobby.tooltips.AbilityTooltip()):
        settings = ViewSettings(layoutID)
        settings.model = AbilityTooltipViewModel()
        super(AbilityTooltipView, self).__init__(settings)
        self.__abilityName = abilityName

    @property
    def viewModel(self):
        return super(AbilityTooltipView, self).getViewModel()

    def _onLoading(self):
        self.viewModel.setAbilityName(self.__abilityName)