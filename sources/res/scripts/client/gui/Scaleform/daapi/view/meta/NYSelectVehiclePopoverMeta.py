from gui.Scaleform.daapi.view.lobby.popover.SmartPopOverView import SmartPopOverView

class NYSelectVehiclePopoverMeta(SmartPopOverView):

    def onSelectVehicle(self, index):
        self._printOverrideError('onSelectVehicle')

    def applyFilters(self, nation, vehicleType, level):
        self._printOverrideError('applyFilters')

    def as_setInitDataS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_setInitData(data)

    def as_getDPS(self):
        if self._isDAAPIInited():
            return self.flashObject.as_getDP()