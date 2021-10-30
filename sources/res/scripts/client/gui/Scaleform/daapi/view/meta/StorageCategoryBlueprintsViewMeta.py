from gui.Scaleform.daapi.view.lobby.storage.vehicle_view import VehicleView

class StorageCategoryBlueprintsViewMeta(VehicleView):

    def navigateToBlueprintScreen(self, itemId):
        self._printOverrideError('navigateToBlueprintScreen')

    def selectConvertible(self, value):
        self._printOverrideError('selectConvertible')

    def as_updateIntelligenceDataS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_updateIntelligenceData(data)

    def as_updateNationalFragmentsS(self, fragments):
        if self._isDAAPIInited():
            return self.flashObject.as_updateNationalFragments(fragments)

    def as_updateCanConvertS(self, value):
        if self._isDAAPIInited():
            return self.flashObject.as_updateCanConvert(value)