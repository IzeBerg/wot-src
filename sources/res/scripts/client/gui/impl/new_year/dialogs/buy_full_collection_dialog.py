from gui.impl import backport
from gui.impl.gen import R
from gui.impl.gen.view_models.ui_kit.currency_item_model import CurrencyItemModel
from gui.impl.pub.dialog_window import DialogContent, DialogButtons, DialogWindow
from gui.impl.wrappers.user_format_string_arg_model import UserFormatStringArgModel as FmtArg
from helpers import dependency
from items import new_year
from items.new_year import getCollectionByIntID
from new_year.collection_presenters import getCollectionCost
from new_year.ny_constants import SyncDataKeys
from skeletons.gui.shared import IItemsCache
from skeletons.new_year import INewYearController

class BuyFullCollectionDialogWindow(DialogWindow):
    _itemsCache = dependency.descriptor(IItemsCache)
    _nyController = dependency.descriptor(INewYearController)
    __slots__ = ('__collectionID', )

    def __init__(self, collectionID, parent=None):
        self.__collectionID = collectionID
        super(BuyFullCollectionDialogWindow, self).__init__(bottomContent=DialogContent(R.views.lobby.new_year.components.new_year_common.CollectionItemBottomContent(), viewModelClazz=CurrencyItemModel), balanceContent=DialogContent(R.views.lobby.new_year.components.new_year_common.CollectionItemBalanceContent(), viewModelClazz=CurrencyItemModel), parent=parent, enableBlur=True)

    def _initialize(self):
        super(BuyFullCollectionDialogWindow, self)._initialize()
        with self.viewModel.transaction() as (model):
            self._addButton(DialogButtons.PURCHASE, R.strings.ny.dialogs.buyCollectionItem.btnBuy(), isFocused=True)
            self._addButton(DialogButtons.CANCEL, R.strings.ny.dialogs.buyCollectionItem.btnCancel(), invalidateAll=True)
            self.__setTitle(model)
            self.__setBottomContent()
            self.__setBalanceContent()
        self._nyController.onDataUpdated += self.__onUpdated

    def _finalize(self):
        self._nyController.onDataUpdated -= self.__onUpdated
        super(BuyFullCollectionDialogWindow, self)._finalize()

    def __setBottomContent(self):
        bottomContent = self.bottomContentViewModel
        year, collectionName = new_year.getCollectionByIntID(self.__collectionID)
        price = getCollectionCost(year, collectionName)
        bottomContent.setValue(str(price))
        self.__updateIsEnough(price)

    def __setTitle(self, model):
        model.setTitle(R.strings.ny.dialogs.buyFullCollection.title())
        _, settingName = getCollectionByIntID(self.__collectionID)
        titleArgs = model.getTitleFmtArgs()
        titleArgs.addViewModel(FmtArg(backport.text(R.strings.ny.settingsWithCollection.dyn(settingName)()), 'settingName', hardSpace=True))
        titleArgs.invalidate()

    def __setBalanceContent(self):
        balanceContent = self.balanceContentViewModel
        balanceContent.setValue(str(self._itemsCache.items.festivity.getShardsCount()))

    def __updateIsEnough(self, price):
        isEnough = self._itemsCache.items.festivity.getShardsCount() >= price
        self._setButtonEnabled(DialogButtons.PURCHASE, isEnough)
        self.bottomContentViewModel.setIsEnough(isEnough)

    def __onUpdated(self, keys):
        if SyncDataKeys.TOY_FRAGMENTS in keys:
            year, collectionName = new_year.getCollectionByIntID(self.__collectionID)
            self.__updateIsEnough(getCollectionCost(year, collectionName))
            self.__setBalanceContent()