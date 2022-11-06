from gui.Scaleform.daapi.view.lobby.storage.inventory.inventory_view import RegularInventoryCategoryTabView

class RegularItemsTabViewMeta(RegularInventoryCategoryTabView):

    def navigateToStore(self):
        self._printOverrideError('navigateToStore')

    def sellItem(self, itemId):
        self._printOverrideError('sellItem')

    def upgradeItem(self, itemId):
        self._printOverrideError('upgradeItem')