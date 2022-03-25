from gui.Scaleform.framework.entities.BaseDAAPIComponent import BaseDAAPIComponent

class VehicleMarkersManagerMeta(BaseDAAPIComponent):

    def setFocusVehicle(self, vehicleID):
        self._printOverrideError('setFocusVehicle')

    def as_setMarkerDurationS(self, duration):
        if self._isDAAPIInited():
            return self.flashObject.as_setMarkerDuration(duration)

    def as_setMarkerSettingsS(self, settings):
        if self._isDAAPIInited():
            return self.flashObject.as_setMarkerSettings(settings)

    def as_setShowExInfoFlagS(self, flag):
        if self._isDAAPIInited():
            return self.flashObject.as_setShowExInfoFlag(flag)

    def as_updateMarkersSettingsS(self):
        if self._isDAAPIInited():
            return self.flashObject.as_updateMarkersSettings()

    def as_setColorBlindS(self, isColorBlind):
        if self._isDAAPIInited():
            return self.flashObject.as_setColorBlind(isColorBlind)

    def as_setColorSchemesS(self, defaultSchemes, colorBlindSchemes):
        if self._isDAAPIInited():
            return self.flashObject.as_setColorSchemes(defaultSchemes, colorBlindSchemes)