import typing
from gui.ClientUpdateManager import g_clientUpdateManager
from Event import Event, EventManager
from gui.shared.money import DynamicMoney
from helpers import dependency
from ny_common.GeneralConfig import GeneralConfig
from skeletons.gui.shared import IItemsCache
from skeletons.gui.lobby_context import ILobbyContext
from items.components.ny_constants import NyCurrency, Ny23CoinToken
if typing.TYPE_CHECKING:
    from gui.shared.gui_items.loot_box import LootBox

@dependency.replace_none_kwargs(lobbyCtx=ILobbyContext)
def getNYGeneralConfig(lobbyCtx=None):
    return lobbyCtx.getServerSettings().getNewYearGeneralConfig()


class NyCurrenciesHelper(object):
    __itemsCache = dependency.descriptor(IItemsCache)

    def __init__(self):
        self.__balance = DynamicMoney()
        self._eManager = EventManager()
        self.onBalanceUpdated = Event(self._eManager)
        self.onNyCoinsUpdate = Event(self._eManager)
        self.__coinsCount = None
        return

    def onLobbyInited(self):
        self.__initBalanceCurrencies()
        self.__updateCoinsCount()
        self.__addEventHandlers()

    def clear(self):
        self.__removeEventHandlers()

    def __addEventHandlers(self):
        g_clientUpdateManager.addCallbacks({'cache.dynamicCurrencies': self.__updateDynamicCurrencies, 
           'tokens': self.__onTokensChanged})

    def getResourceConverterCoefficients(self):
        generalConfig = getNYGeneralConfig()
        return generalConfig.getResourceConverterCoefficients()

    def calculateInitialValueByReceived(self, value):
        generalConfig = getNYGeneralConfig()
        return generalConfig.calculateInitialValueByReceived(value)

    def __removeEventHandlers(self):
        g_clientUpdateManager.removeObjectCallbacks(self)

    def getResourcesBalance(self):
        return {currency:self.getResouceBalance(currency) for currency in NyCurrency.ALL}

    def getResouceBalance(self, currencyCode, default=0):
        return int(self.__balance.get(currencyCode, default))

    def getCoins(self):
        return self.__itemsCache.items.tokens.getNyCoins()

    def getCoinsCount(self):
        return self.__coinsCount

    def __initBalanceCurrencies(self):
        self.__updateBalanceCurrencies()
        self.onBalanceUpdated()

    def __updateBalanceCurrencies(self):
        self.__balance = self.__itemsCache.items.stats.getDynamicMoney()

    def __updateDynamicCurrencies(self, currencies):
        changed = [ currency for currency in currencies.keys() if currency in NyCurrency.ALL ]
        if not changed:
            return
        for currency in changed:
            if self.getResouceBalance(currency) != currencies.get(currency, 0):
                self.__updateBalanceCurrencies()
                self.onBalanceUpdated()
                return

    def __onTokensChanged(self, tokens):
        if any(token.startswith(Ny23CoinToken.ID) for token in tokens):
            self.__updateCoinsCount()
            self.onNyCoinsUpdate()

    def __updateCoinsCount(self):
        coins = self.getCoins()
        self.__coinsCount = coins.getInventoryCount() if coins else 0