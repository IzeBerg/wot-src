from gui.Scaleform.framework.entities.abstract.AbstractWindowView import AbstractWindowView

class VehicleListPopupMeta(AbstractWindowView):

    def onSelectVehicles(self, item):
        self._printOverrideError('onSelectVehicles')

    def applyFilters(self, nation, vehicleType):
        self._printOverrideError('applyFilters')

    def as_setListDataS(self, listData, selectedItems):
        if self._isDAAPIInited():
            return self.flashObject.as_setListData(listData, selectedItems)

    def as_setInfoTextS(self, text):
        if self._isDAAPIInited():
            return self.flashObject.as_setInfoText(text)

    def as_setFiltersDataS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_setFiltersData(data)