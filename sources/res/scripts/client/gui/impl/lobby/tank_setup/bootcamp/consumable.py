from gui.impl.lobby.tank_setup.array_providers.consumable import ConsumableDeviceProvider
from gui.impl.lobby.tank_setup.configurations.consumable import ConsumableTabsController, ConsumableTabs
from gui.impl.lobby.tank_setup.sub_views.consumable_setup import ConsumableSetupSubView
from uilogging.deprecated.bootcamp.constants import BC_LOG_KEYS, BC_LOG_ACTIONS
from uilogging.deprecated.bootcamp.loggers import BootcampLogger

class BootcampConsumableDeviceProvider(ConsumableDeviceProvider):

    def _fillStatus(self, model, item, slotID):
        super(BootcampConsumableDeviceProvider, self)._fillStatus(model, item, slotID)
        if not item.isInInventory:
            model.setIsDisabled(True)


class _BootcampConsumableTabsController(ConsumableTabsController):

    def _getAllProviders(self):
        return {ConsumableTabs.DEFAULT: BootcampConsumableDeviceProvider}


class BootcampConsumableSetupSubView(ConsumableSetupSubView):
    uiBootcampLogger = BootcampLogger(BC_LOG_KEYS.BC_CONSUMABLE_SETUP_SUB_VIEW)

    def onLoading(self, currentSlotID, *args, **kwargs):
        self.uiBootcampLogger.log(BC_LOG_ACTIONS.SHOW)
        super(BootcampConsumableSetupSubView, self).onLoading(currentSlotID, *args, **kwargs)
        if any(self._interactor.getCurrentLayout()):
            return
        items = self._provider.getItemsList()
        for item in items:
            if item.isInInventory:
                self._onSelectItem({'intCD': item.intCD, 'isAutoSelect': True})
                break

    def finalize(self):
        if self._currentTabName:
            self.uiBootcampLogger.log(BC_LOG_ACTIONS.CLOSE)
        super(BootcampConsumableSetupSubView, self).finalize()

    def _onSelectItem(self, args):
        self.uiBootcampLogger.log(BC_LOG_ACTIONS.SELECT, item_id=args.get('intCD'))
        super(BootcampConsumableSetupSubView, self)._onSelectItem(args)

    def _createTabsController(self):
        return _BootcampConsumableTabsController()

    def _onDealConfirmed(self, _=None):
        self.uiBootcampLogger.log(BC_LOG_ACTIONS.CONFIRM)
        super(BootcampConsumableSetupSubView, self)._onDealConfirmed(_)