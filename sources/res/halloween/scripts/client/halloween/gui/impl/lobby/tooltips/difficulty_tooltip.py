from frameworks.wulf import ViewSettings
from gui.impl.gen import R
from gui.impl.pub import ViewImpl
from halloween.gui.impl.gen.view_models.views.lobby.widgets.difficulty_item_model import DifficultyItemModel

class DifficultyTooltipView(ViewImpl):
    __slots__ = ('__level', '__state')

    def __init__(self, level, state, layoutID=R.views.halloween.lobby.tooltips.DifficultyTooltip()):
        settings = ViewSettings(layoutID)
        settings.model = DifficultyItemModel()
        super(DifficultyTooltipView, self).__init__(settings)
        self.__level = level
        self.__state = state

    @property
    def viewModel(self):
        return super(DifficultyTooltipView, self).getViewModel()

    def _onLoading(self, *args, **kwargs):
        super(DifficultyTooltipView, self)._onLoading()
        with self.viewModel.transaction() as (model):
            model.setLevel(self.__level)
            model.setState(self.__state)