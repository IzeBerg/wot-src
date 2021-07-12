from gui.Scaleform.daapi.view.meta.VehicleCompareCommonViewMeta import VehicleCompareCommonViewMeta

class VehicleCompareViewMeta(VehicleCompareCommonViewMeta):

    def onBackClick(self):
        self._printOverrideError('onBackClick')

    def onGoToPreviewClick(self, index):
        self._printOverrideError('onGoToPreviewClick')

    def onGoToHangarClick(self, vehicleID):
        self._printOverrideError('onGoToHangarClick')

    def onSelectModulesClick(self, vehicleID, index):
        self._printOverrideError('onSelectModulesClick')

    def onParamDeltaRequested(self, index, paramID):
        self._printOverrideError('onParamDeltaRequested')

    def onCrewLevelChanged(self, index, crewLevelID):
        self._printOverrideError('onCrewLevelChanged')

    def onRemoveVehicle(self, index):
        self._printOverrideError('onRemoveVehicle')

    def onRevertVehicle(self, index):
        self._printOverrideError('onRevertVehicle')

    def onRemoveAllVehicles(self):
        self._printOverrideError('onRemoveAllVehicles')

    def as_setStaticDataS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_setStaticData(data)

    def as_setParamsDeltaS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_setParamsDelta(data)

    def as_setVehicleParamsDataS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_setVehicleParamsData(data)

    def as_getVehiclesDPS(self):
        if self._isDAAPIInited():
            return self.flashObject.as_getVehiclesDP()

    def as_setVehiclesCountTextS(self, text):
        if self._isDAAPIInited():
            return self.flashObject.as_setVehiclesCountText(text)