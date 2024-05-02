import logging
from typing import TYPE_CHECKING
import functools, CGF, Math, BigWorld
from script_component.DynamicScriptComponent import DynamicScriptComponent
from vehicle_systems import model_assembler
from cosmic_event_common.cosmic_constants import VEHICLE_TELEPORTATION_TIMEOUT
if TYPE_CHECKING:
    from Vehicle import Vehicle
    from GameObject import GameObject
    from typing import Dict, Optional
_logger = logging.getLogger(__name__)

class CosmicRespawnEffect(object):

    def __init__(self, vehicle, prefab):
        self._gameObject = None
        self._vehicle = vehicle
        self._prefab = prefab
        return

    def loadEffect(self):
        _logger.debug('CosmicRespawnEffect: loading visuals for Vehicle id=%s', self._vehicle)
        CGF.loadGameObjectIntoHierarchy(self._prefab, self._vehicle.entityGameObject, Math.Vector3(), self._prefabLoaded)

    def activateEffect(self):
        if self._gameObject is None:
            self.loadEffect()
        else:
            _logger.debug('CosmicRespawnEffect: activating gameObject: %s', self._gameObject)
            self.__activateGameObject()
        return

    def clear(self):
        if self._gameObject is not None:
            _logger.debug('CosmicRespawnEffect: clearing gameObject: %s', self._gameObject)
            CGF.removeGameObject(self._gameObject)
        self._gameObject = None
        return

    def _prefabLoaded(self, gameObject):
        _logger.debug('CosmicRespawnEffect: prefabLoaded')
        self._gameObject = gameObject
        self.__activateGameObject()

    def __activateGameObject(self):
        if self._gameObject:
            self._gameObject.deactivate()
            self._gameObject.activate()


class CosmicRespawnEffectsComponent(DynamicScriptComponent):

    def __init__(self, *_, **__):
        super(CosmicRespawnEffectsComponent, self).__init__(*_, **__)
        self._spawnEffectCache = {}
        self._spawnEffectPrefab = None
        BigWorld.player().onVehicleEnterWorld += self.showSpawnEffect
        _logger.debug('%s: init entity[%s]', self.__class__.__name__, self.entity.id)
        return

    def onDestroy(self):
        for spawnEffect in self._spawnEffectCache.itervalues():
            spawnEffect.clear()

        BigWorld.player().onVehicleEnterWorld -= self.showSpawnEffect
        super(CosmicRespawnEffectsComponent, self).onDestroy()

    def showSpawnEffect(self, vehicle):
        _logger.debug('[CosmicRespawnEffectsComponent] Showing spawn effect on entity:[%s], prefab:[%s]', vehicle.id, self.spawnEffectPrefab)
        if vehicle.id not in self._spawnEffectCache:
            self._spawnEffectCache[vehicle.id] = CosmicRespawnEffect(vehicle, self.spawnEffectPrefab)
        if vehicle.isPlayerVehicle:
            vehicle.removeEdge()
        vehicle.appearance.compoundModel.matrix = Math.Matrix()
        BigWorld.callback(VEHICLE_TELEPORTATION_TIMEOUT, functools.partial(self.linkVehicleAppearance, vehicle))
        self._spawnEffectCache[vehicle.id].activateEffect()

    @staticmethod
    def linkVehicleAppearance(vehicle):
        vehicle.appearance.compoundModel.matrix = vehicle.matrix
        appearance = vehicle.appearance
        model_assembler.assembleCustomLogicComponents(appearance, appearance.typeDescriptor, [], [])
        if vehicle.isPlayerVehicle:
            vehicle.drawEdge()