from frameworks.wulf import ViewSettings
from gui.impl.gen import R
from gui.impl.gen.view_models.views.lobby.new_year.tooltips.ny_resource_tooltip_model import NyResourceTooltipModel
from gui.impl.pub import ViewImpl
from helpers import dependency
from new_year.ny_resource_collecting_helper import getResourceCollectingByIndex
from skeletons.new_year import INewYearController

class NyResourceTooltip(ViewImpl):
    __slots__ = ()

    def __init__(self, *args, **kwargs):
        settings = ViewSettings(R.views.lobby.new_year.tooltips.NyResourceTooltip())
        settings.model = NyResourceTooltipModel()
        settings.args = args
        settings.kwargs = kwargs
        super(NyResourceTooltip, self).__init__(settings)

    @property
    def viewModel(self):
        return super(NyResourceTooltip, self).getViewModel()

    def _onLoading(self, resourceType, *args, **kwargs):
        super(NyResourceTooltip, self)._onLoading()
        value = dependency.instance(INewYearController).currencies.getResouceBalance(resourceType)
        with self.viewModel.transaction() as (model):
            model.setFirstCollectAmount(getResourceCollectingByIndex(resourceType=resourceType, index=0))
            model.setSecondCollectAmount(getResourceCollectingByIndex(resourceType=resourceType, index=1))
            model.resource.setType(resourceType)
            model.resource.setValue(value)