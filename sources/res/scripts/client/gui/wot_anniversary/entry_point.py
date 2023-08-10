import typing
from account_helpers.AccountSettings import WOT_ANNIVERSARY_SEEN_BATTLE_QUESTS
from frameworks.wulf import ViewSettings
from frameworks.wulf.gui_constants import ViewFlags
from gui.ClientUpdateManager import g_clientUpdateManager
from gui.Scaleform.framework.entities.inject_component_adaptor import InjectComponentAdaptor
from gui.impl.gen import R
from gui.impl.gen.view_models.views.lobby.wot_anniversary.wot_anniversary_entry_point_model import WotAnniversaryEntryPointModel, State
from gui.impl.pub import ViewImpl
from gui.impl.wrappers.function_helpers import replaceNoneKwargsModel
from gui.wot_anniversary.wot_anniversary_helpers import showWotAnniversaryIntroWindow, getWotAnniversarySectionSetting, showMainView, isAnniversaryIntroShowed
from helpers import dependency
from skeletons.account_helpers.settings_core import ISettingsCore
from skeletons.gui.game_control import IWotAnniversaryController, IWalletController
from skeletons.gui.shared import IItemsCache

class WotAnniversaryEntryPointInjectWidget(InjectComponentAdaptor):

    def _makeInjectView(self):
        return WotAnniversaryEntryPointWidget()


class WotAnniversaryEntryPointWidget(ViewImpl):
    __wotAnniversaryCtrl = dependency.descriptor(IWotAnniversaryController)
    __itemsCache = dependency.descriptor(IItemsCache)
    __wallet = dependency.descriptor(IWalletController)
    __settingsCore = dependency.descriptor(ISettingsCore)

    def __init__(self):
        settings = ViewSettings(R.views.lobby.wot_anniversary.EntryPoint())
        settings.flags = ViewFlags.COMPONENT
        settings.model = WotAnniversaryEntryPointModel()
        super(WotAnniversaryEntryPointWidget, self).__init__(settings)

    @property
    def viewModel(self):
        return super(WotAnniversaryEntryPointWidget, self).getViewModel()

    def _initialize(self):
        super(WotAnniversaryEntryPointWidget, self)._initialize()
        self.viewModel.onEnterEventLobby += self.__onEnterEventLobby
        self.__wotAnniversaryCtrl.onSettingsChanged += self.__onSettingChanged
        self.__wotAnniversaryCtrl.onNewBattleQuestsReceived += self.__updateModel
        self.__wallet.onWalletStatusChanged += self.__onWalletStatusChanged
        g_clientUpdateManager.addCallbacks({'stats.eventCoin': self.__onEventCoinUpdate})

    def _finalize(self):
        self.viewModel.onEnterEventLobby -= self.__onEnterEventLobby
        self.__wotAnniversaryCtrl.onSettingsChanged -= self.__onSettingChanged
        self.__wotAnniversaryCtrl.onNewBattleQuestsReceived -= self.__updateModel
        self.__wallet.onWalletStatusChanged -= self.__onWalletStatusChanged
        g_clientUpdateManager.removeObjectCallbacks(self)
        super(WotAnniversaryEntryPointWidget, self)._finalize()

    def _onLoading(self, *args, **kwargs):
        super(WotAnniversaryEntryPointWidget, self)._onLoading(*args, **kwargs)
        self.__updateModel()

    def __updateModel(self):
        if not self.__wotAnniversaryCtrl.isAvailableAndActivePhase():
            return
        hasNewBattleQuests, battleQuestsDone = self.__findAndProcessActiveBattleQuests()
        with self.viewModel.transaction() as (tx):
            if battleQuestsDone:
                state = State.DONE if self.__wotAnniversaryCtrl.isLastDayNow() else State.NOQUESTS
            elif hasNewBattleQuests:
                state = State.NEWQUESTS
            else:
                state = State.INPROGRESS
            tx.setState(state)
            self.__updateBalance(model=tx)

    @replaceNoneKwargsModel
    def __updateBalance(self, model=None):
        eventCoins = self.__itemsCache.items.stats.eventCoin if self.__wallet.isAvailable else -1
        model.setBalance(eventCoins)

    def __findAndProcessActiveBattleQuests(self):
        newBattleQuests = False
        battleQuestsCompleted = True
        latestNotFinishedBattleQuestId = self.__wotAnniversaryCtrl.getLatestNotFinishedBattleQuestId()
        if latestNotFinishedBattleQuestId is not None:
            battleQuestsCompleted = False
            prevLatestBattleQuestID = getWotAnniversarySectionSetting(WOT_ANNIVERSARY_SEEN_BATTLE_QUESTS)
            if prevLatestBattleQuestID != latestNotFinishedBattleQuestId:
                newBattleQuests = True
        return (
         newBattleQuests, battleQuestsCompleted)

    def __onEnterEventLobby(self):
        self.__updateModel()
        if not isAnniversaryIntroShowed():
            showWotAnniversaryIntroWindow(closeCallback=showMainView)
            return
        showMainView()

    def __onSettingChanged(self):
        self.__updateModel()

    def __onEventCoinUpdate(self, _):
        self.__updateModel()

    def __onWalletStatusChanged(self, _):
        self.__updateBalance()

    def __onBalanceChanged(self, _):
        self.__updateBalance()