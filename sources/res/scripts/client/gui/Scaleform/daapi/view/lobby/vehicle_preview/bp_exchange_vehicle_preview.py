from gui.Scaleform.daapi.view.lobby.vehicle_preview.style_preview import VehicleStylePreview

class BlueprintsExchangeVehicleStypePreview(VehicleStylePreview):

    def onBackClick(self):
        self.closeView()
        super(BlueprintsExchangeVehicleStypePreview, self).onBackClick()