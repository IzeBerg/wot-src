from gui.Scaleform.framework.entities.BaseDAAPIComponent import BaseDAAPIComponent

class BasePostmortemPanelMeta(BaseDAAPIComponent):

    def as_setDeadReasonInfoS(self, reason, showVehicle, vehicleLevel, vehicleImg, vehicleType, vehicleName, userVO):
        if self._isDAAPIInited():
            return self.flashObject.as_setDeadReasonInfo(reason, showVehicle, vehicleLevel, vehicleImg, vehicleType, vehicleName, userVO)

    def as_showDeadReasonS(self):
        if self._isDAAPIInited():
            return self.flashObject.as_showDeadReason()

    def as_hideAnyVehDescriptionS(self):
        if self._isDAAPIInited():
            return self.flashObject.as_hideAnyVehDescription()