from gui.Scaleform.daapi.view.lobby.storage.vehicle_view import VehicleView

class AllVehiclesTabViewMeta(VehicleView):

    def navigateToStore(self):
        self._printOverrideError('navigateToStore')

    def sellItem(self, itemId):
        self._printOverrideError('sellItem')