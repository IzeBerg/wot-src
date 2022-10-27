from gui.impl.gen.view_models.constants.item_highlight_types import ItemHighlightTypes
from gui.impl.gen.view_models.views.lobby.tank_setup.sub_views.consumable_slot_model import ConsumableSlotModel
from gui.impl.lobby.tank_setup.array_providers.base import VehicleBaseArrayProvider
from gui.shared.gui_items import GUI_ITEM_TYPE
from gui.shared.utils.requesters import REQ_CRITERIA

class HalloweenConsumableProvider(VehicleBaseArrayProvider):
    __slots__ = ()

    def getItemViewModel(self):
        return ConsumableSlotModel()

    def createSlot(self, item, ctx):
        model = super(HalloweenConsumableProvider, self).createSlot(item, ctx)
        model.setImageName(item.descriptor.iconName)
        model.setItemName(item.name)
        model.setDescription(item.shortDescription)
        model.setIsBuiltIn(False)
        isEnough = item.mayPurchaseWithExchange(self._itemsCache.items.stats.money, self._itemsCache.items.shop.exchangeRate)
        model.setIsBuyMoreDisabled(not isEnough)
        self._fillHighlights(model, item)
        self._fillBuyPrice(model, item)
        return model

    def updateSlot(self, model, item, ctx):
        super(HalloweenConsumableProvider, self).updateSlot(model, item, ctx)
        isInstalledOrMounted = item in self._getCurrentLayout() or item in self._getInstalledLayout()
        self._fillStatus(model, item, ctx.slotID)
        self._fillBuyStatus(model, item, isInstalledOrMounted)

    def _fillHighlights(self, model, item):
        if item.isBuiltIn:
            model.setOverlayType(ItemHighlightTypes.BUILT_IN_EQUIPMENT)
            model.setHighlightType(ItemHighlightTypes.BUILT_IN_EQUIPMENT)

    def _mayInstall(self, item, slotID=None):
        return (True, '')

    @classmethod
    def _getItemTypeID(cls):
        return (GUI_ITEM_TYPE.EQUIPMENT,)

    def _getItemCriteria(self):
        return REQ_CRITERIA.VEHICLE.HAS_TAGS(['halloween_equipment']) | ~REQ_CRITERIA.VEHICLE.HAS_TAGS(['empty_slot'])

    def _getEquipment(self):
        return self._getVehicle().consumables