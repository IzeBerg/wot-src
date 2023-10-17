from frameworks.wulf import ViewSettings
from gui.impl.gen import R
from gui.impl.pub import ViewImpl
from halloween.gui.impl.gen.view_models.views.lobby.tooltips.not_enough_key_tooltip_view_model import NotEnoughKeyTooltipViewModel
from halloween.skeletons.halloween_artefacts_controller import IHalloweenArtefactsController
from helpers import dependency

class NotEnoughKeyTooltipView(ViewImpl):
    __slots__ = ('__price', )
    _hwArtifactsCtrl = dependency.descriptor(IHalloweenArtefactsController)

    def __init__(self, price, layoutID=R.views.halloween.lobby.tooltips.NotEnoughKeyTooltip()):
        settings = ViewSettings(layoutID)
        settings.model = NotEnoughKeyTooltipViewModel()
        super(NotEnoughKeyTooltipView, self).__init__(settings)
        self.__price = price

    @property
    def viewModel(self):
        return super(NotEnoughKeyTooltipView, self).getViewModel()

    def _onLoading(self):
        keyCount = self._hwArtifactsCtrl.getArtefactKeyQuantity()
        self.viewModel.setKeyCount(self.__price - keyCount)