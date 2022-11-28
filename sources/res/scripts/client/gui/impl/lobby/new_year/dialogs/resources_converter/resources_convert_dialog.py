from frameworks.wulf import ViewSettings
from gui.game_control.wallet import WalletController
from gui.impl.gen import R
from gui.impl.gen.view_models.views.lobby.new_year.components.ny_resource_model import NyResourceModel
from gui.impl.gen.view_models.views.lobby.new_year.dialogs.resources_converter.resources_convert_dialog_model import ResourcesConvertDialogModel
from gui.impl.lobby.dialogs.full_screen_dialog_view import FullScreenDialogBaseView
from helpers import dependency
from new_year.ny_constants import RESOURCES_ORDER
from skeletons.gui.game_control import IWalletController
from skeletons.new_year import INewYearController
from gui.impl.pub.dialog_window import DialogButtons

class ResourcesConvertDialogView(FullScreenDialogBaseView):
    __nyController = dependency.descriptor(INewYearController)
    __wallet = dependency.descriptor(IWalletController)
    __slots__ = ()

    def __init__(self, *args, **kwargs):
        settings = ViewSettings(R.views.lobby.new_year.dialogs.converter.ResourcesConvertDialog())
        settings.args = args
        settings.kwargs = kwargs
        settings.model = ResourcesConvertDialogModel()
        super(ResourcesConvertDialogView, self).__init__(settings)

    @property
    def viewModel(self):
        return super(ResourcesConvertDialogView, self).getViewModel()

    def _onLoading(self, fromResourceType, fromValue, toResourceType, toValue, *args, **kwargs):
        super(ResourcesConvertDialogView, self)._onLoaded(args, kwargs)
        self.viewModel.onAccept += self._onAccept
        self.viewModel.onCancel += self._onCancel
        self.__nyController.currencies.onBalanceUpdated += self.__onBalanceUpdated
        self.__updateBalance()
        with self.viewModel.transaction() as (model):
            model.resourceFrom.setType(fromResourceType)
            model.resourceFrom.setValue(fromValue)
            model.resourceTo.setType(toResourceType)
            model.resourceTo.setValue(toValue)
            currencyStatus = self.__wallet.dynamicComponentsStatuses.get(fromResourceType)
            model.setIsWalletAvailable(currencyStatus == WalletController.STATUS.AVAILABLE)

    def _finalize(self):
        self.viewModel.onAccept -= self._onAccept
        self.viewModel.onCancel -= self._onCancel
        self.__nyController.currencies.onBalanceUpdated -= self.__onBalanceUpdated
        super(ResourcesConvertDialogView, self)._finalize()

    def _onAccept(self):
        self._setResult(DialogButtons.SUBMIT)

    def _onCancel(self):
        self._setResult(DialogButtons.CANCEL)

    def __onBalanceUpdated(self):
        self.__updateBalance()

    def __updateBalance(self):
        with self.viewModel.transaction() as (model):
            resources = model.getResources()
            resources.clear()
            for resource in RESOURCES_ORDER:
                amount = self.__nyController.currencies.getResouceBalance(resource.value)
                resourceModel = NyResourceModel()
                resourceModel.setType(resource.value)
                resourceModel.setValue(amount)
                resources.addViewModel(resourceModel)

            resources.invalidate()