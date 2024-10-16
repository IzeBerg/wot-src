from battle_royale.gui.impl.lobby.tooltips.br_coin_tooltip_view import BrCoinTooltipView
from frameworks.wulf import ViewFlags, ViewSettings
from gui.impl.gen import R
from gui.impl.pub import ViewImpl
from gui.shared.event_dispatcher import showShop
from gui.Scaleform.daapi.view.lobby.store.browser.shop_helpers import getSteelHunterProductsUrl
from gui.Scaleform.framework.entities.inject_component_adaptor import InjectComponentAdaptor
from gui.impl.gen.view_models.views.battle_royale.proxy_currency_cmp_view_model import ProxyCurrencyCmpViewModel
from helpers import dependency
from skeletons.gui.game_control import IBattleRoyaleController

class ProxyCurrencyComponentInject(InjectComponentAdaptor):

    def _makeInjectView(self):
        return ProxyCurrencyView()


class ProxyCurrencyView(ViewImpl):
    __slots__ = ()
    battleRoyaleController = dependency.descriptor(IBattleRoyaleController)

    def __init__(self):
        settings = ViewSettings(R.views.battle_royale.lobby.views.ProxyCurrencyView())
        settings.flags = ViewFlags.VIEW
        settings.model = ProxyCurrencyCmpViewModel()
        super(ProxyCurrencyView, self).__init__(settings)

    @property
    def viewModel(self):
        return super(ProxyCurrencyView, self).getViewModel()

    def createToolTipContent(self, event, contentID):
        if contentID == R.views.battle_royale.lobby.tooltips.BrCoinTooltipView():
            return BrCoinTooltipView()
        else:
            return

    def _initialize(self):
        super(ProxyCurrencyView, self)._initialize()
        self.battleRoyaleController.onBalanceUpdated += self.__updateModel
        self.viewModel.onGotoShopBtnClicked += self.__onGotoShopBtnClicked
        self.__updateModel()

    def _finalize(self):
        self.viewModel.onGotoShopBtnClicked -= self.__onGotoShopBtnClicked
        self.battleRoyaleController.onBalanceUpdated -= self.__updateModel
        super(ProxyCurrencyView, self)._finalize()

    def __onGotoShopBtnClicked(self):
        showShop(getSteelHunterProductsUrl())

    def __updateModel(self, *_):
        brCoin = self.battleRoyaleController.getBRCoinBalance(0)
        with self.viewModel.transaction() as (model):
            model.setBalance(brCoin)