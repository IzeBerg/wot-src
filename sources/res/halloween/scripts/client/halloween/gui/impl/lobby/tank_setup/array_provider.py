from gui.impl.lobby.tank_setup.array_providers.consumable import ConsumableDeviceProvider
from gui.shared.utils.requesters import REQ_CRITERIA

class HalloweenConsumableProvider(ConsumableDeviceProvider):

    def _getItemCriteria(self):
        return REQ_CRITERIA.VEHICLE.HAS_TAGS(['hwEquipment']) | ~REQ_CRITERIA.VEHICLE.HAS_TAGS(['hwEmptySlot']) | ~REQ_CRITERIA.HIDDEN