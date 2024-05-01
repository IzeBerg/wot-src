import CGF, Math, BigWorld
from script_component.DynamicScriptComponent import DynamicScriptComponent
from typing import TYPE_CHECKING
from cosmic_event_common.cosmic_constants import VEHICLE_TELEPORTATION_TIMEOUT
import cosmic_prefabs
if TYPE_CHECKING:
    from typing import Optional

class VehicleEvacPhaseEffects(DynamicScriptComponent):

    def __init__(self):
        super(VehicleEvacPhaseEffects, self).__init__()
        self.__sparksEffectGO = None
        return

    def _onAvatarReady(self):
        position = Math.Vector3(0, 1, 0)
        CGF.loadGameObjectIntoHierarchy(cosmic_prefabs.Vehicle.ELECTRICITY_EFFECT, self.entity.entityGameObject, position, self.__onLoaded)

    def __onLoaded(self, gameObject):
        if self.entity.isDestroyed:
            CGF.removeGameObject(gameObject)
            return
        self.__sparksEffectGO = gameObject
        if not self.entity.isAlive():
            self.deactivateEffects()

    def activateEffects(self):
        if self.__sparksEffectGO:
            self.__sparksEffectGO.activate()

    def deactivateEffects(self):
        if self.__sparksEffectGO:
            self.__sparksEffectGO.deactivate()

    def showEffectsOnRespawn(self):
        BigWorld.callback(VEHICLE_TELEPORTATION_TIMEOUT, self.activateEffects)

    def onDestroy(self):
        self.deactivateEffects()
        if self.__sparksEffectGO and self.__sparksEffectGO.isValid():
            CGF.removeGameObject(self.__sparksEffectGO)
        self.__sparksEffectGO = None
        return