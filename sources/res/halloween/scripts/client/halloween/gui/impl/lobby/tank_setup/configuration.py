from gui.impl.lobby.tank_setup.configurations.consumable import ConsumableTabsController, ConsumableTabs
from halloween.gui.impl.lobby.tank_setup.array_provider import HalloweenConsumableProvider

class HalloweenTabsController(ConsumableTabsController):
    __slots__ = ()

    def _getAllProviders(self):
        return {ConsumableTabs.DEFAULT: HalloweenConsumableProvider}