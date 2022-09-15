from PoiBaseComponent import PoiBaseComponent
from points_of_interest.components import PoiVehicleStateComponent

class PoiVehicleComponent(PoiBaseComponent):

    def onDestroy(self):
        self._poiGameObject.removeComponentByType(PoiVehicleStateComponent)
        super(PoiVehicleComponent, self).onDestroy()

    def _onAvatarReady(self):
        self._poiGameObject.createComponent(PoiVehicleStateComponent, self.pointID)