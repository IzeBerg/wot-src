from skeletons.gui.game_control import IGuiLootBoxesController
import Event

class GuiLootBoxesControllerStub(IGuiLootBoxesController):
    onStatusChange = Event.Event()
    onAvailabilityChange = Event.Event()
    onBoxesCountChange = Event.Event()
    onKeysUpdate = Event.Event()
    onWelcomeScreenClosed = Event.Event()

    @property
    def isConsumesEntitlements(self):
        return False

    def getSetting(self, setting):
        return

    def setSetting(self, setting, value):
        pass

    def isEnabled(self):
        return False

    def isLootBoxesAvailable(self):
        return False

    def isBuyAvailable(self):
        return False

    def isFirstStorageEnter(self):
        return True

    def setStorageVisited(self):
        pass

    def getDayLimit(self):
        return 0

    def openShop(self, lootboxID=None):
        pass

    def getDayInfoStatistics(self):
        return {}

    def getExpiresAtLootBoxBuyCounter(self):
        return 0

    def getTimeLeftToResetPurchase(self):
        return 0

    def getStoreInfo(self):
        return {}

    def getBoxesIDs(self):
        return ()

    def getBoxesCount(self):
        return 0

    def getBoxKeysCount(self):
        return 0

    def getKeyByID(self, keyID):
        return

    def getKeyByTokenID(self, keyID):
        return

    def getBonusesOrder(self, category=None):
        return tuple()

    def getHangarOptimizer(self):
        return

    def addShopWindowHandler(self, keyHandler, handler):
        pass

    def hasLootboxKey(self):
        return False

    def hasInfiniteLootboxes(self):
        return False

    def getGuiLootBoxes(self):
        return []

    def getGuiLootBoxByTokenID(self, tokenID):
        return