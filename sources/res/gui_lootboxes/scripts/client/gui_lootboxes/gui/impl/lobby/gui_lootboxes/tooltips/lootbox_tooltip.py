from frameworks.wulf import ViewSettings
from gui.impl.gen import R
from gui.impl.pub import ViewImpl
from gui_lootboxes.gui.impl.gen.view_models.views.lobby.gui_lootboxes.tooltips.lootbox_tooltip_model import LootboxTooltipModel

class LootboxTooltip(ViewImpl):
    __slots__ = ('__lootBox', )

    def __init__(self, lootBox):
        settings = ViewSettings(R.views.gui_lootboxes.lobby.gui_lootboxes.tooltips.LootboxTooltip())
        settings.model = LootboxTooltipModel()
        super(LootboxTooltip, self).__init__(settings)
        self.__lootBox = lootBox

    @property
    def viewModel(self):
        return super(LootboxTooltip, self).getViewModel()

    def _onLoading(self, *args, **kwargs):
        super(LootboxTooltip, self)._onLoading()
        with self.viewModel.transaction() as (vm):
            vm.setUserNameKey(self.__lootBox.getUserNameKey())
            vm.setDescriptionKey(self.__lootBox.getDesrciption())
            vm.setTier(self.__lootBox.getTier())
            vm.setCount(self.__lootBox.getInventoryCount())