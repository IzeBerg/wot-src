from gui.impl.lobby.tank_setup.array_providers.consumable import ConsumableDeviceProvider
from gui.impl.lobby.tank_setup.configurations.consumable import ConsumableTabsController, ConsumableTabs
from gui.impl.lobby.tank_setup.sub_views.consumable_setup import ConsumableSetupSubView

class BootcampConsumableDeviceProvider(ConsumableDeviceProvider):

    def _fillStatus(self, model, item, slotID, isInstalledOrMounted):
        super(BootcampConsumableDeviceProvider, self)._fillStatus(model, item, slotID, isInstalledOrMounted)
        if not item.isInInventory:
            model.setIsDisabled(True)


class _BootcampConsumableTabsController(ConsumableTabsController):

    def _getAllProviders(self):
        return {ConsumableTabs.DEFAULT: BootcampConsumableDeviceProvider}


class BootcampConsumableSetupSubView(ConsumableSetupSubView):

    def onLoading(self, currentSlotID, *args, **kwargs):
        super(BootcampConsumableSetupSubView, self).onLoading(currentSlotID, *args, **kwargs)
        if any(self._interactor.getCurrentLayout()):
            return
        items = self._provider.getItemsList()
        for item in items:
            if item.isInInventory:
                self._onSelectItem({'intCD': item.intCD, 'isAutoSelect': True})
                break

    def _createTabsController(self):
        return _BootcampConsumableTabsController()