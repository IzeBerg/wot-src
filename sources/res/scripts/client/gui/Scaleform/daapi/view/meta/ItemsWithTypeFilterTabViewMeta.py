from gui.Scaleform.daapi.view.lobby.storage.inventory.inventory_view import InventoryCategoryView

class ItemsWithTypeFilterTabViewMeta(InventoryCategoryView):

    def sellItem(self, itemId):
        self._printOverrideError('sellItem')

    def resetFilter(self):
        self._printOverrideError('resetFilter')

    def onFiltersChange(self, filters):
        self._printOverrideError('onFiltersChange')

    def navigateToStore(self):
        self._printOverrideError('navigateToStore')

    def upgradeItem(self, itemId):
        self._printOverrideError('upgradeItem')

    def as_initTypeFilterS(self, typeFiltersVO):
        if self._isDAAPIInited():
            return self.flashObject.as_initTypeFilter(typeFiltersVO)

    def as_resetFilterS(self, resetData):
        if self._isDAAPIInited():
            return self.flashObject.as_resetFilter(resetData)

    def as_updateCounterS(self, shouldShow, displayString, isZeroCount):
        if self._isDAAPIInited():
            return self.flashObject.as_updateCounter(shouldShow, displayString, isZeroCount)