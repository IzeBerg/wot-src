from gui.impl.common.tabs_controller import tabUpdateFunc
from gui.impl.lobby.tank_setup.configurations.base import BaseTankSetupTabsController
from gui.impl.lobby.tank_setup.array_providers.consumable import ConsumableDeviceProvider

class ConsumableTabs(object):
    DEFAULT = 'default'
    ALL = (
     DEFAULT,)


class ConsumableTabsController(BaseTankSetupTabsController):
    __slots__ = ()

    def getDefaultTab(self):
        return ConsumableTabs.DEFAULT

    @tabUpdateFunc(ConsumableTabs.DEFAULT)
    def _updateDefault(self, viewModel, isFirst=False):
        pass

    def tabOrderKey(self, tabName):
        return ConsumableTabs.ALL.index(tabName)

    def _getAllProviders(self):
        return {ConsumableTabs.DEFAULT: ConsumableDeviceProvider}