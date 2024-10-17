from gui.impl.lobby.tank_setup.configurations.consumable import ConsumableTabsController, ConsumableTabs
from halloween.gui.impl.lobby.tank_setup.array_provider import HalloweenConsumableProvider, HalloweenDefConsumableProvider
from halloween.gui.shared import isHalloweenDefenceSelected

class HalloweenTabsController(ConsumableTabsController):
    __slots__ = ()

    def _getAllProviders(self):
        if isHalloweenDefenceSelected():
            return {ConsumableTabs.DEFAULT: HalloweenDefConsumableProvider}
        return {ConsumableTabs.DEFAULT: HalloweenConsumableProvider}