from gui.Scaleform.daapi.view.lobby.storage.inventory.filters.filter_by_type import FiltrableInventoryCategoryByTypeTabView

class StorageCategoryCustomizationViewMeta(FiltrableInventoryCategoryByTypeTabView):

    def navigateToCustomization(self):
        self._printOverrideError('navigateToCustomization')

    def sellCustomizationItem(self, itemCD, vehicleCD):
        self._printOverrideError('sellCustomizationItem')

    def previewItem(self, itemCD, vehicleCD):
        self._printOverrideError('previewItem')