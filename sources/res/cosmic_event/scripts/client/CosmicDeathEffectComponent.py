import logging, BigWorld
from typing import TYPE_CHECKING
from script_component.DynamicScriptComponent import DynamicScriptComponent
from cosmic_event_common.cosmic_constants import VEHICLE_TELEPORTATION_TIMEOUT
from CosmicRespawnEffectsComponent import CosmicRespawnEffect
if TYPE_CHECKING:
    from typing import Optional
_logger = logging.getLogger(__name__)

class CosmicDeathEffectComponent(DynamicScriptComponent):

    def __init__(self, *_, **__):
        super(CosmicDeathEffectComponent, self).__init__(*_, **__)
        self._despawnEffect = None
        self._despawnEffectPrefab = None
        self.__stopVisualCallbackId = None
        _logger.debug('%s: init entity[%s]', self.__class__.__name__, self.entity.id)
        return

    def onDestroy(self):
        if self.__stopVisualCallbackId is not None:
            BigWorld.cancelCallback(self.__stopVisualCallbackId)
            self.__stopVisualCallbackId = None
        if self._despawnEffect:
            self._despawnEffect.clear()
        super(CosmicDeathEffectComponent, self).onDestroy()
        return

    def __stopVehicleVisual(self):
        self.__stopVisualCallbackId = None
        self.entity.stopVisual()
        return

    def showDespawnEffect(self):
        _logger.debug('[CosmicDeathEffectComponent] Showing despawn effect on entity [%s], prefab[%s]', self.entity.id, self.despawnEffectPrefab)
        if self.__stopVisualCallbackId is not None:
            return
        else:
            if not self._despawnEffect:
                self._despawnEffect = CosmicRespawnEffect(self.entity, self.despawnEffectPrefab)
            self.__stopVisualCallbackId = BigWorld.callback(VEHICLE_TELEPORTATION_TIMEOUT, self.__stopVehicleVisual)
            self._despawnEffect.activateEffect()
            return