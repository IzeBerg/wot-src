from gui.Scaleform.framework.entities.abstract.AbstractWindowView import AbstractWindowView

class EliteWindowMeta(AbstractWindowView):

    def as_setVehicleS(self, vehicle):
        if self._isDAAPIInited():
            return self.flashObject.as_setVehicle(vehicle)