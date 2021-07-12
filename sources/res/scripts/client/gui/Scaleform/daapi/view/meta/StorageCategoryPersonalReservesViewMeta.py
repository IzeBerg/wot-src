from gui.Scaleform.daapi.view.lobby.storage.category_view import BaseCategoryView

class StorageCategoryPersonalReservesViewMeta(BaseCategoryView):

    def navigateToStore(self):
        self._printOverrideError('navigateToStore')

    def activateReserve(self, boosterId):
        self._printOverrideError('activateReserve')

    def resetFilter(self):
        self._printOverrideError('resetFilter')

    def onFiltersChange(self, filters):
        self._printOverrideError('onFiltersChange')

    def as_initS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_init(data)

    def as_initFilterS(self, typeFiltersVO, durationFiltersVO):
        if self._isDAAPIInited():
            return self.flashObject.as_initFilter(typeFiltersVO, durationFiltersVO)

    def as_resetFilterS(self, resetData):
        if self._isDAAPIInited():
            return self.flashObject.as_resetFilter(resetData)

    def as_updateCounterS(self, shouldShow, displayString, isZeroCount):
        if self._isDAAPIInited():
            return self.flashObject.as_updateCounter(shouldShow, displayString, isZeroCount)