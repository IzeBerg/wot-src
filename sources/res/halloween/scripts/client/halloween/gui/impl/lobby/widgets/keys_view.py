from frameworks.wulf import ViewSettings, ViewFlags, WindowLayer, WindowStatus
from gui.impl.gen import R
from gui.impl.pub import ViewImpl
from halloween.gui.impl.gen.view_models.views.lobby.widgets.keys_view_model import KeysViewModel
from halloween.gui.impl.lobby.tooltips.key_tooltip import KeyTooltipView
from halloween.gui.shared.event_dispatcher import showBundleWindow
from halloween.skeletons.halloween_artefacts_controller import IHalloweenArtefactsController
from halloween.skeletons.halloween_controller import IHalloweenController
from helpers import dependency
from skeletons.gui.impl import IGuiLoader

class KeysView(ViewImpl):
    _guiLoader = dependency.descriptor(IGuiLoader)
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
          self._hwArtifactsCtrl.onArtefactStatusUpdated, self.__onArtefactStatusUpdated),
         (
          self._hwController.onSettingsUpdate, self.__onSettingsUpdate),
         (
          self._guiLoader.windowsManager.onWindowStatusChanged, self.__windowStatusChanged)]

    def __onSettingsUpdate(self):
        self.__fillViewModel()

    def __onArtefactKeyUpdated(self):
        self.__updateViewModel()

    def __onArtefactStatusUpdated(self, *args):
        self.__updateViewModel()

    def __hasOverlayWindow(self):
        windows = self.gui.windowsManager.findWindows(lambda w: WindowLayer.FULLSCREEN_WINDOW <= w.layer <= WindowLayer.OVERLAY)
        return len(windows) > 0

    def __fillViewModel(self):
        with self.viewModel.transaction() as (tx):
            tx.setKeys(self._hwArtifactsCtrl.getArtefactKeyQuantity())
            tx.setIsCompleted(self.__isEnoughKeys())

    def __updateViewModel(self):
        if not self.__hasOverlayWindow():
            self.viewModel.setKeys(self._hwArtifactsCtrl.getArtefactKeyQuantity())
            self.viewModel.setIsCompleted(self.__isEnoughKeys())

    def __isEnoughKeys(self):
        return self._hwArtifactsCtrl.getLackOfKeysForArtefacts() == 0

    def __onClick(self):
        showBundleWindow()

    def __windowStatusChanged(self, uniqueID, newStatus):
        if newStatus == WindowStatus.DESTROYED:
            self.__updateViewModel()