import typing
from gui.platform.products_fetcher.product_descriptor import ProductDescriptor
from helpers import dependency
from skeletons.connection_mgr import IConnectionManager
from skeletons.gui.lobby_context import ILobbyContext
from skeletons.gui.offers import IOffersDataProvider
from skeletons.gui.server_events import IEventsCache
if typing.TYPE_CHECKING:
    from gui.server_events.event_items import Quest

class SubscriptionDescriptor(ProductDescriptor):
    _lobbyContext = dependency.descriptor(ILobbyContext)
    _connectionMgr = dependency.descriptor(IConnectionManager)

    def __init__(self, params):
        super(SubscriptionDescriptor, self).__init__(params)
        self._offerToken = None
        return

    @property
    def isSubscribed(self):
        return False

    @property
    def expirationTime(self):
        return 0

    def hasDepotRewards(self):
        return False

    def isRewardsClaimed(self):
        return False

    def getOfferToken(self):
        return self._offerToken

    def getOfferID(self):
        return

    def _getEvents(self):
        return (
         (
          self._lobbyContext.getServerSettings().onServerSettingsChange, self._onServerSettingsChange),
         (
          self._connectionMgr.onDisconnected, self._onServerSettingsChange))

    def _onServerSettingsChange(self, *args, **kwargs):
        self._offerToken = None
        return


class PrimeGamingDescriptor(SubscriptionDescriptor):
    __PRIME_GAMING_FILTER_STR = 'PrimeGaming'
    __eventsCache = dependency.descriptor(IEventsCache)
    __offersProvider = dependency.descriptor(IOffersDataProvider)

    def __init__(self, params):
        super(PrimeGamingDescriptor, self).__init__(params)
        self.__primeGamingQuest = None
        return

    @property
    def isSubscribed(self):
        return True

    @property
    def expirationTime(self):
        quest = self.getPrimeGamingQuest()
        if quest:
            return quest.getFinishTimeRaw()
        return 0

    def hasDepotRewards(self):
        offerID = self.getOfferToken()
        return offerID and self.__offersProvider.isOfferAvailable(offerID)

    def isRewardsClaimed(self):
        quest = self.getPrimeGamingQuest()
        if quest:
            return quest.isCompleted()
        return False

    def getPrimeGamingQuest(self):
        if self.__primeGamingQuest:
            return self.__primeGamingQuest
        quests = self.__eventsCache.getQuests(self.__twitchFilterFunc)
        for quest in quests.values():
            conditionTokens = quest.accountReqs.getTokens()
            isPrimeGamingQuest = all(self.__PRIME_GAMING_FILTER_STR in token.getID() for token in conditionTokens)
            if isPrimeGamingQuest:
                self.__primeGamingQuest = quest

        return self.__primeGamingQuest

    def getOfferToken(self):
        if self._offerToken:
            return self._offerToken
        quests = self.__eventsCache.getQuests(self.__twitchFilterFunc)
        for quest in quests.values():
            bonuses = quest.getBonuses('tokens')
            for bonus in bonuses:
                for tID in bonus.getTokens():
                    if tID.startswith('offer:'):
                        self._offerToken = tID
                        break

        return self._offerToken

    def getOfferID(self):
        offerToken = self.getOfferToken()
        if offerToken and self.__offersProvider.isOfferAvailable(offerToken):
            return self.__offersProvider.getOfferByToken(offerToken).id
        else:
            return

    def _onServerSettingsChange(self, *args, **kwargs):
        super(PrimeGamingDescriptor, self)._onServerSettingsChange(args, kwargs)
        self.__primeGamingQuest = None
        return

    def __twitchFilterFunc(self, q):
        return q.getID().startswith('twitch')