from gui.Scaleform.daapi.view.lobby.storage.inventory.filters.filter_by_type import FiltrableInventoryCategoryByTypeTabView

class ItemsWithTypeAndNationFilterTabViewMeta(FiltrableInventoryCategoryByTypeTabView):

    def selectNation(self, id):
        self._printOverrideError('selectNation')

    def as_initNationFilterS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_initNationFilter(data)