import constants
from gui import GUI_SETTINGS
from gui.Scaleform.framework.entities.abstract.GlobalVarsMgrMeta import GlobalVarsMgrMeta
from helpers import getClientOverride, dependency
from skeletons.gui.game_control import IWalletController, ITradeInController
from skeletons.gui.lobby_context import ILobbyContext
from skeletons.gui.shared import IItemsCache
from skeletons.tutorial import ITutorialLoader

class GlobalVarsManager(GlobalVarsMgrMeta):
    _isLoginLoadInfoRequested = False
    itemsCache = dependency.descriptor(IItemsCache)
    wallet = dependency.descriptor(IWalletController)
    tradeIn = dependency.descriptor(ITradeInController)
    lobbyContext = dependency.descriptor(ILobbyContext)
    __tutorialLoader = dependency.descriptor(ITutorialLoader)

    def isDevelopment(self):
        return constants.IS_DEVELOPMENT

    def isShowLangaugeBar(self):
        return GUI_SETTINGS.isShowLanguageBar

    def isShowServerStats(self):
        return constants.IS_SHOW_SERVER_STATS

    def isChina(self):
        return constants.IS_CHINA

    def isKorea(self):
        return constants.IS_KOREA

    def isTutorialRunning(self, tutorialID):
        return self.__tutorialLoader.isRunning and self.__tutorialLoader.tutorialID == tutorialID

    def isFreeXpToTankman(self):
        return self.itemsCache.items.shop.freeXPToTManXPRate > 0

    def getLocaleOverride(self):
        return getClientOverride()

    def isRoamingEnabled(self):
        return self.lobbyContext.getServerSettings().roaming.isEnabled()

    def isInRoaming(self):
        return self.lobbyContext.getServerSettings().roaming.isInRoaming()

    def isWalletAvailable(self):
        if self.wallet:
            return self.wallet.isAvailable
        return False

    def isShowLoginRssFeed(self):
        return GUI_SETTINGS.loginRssFeed.show

    def isRentalsEnabled(self):
        return constants.IS_RENTALS_ENABLED

    def isPersonalMissionsEnabled(self):
        return self.lobbyContext.getServerSettings().isPersonalMissionsEnabled()

    def isLoginLoadedAtFirstTime(self):
        if GlobalVarsManager._isLoginLoadInfoRequested:
            return False
        GlobalVarsManager._isLoginLoadInfoRequested = True
        return True

    def isVehicleRestoreEnabled(self):
        return self.lobbyContext.getServerSettings().isVehicleRestoreEnabled()

    def isTradeInEnabled(self):
        return self.tradeIn.isEnabled()