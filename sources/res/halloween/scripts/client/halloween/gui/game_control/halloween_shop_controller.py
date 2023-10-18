import Event
from collections import namedtuple
from adisp import adisp_async
from gui import SystemMessages
from gui.shared.utils import decorators
from gui.ClientUpdateManager import g_clientUpdateManager
from gui.server_events.bonuses import getNonQuestBonuses
from halloween.gui.shared.gui_items.processors.processors import BuyBundleProcessor
from halloween.skeletons.halloween_controller import IHalloweenController
from halloween.skeletons.halloween_shop_controller import IHalloweenShopController
from halloween_common.halloween_constants import ShopSettings
from helpers import dependency
from skeletons.gui.server_events import IEventsCache
Price = namedtuple('Price', ('currency', 'amount'))

class Bundle(namedtuple('Bundle', ('bundleID', 'limit', 'price', 'oldPrice', 'bonuses'))):

    def getCtx(self):
        return dict(self._asdict())


class HalloweenShopController(IHalloweenShopController):
    eventsCache = dependency.descriptor(IEventsCache)
    halloweenCtrl = dependency.descriptor(IHalloweenController)

    def __init__(self):
        super(HalloweenShopController, self).__init__()
        self.onShopSettingsUpdated = Event.Event()
        self.onBundlesUpdated = Event.Event()
        self._bundles = {}

    def init(self):
        g_clientUpdateManager.addCallbacks({'tokens': self.__handleTokensUpdate})
        self.halloweenCtrl.onSettingsUpdate += self.__updateSettings

    def fini(self):
        g_clientUpdateManager.removeObjectCallbacks(self)
        self.halloweenCtrl.onSettingsUpdate -= self.__updateSettings
        self.onShopSettingsUpdated.clear()
        self.onBundlesUpdated.clear()
        self._bundles = {}

    def keyBundles(self):
        return sorted(self._bundles.itervalues(), key=lambda bundle: bundle.bundleID)

    def getBundleByID(self, bundleID):
        return self._bundles.get(bundleID, None)

    def isEnabled(self):
        return self._getConfig().get('enabled', False)

    def onLobbyInited(self, event):
        self._initBundles()

    @adisp_async
    @decorators.adisp_process('buyItem')
    def purchaseBundle(self, bundleID, callback):
        bundle = self.getBundleByID(bundleID)
        result = yield BuyBundleProcessor(bundleID, bundle.price).request()
        if result.userMsg:
            SystemMessages.pushMessage(result.userMsg, type=result.sysMsgType)
        callback(result.success)

    def getPurchaseCount(self, bundleID):
        return self.eventsCache.questsProgress.getTokenCount(bundleID + ShopSettings.PURCHASED_SUFFIX)

    def checkIsEnoughBundles(self):
        for bundle in self.keyBundles():
            if bundle.limit is not None:
                limit = bundle.limit - self.getPurchaseCount(bundle.bundleID)
                if limit > 0:
                    return True

        return False

    def _initBundles(self):
        self._bundles = dict((bundleID, Bundle(bundleID, self._getBundleLimit(bundleID), Price(*self._getPrice(bundleID, 'price')), Price(*self._getPrice(bundleID, 'oldPrice')), self._getBonuses(bundleID))) for bundleID in self._getBundles().iterkeys())

    def _getBundleLimit(self, bundleID):
        return self._getBundles().get(bundleID, {}).get('limit', None)

    def _getPrice(self, bundleID, priceKey):
        return self._getBundles().get(bundleID, {}).get(priceKey, (None, 0))

    def _getBundles(self):
        return self._getConfig().get('bundles', {})

    def _getBonuses(self, bundleID):
        rewards = []
        bonuses = self._getBundles().get(bundleID, {}).get('bonus', {})
        for bonusType, bonusValue in bonuses.iteritems():
            rewards.extend(getNonQuestBonuses(bonusType, bonusValue))

        return rewards

    def _getConfig(self):
        return self.halloweenCtrl.getModeSettings().shop

    def __updateSettings(self):
        self._initBundles()
        self.onShopSettingsUpdated()

    def __handleTokensUpdate(self, diff):
        for token in diff:
            if token.startswith(ShopSettings.SHOP_BUNDLE_PREFFIX):
                self.onBundlesUpdated()