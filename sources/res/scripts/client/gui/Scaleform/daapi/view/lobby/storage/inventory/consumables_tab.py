from gui.Scaleform.daapi.view.lobby.store.browser.shop_helpers import getBuyEquipmentUrl
from gui.Scaleform.daapi.view.lobby.storage.inventory.filters.filter_by_type import FiltrableRegularCategoryByTypeTabView
from gui.impl.gen import R
from gui.shared.event_dispatcher import showShop
from gui.shared.gui_items import GUI_ITEM_TYPE
from gui.shared.utils.requesters import REQ_CRITERIA
from shared_utils import CONST_CONTAINER

class _ConsumableFilterBit(CONST_CONTAINER):
    CONSUMABLES = 1
    BATTLE_BOOSTERS = 2
    DEMOUNT_KITS = 4
    RECERTIFICATION_FORMS = 8


_TYPE_FILTER_ITEMS = [
 {'filterValue': _ConsumableFilterBit.CONSUMABLES, 
    'selected': False, 
    'tooltip': R.strings.storage.inventory.filterType.consumables, 
    'icon': R.images.gui.maps.icons.storage.filters.icon_button_consumables},
 {'filterValue': _ConsumableFilterBit.BATTLE_BOOSTERS, 
    'selected': False, 
    'tooltip': R.strings.storage.inventory.filterType.instructions, 
    'icon': R.images.gui.maps.icons.storage.filters.icon_button_instructions},
 {'filterValue': _ConsumableFilterBit.DEMOUNT_KITS | _ConsumableFilterBit.RECERTIFICATION_FORMS, 
    'selected': False, 
    'tooltip': R.strings.storage.inventory.filterType.other, 
    'icon': R.images.gui.maps.icons.storage.filters.icon_button_other}]
_TYPE_ID_BIT_TO_TYPE_ID_MAP = {_ConsumableFilterBit.CONSUMABLES: (
                                    GUI_ITEM_TYPE.EQUIPMENT,), 
   _ConsumableFilterBit.BATTLE_BOOSTERS: (
                                        GUI_ITEM_TYPE.BATTLE_BOOSTER,), 
   _ConsumableFilterBit.DEMOUNT_KITS: (
                                     GUI_ITEM_TYPE.DEMOUNT_KIT,), 
   _ConsumableFilterBit.RECERTIFICATION_FORMS: (
                                              GUI_ITEM_TYPE.RECERTIFICATION_FORM,)}

class ConsumablesTabView(FiltrableRegularCategoryByTypeTabView):
    filterItems = _TYPE_FILTER_ITEMS

    def navigateToStore(self):
        showShop(getBuyEquipmentUrl())

    def _getItemTypeID(self):
        return (
         GUI_ITEM_TYPE.EQUIPMENT,
         GUI_ITEM_TYPE.BATTLE_BOOSTER,
         GUI_ITEM_TYPE.DEMOUNT_KIT,
         GUI_ITEM_TYPE.RECERTIFICATION_FORM)

    def _getClientSectionKey(self):
        return 'storage_consumables_tab'

    def _getFilteredCriteria(self):
        criteria = super(ConsumablesTabView, self)._getFilteredCriteria()
        typeIds = list()
        for bit in _TYPE_ID_BIT_TO_TYPE_ID_MAP.iterkeys():
            if self._filterMask & bit:
                typeIds.extend(_TYPE_ID_BIT_TO_TYPE_ID_MAP[bit])

        if typeIds:
            criteria |= REQ_CRITERIA.ITEM_TYPES(*set(typeIds))
        return criteria

    def _getRequestCriteria(self, invVehicles):
        criteria = REQ_CRITERIA.INVENTORY
        return criteria