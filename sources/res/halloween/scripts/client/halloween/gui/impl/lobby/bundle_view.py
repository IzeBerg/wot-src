import typing
from adisp import adisp_process
from gui.impl.dialogs.sub_views.top_right.money_balance import MoneyBalance
from gui.impl.lobby.common.tooltips.extended_text_tooltip import ExtendedTextTooltip
from gui.server_events.awards_formatters import AWARDS_SIZES
from halloween.gui.impl.gen.view_models.views.lobby.bundle_bonus_model import BundleBonusModel
from halloween.gui.impl.lobby.dialogs.sub_views.icon.hw_reward_list import HWRewardList
from halloween.gui.impl.lobby.hw_helpers.bonuses_formatters import HalloweenBonusesAwardsComposer, getHWBundleAwardFormatter
from halloween.gui.shop import showHWBuyGoldForBundle
from halloween.skeletons.halloween_artefacts_controller import IHalloweenArtefactsController
from halloween.skeletons.halloween_controller import IHalloweenController
from halloween.skeletons.halloween_shop_controller import IHalloweenShopController
from helpers import dependency
from skeletons.gui.shared import IItemsCache
from wg_async import wg_await, wg_async
from gui.impl.gen import R
from gui.impl import backport
from gui.impl.dialogs import dialogs
from halloween.gui.impl.lobby.base_view import BaseView
from frameworks.wulf import ViewSettings, WindowLayer
from gui.impl.pub.lobby_window import LobbyWindow
from frameworks.wulf import WindowFlags
from gui.impl.pub.dialog_window import DialogButtons
from gui.impl.dialogs.gf_builders import BaseDialogBuilder
from gui.shared.view_helpers.blur_manager import CachedBlur
from gui.shared.money import Money, Currency
from gui.shared.gui_items.gui_item_economics import ItemPrice
from gui.impl.gen.view_models.views.dialogs.sub_views.currency_view_model import CurrencySize
from gui.impl.dialogs.dialog_template_button import CancelButton, ButtonType, ConfirmButton
from gui.impl.gen.view_models.views.dialogs.default_dialog_place_holders import DefaultDialogPlaceHolders
from gui.impl.dialogs.sub_views.footer.single_price_footer import SinglePriceFooter
from halloween.gui.impl.gen.view_models.views.lobby.bundle_view_model import BundleViewModel
from halloween.gui.impl.gen.view_models.views.lobby.bundle_model import BundleModel
MAX_BONUSES_IN_VIEW = 5
PREMIUM = 'premium_plus'

def getBuyBundleDialog(bundle):
    formatter = HalloweenBonusesAwardsComposer(MAX_BONUSES_IN_VIEW, getHWBundleAwardFormatter())
    bonusRewards = formatter.getFormattedBonuses(bundle.bonuses, AWARDS_SIZES.BIG)
    builder = BuyBundleDialogBuilder(bundle.price.amount, bundle.oldPrice.amount, bundle.price.currency, bonusRewards)
    bundleName = backport.text(R.strings.halloween_lobby.bundleView.bundle.title.dyn(bundle.bundleID)())
    builder.setTitle(str(backport.text(R.strings.halloween_lobby.bundleView.confirmation.title(), bundleName=bundleName)))
    return builder.build()


class BundleView(BaseView):
    _itemsCache = dependency.descriptor(IItemsCache)
    _hwController = dependency.descriptor(IHalloweenController)
    _hwArtefactCtrl = dependency.descriptor(IHalloweenArtefactsController)
    _hwShopCtrl = dependency.descriptor(IHalloweenShopController)

    def __init__(self, layoutID=R.views.halloween.lobby.BundleView(), price=0, callback=None):
        settings = ViewSettings(layoutID, model=BundleViewModel())
        super(BundleView, self).__init__(settings)
        self.__price = price
        self.__callback = callback
        self.__isPurchased = False

    @property
    def viewModel(self):
        return super(BundleView, self).getViewModel()

    def createToolTipContent(self, event, contentID):
        if contentID == R.views.lobby.common.tooltips.ExtendedTextTooltip():
            text = event.getArgument('text', '')
            stringifyKwargs = event.getArgument('stringifyKwargs', '')
            return ExtendedTextTooltip(text, stringifyKwargs)
        return super(BundleView, self).createToolTipContent(event, contentID)

    def _onLoading(self, *args, **kwargs):
        super(BundleView, self)._onLoading()
        balanceLayoutID = R.views.halloween.lobby.widgets.MoneyBalance()
        self.setChildView(balanceLayoutID, MoneyBalance(layoutID=balanceLayoutID))
        with self.viewModel.transaction() as (tx):
            tx.setLacksKeys(max(0, self.__price - self._hwArtefactCtrl.getArtefactKeyQuantity()))
            self._loadBundles(tx)

    def _loadBundles(self, model):
        bundles = self._hwShopCtrl.keyBundles()
        bundlesModel = model.getBundles()
        bundlesModel.clear()
        for bundle in bundles:
            limit = None
            if bundle.limit is not None:
                limit = max(0, bundle.limit - self._hwShopCtrl.getPurchaseCount(bundle.bundleID))
                if limit == 0:
                    continue
            bundleModel = BundleModel()
            bundleModel.setId(bundle.bundleID)
            bundleModel.setDate(backport.getLongDateFormat(self._hwController.getModeSettings().endDate))
            bundleModel.setBundleName(backport.text(R.strings.halloween_lobby.bundleView.bundle.title.dyn(bundle.bundleID)()))
            if bundle.limit is not None:
                bundleModel.setCanBeBoughtTimes(limit)
            else:
                bundleModel.setCanBeBoughtTimes(-1)
            bundleModel.price.setCurrency(bundle.price.currency)
            bundleModel.price.setPrice(bundle.price.amount)
            if bundle.oldPrice.currency is not None:
                bundleModel.price.setFullPrice(bundle.oldPrice.amount)
                bundleModel.price.setDiscount(round((1 - float(bundle.price.amount) / float(bundle.oldPrice.amount)) * 100))
            formatter = HalloweenBonusesAwardsComposer(MAX_BONUSES_IN_VIEW, getHWBundleAwardFormatter())
            bonusRewards = formatter.getFormattedBonuses(bundle.bonuses, AWARDS_SIZES.BIG)
            rewards = bundleModel.getBonuses()
            rewards.clear()
            for bonuse in bonusRewards:
                bonusModel = BundleBonusModel()
                bonusModel.setId(bonuse.bonusName)
                bonusModel.setName(bonuse.userName)
                bonusModel.setValue(str(bonuse.label))
                rewards.addViewModel(bonusModel)

            bundlesModel.addViewModel(bundleModel)

        bundlesModel.invalidate()
        return

    @wg_async
    def _onPurchaseBundle(self, args):
        bundleId = args.get('id', None)
        if bundleId is None:
            return
        else:
            bundle = self._hwShopCtrl.getBundleByID(bundleId)
            if bundle.price.currency == Currency.GOLD and bundle.price.amount > self.__getGold() and self._itemsCache.items.stats.mayConsumeWalletResources:
                showHWBuyGoldForBundle(bundle.price.amount, {})
            result = yield wg_await(dialogs.show(getBuyBundleDialog(bundle)))
            if result.result == DialogButtons.SUBMIT:
                if bundle.price.currency == Currency.GOLD and bundle.price.amount > self.__getGold() and self._itemsCache.items.stats.mayConsumeWalletResources:
                    self._onPurchaseBundle(args)
                else:
                    self.__processPurchase(bundleId)
                    self.__isPurchased = True
            return

    def _getEvents(self):
        return [
         (
          self.viewModel.onClose, self._onClose),
         (
          self.viewModel.onPurchaseBundle, self._onPurchaseBundle),
         (
          self._hwShopCtrl.onBundlesUpdated, self.__onBundlesUpdated),
         (
          self._hwArtefactCtrl.onArtefactKeyUpdated, self.__onArtefactKeyUpdated)]

    def __onArtefactKeyUpdated(self):
        self.__checkAutoBuy()
        self.viewModel.setLacksKeys(self.__price - self._hwArtefactCtrl.getArtefactKeyQuantity())

    @adisp_process
    def __processPurchase(self, bundleID):
        yield self._hwShopCtrl.purchaseBundle(bundleID)

    def __onBundlesUpdated(self):
        with self.viewModel.transaction() as (tx):
            self._loadBundles(tx)
        if not self._hwShopCtrl.checkIsEnoughBundles():
            self.destroyWindow()

    def __getGold(self):
        return self._itemsCache.items.stats.money.get(Currency.GOLD, 0)

    def __checkAutoBuy(self):
        if self.__callback is not None and self.__price <= self._hwArtefactCtrl.getArtefactKeyQuantity() and self.__isPurchased:
            self.__callback()
            self.__isPurchased = False
            self.destroyWindow()
        return


class BundleWindow(LobbyWindow):

    def __init__(self, layoutID, price=0, callback=None, parent=None):
        super(BundleWindow, self).__init__(wndFlags=WindowFlags.WINDOW_FULLSCREEN | WindowFlags.WINDOW, content=BundleView(layoutID=layoutID, price=price, callback=callback), parent=parent, layer=WindowLayer.FULLSCREEN_WINDOW)
        self._blur = None
        self._blur = CachedBlur(enabled=True, ownLayer=self.layer - 1)
        return

    def _finalize(self):
        self._blur.fini()
        super(BundleWindow, self)._finalize()


class BuyBundleDialogBuilder(BaseDialogBuilder):
    __slots__ = ('__bundlePrice', '__oldPrice', '__currency', '__bonuses')

    def __init__(self, price, oldPrice, currency, bonuses, uniqueID=None):
        super(BuyBundleDialogBuilder, self).__init__(uniqueID=uniqueID)
        self.__bundlePrice = price
        self.__bonuses = bonuses
        if oldPrice:
            self.__oldPrice = oldPrice
        else:
            self.__oldPrice = price
        self.__currency = currency
        self.addButton(ConfirmButton(label=R.strings.dialogs.buyConfirmation.submit(), buttonType=ButtonType.MAIN, isDisabled=False))
        descriptions = []
        for bonus in self.__bonuses:
            if int(bonus.label) > 1:
                if bonus.bonusName == PREMIUM:
                    descriptions.append(backport.text(R.strings.halloween_lobby.bundleView.reward.premiumFormat(), name=str(bonus.userName), count=bonus.label))
                else:
                    descriptions.append(backport.text(R.strings.halloween_lobby.bundleView.reward.format(), name=str(bonus.userName), count=bonus.label))
            else:
                descriptions.append(str(bonus.userName))

        self.setDescription((', ').join(descriptions))
        self.setFocusedButtonID(DialogButtons.SUBMIT)
        self.addButton(CancelButton())
        self.setLayer(WindowLayer.TOP_WINDOW)

    def _extendTemplate(self, template):
        super(BuyBundleDialogBuilder, self)._extendTemplate(template)
        template.setSubView(DefaultDialogPlaceHolders.ICON, HWRewardList(bonuses=self.__bonuses))
        template.setSubView(DefaultDialogPlaceHolders.TOP_RIGHT, MoneyBalance())
        if self.__bundlePrice:
            template.setSubView(DefaultDialogPlaceHolders.FOOTER, SinglePriceFooter(R.strings.dialogs.common.cost, ItemPrice(Money(**{self.__currency: self.__bundlePrice}), Money(**{self.__currency: self.__oldPrice})), CurrencySize.BIG))