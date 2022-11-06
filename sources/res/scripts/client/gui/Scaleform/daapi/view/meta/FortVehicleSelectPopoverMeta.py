from gui.Scaleform.daapi.view.lobby.popover.vehicle_select_popover_base import VehicleSelectPopoverBase

class FortVehicleSelectPopoverMeta(VehicleSelectPopoverBase):

    def onFilterChange(self, index, value):
        self._printOverrideError('onFilterChange')