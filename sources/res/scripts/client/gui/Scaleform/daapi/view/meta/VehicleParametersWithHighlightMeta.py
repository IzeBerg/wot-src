from gui.Scaleform.daapi.view.lobby.hangar.VehicleParameters import VehicleParameters

class VehicleParametersWithHighlightMeta(VehicleParameters):

    def as_showChangesS(self):
        if self._isDAAPIInited():
            return self.flashObject.as_showChanges()