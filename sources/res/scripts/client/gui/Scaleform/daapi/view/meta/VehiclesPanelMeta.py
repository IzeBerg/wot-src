from gui.Scaleform.framework.entities.BaseDAAPIComponent import BaseDAAPIComponent

class VehiclesPanelMeta(BaseDAAPIComponent):

    def onSelectVehicle(self, vehicleID):
        self._printOverrideError('onSelectVehicle')

    def onSwitchVehicle(self, vehicleID):
        self._printOverrideError('onSwitchVehicle')

    def setVehicleHighlight(self, vehicleID, highlight):
        self._printOverrideError('setVehicleHighlight')

    def onUpdateVehicleOrder(self, orderList):
        self._printOverrideError('onUpdateVehicleOrder')