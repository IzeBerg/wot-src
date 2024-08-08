from frameworks.wulf import ViewSettings, ViewModel
from gui.impl.gen import R
from gui.impl.pub import ViewImpl

class QuickTrainingLostXpTooltip(ViewImpl):

    def __init__(self):
        settings = ViewSettings(R.views.lobby.crew.tooltips.QuickTrainingLostXpTooltip(), model=ViewModel())
        super(QuickTrainingLostXpTooltip, self).__init__(settings)

    @property
    def viewModel(self):
        return super(QuickTrainingLostXpTooltip, self).getViewModel()