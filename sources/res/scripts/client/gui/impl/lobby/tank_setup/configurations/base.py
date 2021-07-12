from gui.impl.gen.view_models.views.lobby.tank_setup.common.deal_panel_model import DealPanelModel
from gui.impl.gen.view_models.views.lobby.tank_setup.common.setup_tab_model import SetupTabModel
from gui.impl.lobby.tabs_controller import TabsController
from gui.impl.wrappers.user_compound_price_model import BuyPriceModelBuilder
from gui.shared.gui_items.fitting_item import canBuyWithGoldExchange
from gui.shared.money import MONEY_UNDEFINED
from helpers import dependency
from skeletons.gui.shared import IItemsCache

class BaseTankSetupTabsController(TabsController):
    __slots__ = ('_providers', )

    def __init__(self, autoCreating=True):
        super(BaseTankSetupTabsController, self).__init__(autoCreating)
        self._providers = self._getAllProviders()

    def getProvider(self, name):
        return self._providers[name]

    def _createViewModel(self, _):
        return SetupTabModel()

    def _getAllProviders(self):
        return {}


class BaseDealPanel(object):
    _itemsCache = dependency.descriptor(IItemsCache)
    _IN_STORAGE = 'inStorage'
    _MONEY = 'money'

    @classmethod
    def updateDealPanelPrice(cls, items, dealPanelModel):
        prices = {cls._IN_STORAGE: 0, 
           cls._MONEY: MONEY_UNDEFINED}
        for item in items:
            cls.addItem(item, prices)

        dealPanelModel.setTotalItemsInStorage(prices[cls._IN_STORAGE])
        dealPanelModel.getPrice().clear()
        buyMoney = prices[cls._MONEY]
        BuyPriceModelBuilder.fillPriceModel(dealPanelModel, buyMoney)
        dealPanelModel.getPrice().invalidate()
        cls._updateDisabled(prices, dealPanelModel)

    @classmethod
    def updateAutoRenewalState(cls, interactor, dealPanelModel):
        autoRenewal = interactor.getAutoRenewal()
        if autoRenewal is not None:
            dealPanelModel.setIsAutoRenewalEnabled(autoRenewal.getLocalValue())
        return

    @classmethod
    def addItem(cls, item, prices):
        if item is None:
            return
        else:
            if item.isInInventory:
                prices[cls._IN_STORAGE] += 1
                return
            prices[cls._MONEY] += item.getBuyPrice().price
            return

    @classmethod
    def removeItem(cls, item, prices):
        pass

    @classmethod
    def _updateDisabled(cls, prices, dealPanelModel):
        buyMoney = prices[cls._MONEY]
        isEnabled = not buyMoney.isDefined() or canBuyWithGoldExchange(buyMoney, cls._itemsCache.items.stats.money, cls._itemsCache.items.shop.exchangeRate)
        dealPanelModel.setIsDisabled(not isEnabled)