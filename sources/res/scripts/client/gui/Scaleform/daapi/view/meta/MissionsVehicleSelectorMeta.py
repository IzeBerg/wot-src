from gui.Scaleform.framework.entities.BaseDAAPIComponent import BaseDAAPIComponent

class MissionsVehicleSelectorMeta(BaseDAAPIComponent):

    def as_setInitDataS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_setInitData(data)

    def as_showSelectedVehicleS(self, vehData):
        if self._isDAAPIInited():
            return self.flashObject.as_showSelectedVehicle(vehData)

    def as_hideSelectedVehicleS(self):
        if self._isDAAPIInited():
            return self.flashObject.as_hideSelectedVehicle()

    def as_closeS(self):
        if self._isDAAPIInited():
            return self.flashObject.as_close()