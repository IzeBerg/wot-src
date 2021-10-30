import logging, BigWorld
from constants import RENEWABLE_SUBSCRIPTION_CONFIG
from frameworks.wulf import ViewFlags, ViewSettings
from gui.Scaleform.Waiting import Waiting
from gui.impl.gen import R
from gui.impl.gen.view_models.views.lobby.premacc.dashboard.prem_dashboard_view_model import PremDashboardViewModel
from gui.impl.lobby.premacc.dashboard.dashboard_premium_card import DashboardPremiumCard
from gui.impl.lobby.premacc.dashboard.piggy_bank_card.prem_piggy_bank_card import PremPiggyBankCard
from gui.impl.lobby.premacc.dashboard.piggy_bank_card.wot_plus_piggy_bank_card import WotPlusPiggyBankCard
from gui.impl.lobby.premacc.dashboard.prem_dashboard_dog_tags_card import PremDashboardDogTagsCard
from gui.impl.lobby.premacc.dashboard.prem_dashboard_double_experience_card import PremDashboardDoubleExperienceCard
from gui.impl.lobby.premacc.dashboard.prem_dashboard_header import PremDashboardHeader
from gui.impl.lobby.premacc.dashboard.prem_dashboard_maps_blacklist_card import PremDashboardMapsBlacklistCard
from gui.impl.lobby.premacc.dashboard.prem_dashboard_quests_card import PremDashboardQuestsCard
from gui.impl.lobby.premacc.premacc_helpers import SoundViewMixin
from gui.impl.pub import ViewImpl
from gui.shared.event_dispatcher import showHangar
from helpers import dependency
from skeletons.gui.lobby_context import ILobbyContext
_logger = logging.getLogger(__name__)

class PremDashboardView(ViewImpl, SoundViewMixin):
    __slots__ = ()
    __lobbyContext = dependency.descriptor(ILobbyContext)

    def __init__(self, layoutID):
        settings = ViewSettings(layoutID)
        settings.flags = ViewFlags.LOBBY_SUB_VIEW
        settings.model = PremDashboardViewModel()
        super(PremDashboardView, self).__init__(settings)
        Waiting.show('loadPage')

    @property
    def viewModel(self):
        return super(PremDashboardView, self).getViewModel()

    def _onLoading(self, *args, **kwargs):
        super(PremDashboardView, self)._onLoading()
        self._addSoundEvent()
        self.viewModel.onCloseAction += self.__onCloseAction
        self.viewModel.onInitialized += self.__onInitialized
        self.__lobbyContext.getServerSettings().onServerSettingsChange += self._onServerSettingsChange
        self.setChildView(R.dynamic_ids.prem_dashboard.premium_card(), DashboardPremiumCard())
        self.setChildView(R.dynamic_ids.prem_dashboard.double_xp_card(), PremDashboardDoubleExperienceCard())
        self.__setPiggyBankCard()
        self.setChildView(R.dynamic_ids.prem_dashboard.premium_quests_card(), PremDashboardQuestsCard())
        self.setChildView(R.dynamic_ids.prem_dashboard.maps_black_list_card(), PremDashboardMapsBlacklistCard())
        self.setChildView(R.dynamic_ids.prem_dashboard.dog_tags_card(), PremDashboardDogTagsCard())

    def __setPiggyBankCard(self):
        isWotPlusEnabled = self.__lobbyContext.getServerSettings().isRenewableSubEnabled()
        isWotPlusNSEnabled = self.__lobbyContext.getServerSettings().isWotPlusNewSubscriptionEnabled()
        hasWotPlusActive = BigWorld.player().renewableSubscription.isEnabled()
        hasGold = BigWorld.player().renewableSubscription.getGoldReserve()
        showNewPiggyBank = isWotPlusEnabled and (hasWotPlusActive or isWotPlusNSEnabled or hasGold)
        if not showNewPiggyBank and hasGold:
            _logger.info('There is hidden gold in piggy bank.')
        self.setChildView(R.dynamic_ids.prem_dashboard.piggy_bank_card(), WotPlusPiggyBankCard() if showNewPiggyBank else PremPiggyBankCard())

    def _onLoaded(self, *args, **kwargs):
        super(PremDashboardView, self)._onLoaded(*args, **kwargs)
        self.setChildView(R.dynamic_ids.prem_dashboard.header(), PremDashboardHeader())

    def _onServerSettingsChange(self, diff):
        if RENEWABLE_SUBSCRIPTION_CONFIG in diff:
            self.__setPiggyBankCard()

    def _finalize(self):
        self.viewModel.onCloseAction -= self.__onCloseAction
        self.viewModel.onInitialized -= self.__onInitialized
        self.__lobbyContext.getServerSettings().onServerSettingsChange -= self._onServerSettingsChange
        self._removeSoundEvent()

    def __onCloseAction(self):
        showHangar()

    def __onInitialized(self):
        Waiting.hide('loadPage')