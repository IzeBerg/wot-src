from gui.Scaleform.daapi.view.lobby.popover.SmartPopOverView import SmartPopOverView

class StorageVehicleSelectPopoverMeta(SmartPopOverView):

    def setVehicleSelected(self, intCD, autoClose):
        self._printOverrideError('setVehicleSelected')

    def applyFilters(self, nation, vehicleType, level, isMain):
        self._printOverrideError('applyFilters')

    def changeSearchNameVehicle(self, inputText):
        self._printOverrideError('changeSearchNameVehicle')

    def as_setInitDataS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_setInitData(data)

    def as_getTableDPS(self):
        if self._isDAAPIInited():
            return self.flashObject.as_getTableDP()

    def as_updateTableSortFieldS(self, sortField, sortDirection):
        if self._isDAAPIInited():
            return self.flashObject.as_updateTableSortField(sortField, sortDirection)

    def as_updateSearchS(self, searchInputLabel, searchInputName, searchInputTooltip, searchInputMaxChars):
        if self._isDAAPIInited():
            return self.flashObject.as_updateSearch(searchInputLabel, searchInputName, searchInputTooltip, searchInputMaxChars)

    def as_showDummyS(self, show):
        if self._isDAAPIInited():
            return self.flashObject.as_showDummy(show)