from frameworks.wulf import Array
from frameworks.wulf import ViewModel
from gui.impl.wrappers.user_list_model import UserListModel
from gui.impl.gen.view_models.views.lobby.battle_pass.battle_pass_buy_confirm_view_model import BattlePassBuyConfirmViewModel
from gui.impl.gen.view_models.views.lobby.battle_pass.battle_pass_buy_rewards_view_model import BattlePassBuyRewardsViewModel
from gui.impl.gen.view_models.views.lobby.battle_pass.package_item import PackageItem

class BattlePassBuyViewModel(ViewModel):
    __slots__ = ('onBackClick', 'choosePackage', 'showConfirm', 'showRewards', 'onShopOfferClick')
    BUY_STATE = 'buyState'
    CONFIRM_STATE = 'confirmState'
    REWARDS_STATE = 'rewardsState'

    def __init__(self, properties=9, commands=5):
        super(BattlePassBuyViewModel, self).__init__(properties=properties, commands=commands)

    @property
    def packages(self):
        return self._getViewModel(0)

    @staticmethod
    def getPackagesType():
        return PackageItem

    @property
    def confirm(self):
        return self._getViewModel(1)

    @staticmethod
    def getConfirmType():
        return BattlePassBuyConfirmViewModel

    @property
    def rewards(self):
        return self._getViewModel(2)

    @staticmethod
    def getRewardsType():
        return BattlePassBuyRewardsViewModel

    def getState(self):
        return self._getString(3)

    def setState(self, value):
        self._setString(3, value)

    def getIsWalletAvailable(self):
        return self._getBool(4)

    def setIsWalletAvailable(self, value):
        self._setBool(4, value)

    def getIsShopOfferAvailable(self):
        return self._getBool(5)

    def setIsShopOfferAvailable(self, value):
        self._setBool(5, value)

    def getShopOfferDiscount(self):
        return self._getNumber(6)

    def setShopOfferDiscount(self, value):
        self._setNumber(6, value)

    def getIsSeasonWithAdditionalBackground(self):
        return self._getBool(7)

    def setIsSeasonWithAdditionalBackground(self, value):
        self._setBool(7, value)

    def getChaptersWithLogoBg(self):
        return self._getArray(8)

    def setChaptersWithLogoBg(self, value):
        self._setArray(8, value)

    @staticmethod
    def getChaptersWithLogoBgType():
        return int

    def _initialize(self):
        super(BattlePassBuyViewModel, self)._initialize()
        self._addViewModelProperty('packages', UserListModel())
        self._addViewModelProperty('confirm', BattlePassBuyConfirmViewModel())
        self._addViewModelProperty('rewards', BattlePassBuyRewardsViewModel())
        self._addStringProperty('state', 'buyState')
        self._addBoolProperty('isWalletAvailable', False)
        self._addBoolProperty('isShopOfferAvailable', False)
        self._addNumberProperty('shopOfferDiscount', 0)
        self._addBoolProperty('isSeasonWithAdditionalBackground', False)
        self._addArrayProperty('chaptersWithLogoBg', Array())
        self.onBackClick = self._addCommand('onBackClick')
        self.choosePackage = self._addCommand('choosePackage')
        self.showConfirm = self._addCommand('showConfirm')
        self.showRewards = self._addCommand('showRewards')
        self.onShopOfferClick = self._addCommand('onShopOfferClick')