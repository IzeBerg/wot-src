import typing
from gui.impl.lobby.dialogs.auxiliary.confirmed_item import ConfirmedItem
from gui.impl.lobby.dialogs.auxiliary.confirmed_item_to_upgrade import ConfirmedItemToUpgrade
if typing.TYPE_CHECKING:
    from gui.shared.gui_items.fitting_item import FittingItem
    from typing import Iterable, Dict, Callable, Set, Tuple

class ConfirmedItemsPacker(object):

    def __init__(self, **kwargs):
        self._ctx = kwargs

    def packItemsType(self, items, typesToCombine=None):
        if typesToCombine is not None:
            return set(next((typesToCombine[t] for t in typesToCombine if item.itemTypeID in t), item.itemTypeName) for item in items)
        else:
            return set(item.itemTypeName for item in items)

    def packItems(self, items, filterFunc=None, sortFunction=None):
        itemClass = self._getItemClass()
        if callable(sortFunction):
            return sorted([ itemClass.createFromGUIItem(i, self._ctx) for i in items if filterFunc is not None and not filterFunc(i) or filterFunc is None
                          ], cmp=sortFunction)
        else:
            return [ itemClass.createFromGUIItem(i, self._ctx) for i in items if filterFunc is not None and not filterFunc(i) or filterFunc is None
                   ]

    @classmethod
    def _getItemClass(cls):
        return ConfirmedItem


class ConfirmedItemsToUpgradePacker(ConfirmedItemsPacker):

    @classmethod
    def _getItemClass(cls):
        return ConfirmedItemToUpgrade