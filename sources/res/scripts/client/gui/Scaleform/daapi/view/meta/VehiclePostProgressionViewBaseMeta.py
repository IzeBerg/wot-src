from gui.Scaleform.framework.entities.View import View

class VehiclePostProgressionViewBaseMeta(View):

    def demountAllPairs(self):
        self._printOverrideError('demountAllPairs')

    def as_setVehicleTitleS(self, vo):
        if self._isDAAPIInited():
            return self.flashObject.as_setVehicleTitle(vo)

    def as_setDataS(self, vo):
        if self._isDAAPIInited():
            return self.flashObject.as_setData(vo)

    def as_showS(self):
        if self._isDAAPIInited():
            return self.flashObject.as_show()

    def as_onEscPressedS(self):
        if self._isDAAPIInited():
            return self.flashObject.as_onEscPressed()