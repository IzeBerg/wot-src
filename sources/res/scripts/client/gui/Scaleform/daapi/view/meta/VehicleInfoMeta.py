from gui.Scaleform.framework.entities.abstract.AbstractWindowView import AbstractWindowView

class VehicleInfoMeta(AbstractWindowView):

    def getVehicleInfo(self):
        self._printOverrideError('getVehicleInfo')

    def onCancelClick(self):
        self._printOverrideError('onCancelClick')

    def addToCompare(self):
        self._printOverrideError('addToCompare')

    def changeNation(self):
        self._printOverrideError('changeNation')

    def as_setVehicleInfoS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_setVehicleInfo(data)

    def as_setCompareButtonDataS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_setCompareButtonData(data)

    def as_setChangeNationButtonDataS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_setChangeNationButtonData(data)