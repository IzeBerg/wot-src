from frameworks.wulf import ViewSettings, ViewFlags
from gui.impl.gen import R
from gui.impl.pub import ViewImpl
from halloween.gui.impl.gen.view_models.views.lobby.widgets.keys_view_model import KeysViewModel
from halloween.gui.impl.lobby.tooltips.key_tooltip import KeyTooltipView
from halloween.gui.shared.event_dispatcher import showHalloweenShopKey
from halloween.skeletons.halloween_artefacts_controller import IHalloweenArtefactsController
from halloween.skeletons.halloween_controller import IHalloweenController
from helpers import dependency

class KeysView(ViewImpl):
    _hwArtifactsCtrl = dependency.descriptor(IHalloweenArtefactsController)
    _hwController = dependency.descriptor(IHalloweenController)

    def __init__(self, layoutID=R.views.halloween.lobby.widgets.KeysView()):
        settings = ViewSettings(layoutID)
        settings.flags = ViewFlags.LOBBY_SUB_VIEW
        settings.model = KeysViewModel()
        super(KeysView, self).__init__(settings)

    @property
    def viewModel(self):
        return super(KeysView, self).getViewModel()

    def createToolTipContent(self, event, contentID):
        if contentID == R.views.halloween.lobby.tooltips.KeyTooltip():
            return KeyTooltipView(isPostBattle=False)
        return super(KeysView, self).createToolTipContent(event, contentID)

    def _onLoading(self, *args, **kwargs):
        super(KeysView, self)._onLoading()
        self.__fillViewModel()

    def _getEvents(self):
        return [
         (
          self.viewModel.onClick, self.__onClick),
         (
          self._hwArtifactsCtrl.onArtefactKeyUpdated, self.__onArtefactKeyUpdated),
         (
          self._hwController.onSettingsUpdate, self.__onSettingsUpdate)]

    def __onSettingsUpdate(self):
        self.__fillViewModel()

    def __onArtefactKeyUpdated(self):
        self.__fillViewModel()

    def __fillViewModel(self):
        self.viewModel.setKeys(self._hwArtifactsCtrl.getArtefactKeyQuantity())

    def __onClick(self):
        showHalloweenShopKey()