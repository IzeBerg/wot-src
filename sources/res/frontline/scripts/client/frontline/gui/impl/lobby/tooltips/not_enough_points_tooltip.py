from frameworks.wulf import ViewFlags, ViewSettings
from frontline.gui.impl.gen.view_models.views.lobby.tooltips.not_enough_points_tooltip_model import NotEnoughPointsTooltipModel
from gui.impl.pub import ViewImpl
from gui.impl.gen import R

class NotEnoughPointsTooltip(ViewImpl):
    __slots__ = ('__points', )

    def __init__(self, points):
        settings = ViewSettings(R.views.frontline.lobby.tooltips.NotEnoughPointsTooltip(), ViewFlags.VIEW, NotEnoughPointsTooltipModel())
        self.__points = points
        super(NotEnoughPointsTooltip, self).__init__(settings)

    @property
    def viewModel(self):
        return super(NotEnoughPointsTooltip, self).getViewModel()

    def _onLoading(self, *args, **kwargs):
        self.viewModel.setPoints(self.__points)