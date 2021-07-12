from gui.impl.lobby.tabs_controller import tabUpdateFunc
from gui.impl.lobby.tank_setup.array_providers.shell import ShellProvider
from gui.impl.lobby.tank_setup.configurations.base import BaseTankSetupTabsController, BaseDealPanel

class ShellTabs(object):
    SHELLS = 'shells'
    ALL = (
     SHELLS,)


class ShellTabsController(BaseTankSetupTabsController):
    __slots__ = ()

    def getDefaultTab(self):
        return ShellTabs.SHELLS

    @tabUpdateFunc(ShellTabs.SHELLS)
    def _updateDefault(self, viewModel, isFirst=False):
        pass

    def _getAllProviders(self):
        return {ShellTabs.SHELLS: ShellProvider}


class ShellDealPanel(BaseDealPanel):

    @classmethod
    def addItem(cls, item, prices):
        intCD, installedCount, currentCount = item
        if installedCount >= currentCount:
            return
        inventoryItem = cls._itemsCache.items.getItemByCD(intCD)
        delta = currentCount - installedCount
        storageDelta = min(delta, inventoryItem.inventoryCount)
        prices[cls._IN_STORAGE] += storageDelta
        delta -= storageDelta
        if delta:
            prices[cls._MONEY] += inventoryItem.getBuyPrice().price * delta