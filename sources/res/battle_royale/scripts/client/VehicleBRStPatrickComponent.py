import BigWorld
from script_component.DynamicScriptComponent import DynamicScriptComponent
import Event
from debug_utils import LOG_DEBUG

class VehicleBRStPatrickComponent(DynamicScriptComponent):
    onCoinsAdded = Event.Event()

    def set_coinsCount(self, prev):
        LOG_DEBUG('VehicleBRStPatrickComponent.set_coinsCount prev', prev, 'coinsCount', self.coinsCount)
        if self.__observedVehicleMatches():
            self.onCoinsAdded(self.coinsCount - prev, self.totalCoins, False)

    def set_teammateCoinsCount(self, prev):
        LOG_DEBUG('VehicleBRStPatrickComponent.set_teammateCoinsCount prev', prev, 'teammateCoinsCount', self.teammateCoinsCount)
        if self.__observedVehicleMatches():
            self.onCoinsAdded(self.teammateCoinsCount - prev, self.totalCoins, True)

    @property
    def totalCoins(self):
        return self.coinsCount + self.teammateCoinsCount

    def __observedVehicleMatches(self):
        attachedVehicle = BigWorld.player().getVehicleAttached()
        if attachedVehicle:
            return attachedVehicle.id == self.entity.id
        return False