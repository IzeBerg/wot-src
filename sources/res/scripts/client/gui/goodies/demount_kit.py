import Event
from account_helpers.AccountSettings import AccountSettings, DEMOUNT_KIT_SEEN
from gui.ClientUpdateManager import g_clientUpdateManager
from gui.goodies.goodie_items import DemountKit
from gui.shared.gui_items import GUI_ITEM_TYPE
from gui.shared.utils.requesters import REQ_CRITERIA
from helpers import dependency
from skeletons.gui.demount_kit import IDemountKitNovelty
from skeletons.gui.goodies import IGoodiesCache
from skeletons.gui.shared import IItemsCache

def isDemountKitApplicableTo(optDevice):
    if optDevice.itemTypeID == GUI_ITEM_TYPE.OPTIONALDEVICE and not optDevice.isRemovable and not optDevice.isDeluxe:
        demountKit, _ = getDemountKitForOptDevice(optDevice)
        return demountKit and demountKit.enabled
    return False


def getDemountKitForOptDevice(optDevice):
    itemsCache = dependency.instance(IItemsCache)
    goodiesCache = dependency.instance(IGoodiesCache)
    currency = optDevice.getRemovalPrice(itemsCache.items).getCurrency()
    demountKit = goodiesCache.getDemountKit(currency=currency)
    return (
     demountKit, currency)


class DemountKitNovelty(IDemountKitNovelty):
    __goodiesCache = dependency.descriptor(IGoodiesCache)
    __itemsCache = dependency.descriptor(IItemsCache)

    def __init__(self):
        self.onUpdated = Event.Event()
        self.__showNovelty = False

    def init(self):
        g_clientUpdateManager.addCallbacks({'goodies': self.__onGoodiesUpdated})
        self.__itemsCache.onSyncCompleted += self.__onCacheResync
        self.__resolveNovelty()

    def fini(self):
        g_clientUpdateManager.removeObjectCallbacks(self)
        self.__itemsCache.onSyncCompleted -= self.__onCacheResync

    def setAsSeen(self):
        AccountSettings.setCounters(DEMOUNT_KIT_SEEN, True)
        self.__resolveNovelty()

    @property
    def showNovelty(self):
        return self.__showNovelty

    @property
    def noveltyCount(self):
        if self.showNovelty:
            return 1
        return 0

    def __onGoodiesUpdated(self, *_):
        self.__resolveNovelty()

    def __resolveNovelty(self):
        showNovelty = not AccountSettings.getCounters(DEMOUNT_KIT_SEEN) and len(self.__goodiesCache.getDemountKits(REQ_CRITERIA.DEMOUNT_KIT.IN_ACCOUNT | REQ_CRITERIA.DEMOUNT_KIT.IS_ENABLED)) > 0
        if showNovelty != self.__showNovelty:
            self.__showNovelty = showNovelty
            self.onUpdated()

    def __onCacheResync(self, *_):
        self.__resolveNovelty()