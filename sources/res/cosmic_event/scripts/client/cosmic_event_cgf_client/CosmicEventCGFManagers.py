from typing import TYPE_CHECKING
import CGF, GenericComponents, logging
from functools import partial
from cgf_script.managers_registrator import onAddedQuery, onRemovedQuery, autoregister
from cosmic_event_cgf_client.CosmicEventCGFComponents import CosmicFragmentHologram, CosmicRenderTypeComponent
from cosmic_event_common.cgf_components_common.CosmicEventCGFComponents import CosmicDeathAreaTrigger
from cosmic_event_common.cosmic_constants import COSMIC_CGF_CATEGORY
from constants import IS_CLIENT
from cosmic_event import getVehicleFragments
from FragmentManager import FragmentManager
from gui.shared.utils.graphics import isRendererPipelineDeferred
from helpers.CallbackDelayer import CallbackDelayer
from helpers import time_utils
if IS_CLIENT:
    from Vehicle import Vehicle
else:

    class Vehicle(object):
        pass


if TYPE_CHECKING:
    from typing import Any, Set
    from typing import Optional
_logger = logging.getLogger(__name__)

def getVehicleFromGO(spaceID, gameObject):
    hierarchyManager = CGF.HierarchyManager(spaceID)
    if not hierarchyManager:
        return
    else:
        rootGameObject = hierarchyManager.getTopMostParent(gameObject)
        vehicleEntity = rootGameObject.findComponentByType(Vehicle)
        return vehicleEntity or None


@autoregister(presentInAllWorlds=True, category=COSMIC_CGF_CATEGORY, domain=CGF.DomainOption.DomainClient)
class CosmicDeathTriggerManager(CGF.ComponentManager):

    @onAddedQuery(CGF.GameObject, CosmicDeathAreaTrigger)
    def onAdded(self, gameObject, cosmicTrigger):
        arenaTrigger = cosmicTrigger.trigger()
        if not arenaTrigger:
            _logger.error('Failed to setup CosmicDeathAreaTrigger on game object name=%s, id=%s', gameObject.name, gameObject.id)
            return
        cosmicTrigger.reactionID = arenaTrigger.addEnterReaction(self.__onEnter)
        _logger.debug('Create CosmicDeathAreaTrigger on game object name=%s, id=%s', gameObject.name, gameObject.id)

    @onRemovedQuery(CGF.GameObject, CosmicDeathAreaTrigger)
    def onRemoved(self, gameObject, cosmicTrigger):
        arenaTrigger = cosmicTrigger.trigger()
        if arenaTrigger and cosmicTrigger.reactionID is not None:
            arenaTrigger.removeEnterReaction(cosmicTrigger.reactionID)
            _logger.debug('Remove CosmicDeathAreaTrigger on game object name=%s, id=%s', gameObject.name, gameObject.id)
        return

    def __onEnter(self, gameObject, *args, **kwargs):
        vehicle = getVehicleFromGO(self.spaceID, gameObject)
        if not vehicle:
            _logger.warning('Cannot find a vehicle from GameObject (spaceID=%s)', self.spaceID)
            return
        else:
            evacVFX = vehicle.dynamicComponents.get('vehicleEvacPhaseEffects', None)
            if evacVFX:
                evacVFX.deactivateEffects()
            deathEffectComp = vehicle.dynamicComponents.get('CosmicDeathEffectComponent', None)
            if not deathEffectComp:
                _logger.warning('Cannot find a CosmicDeathEffectComponent on vehicle (vehicleId=%s, spaceID=%s)', vehicle.id, self.spaceID)
                return
            deathEffectComp.showDespawnEffect()
            return


@autoregister(presentInAllWorlds=True, category=COSMIC_CGF_CATEGORY, domain=CGF.DomainOption.DomainClient)
class CosmicFragmentHologramManager(CGF.ComponentManager):

    def __init__(self, *args):
        super(CosmicFragmentHologramManager, self).__init__(*args)
        self.__callbackDelayer = CallbackDelayer()
        self._fragManager = None
        return

    @onAddedQuery(CGF.GameObject, CosmicFragmentHologram)
    def onAddedCosmicHoloComponent(self, gameObject, cosmicHolo):
        _logger.debug('Create CosmicFragmentHologram on GameObject name=%s, id=%s (spaceId=%s)', gameObject.name, gameObject.id, self.spaceID)
        self.__callbackDelayer.delayCallback(time_utils.ONE_SECOND, partial(self.__onSecondCallback, cosmicHolo, gameObject))
        if self._fragManager:
            self.__onFragmentsUpdate(gameObject, self._fragManager.getVehiclesWithFragments())

    @onAddedQuery(CGF.GameObject, FragmentManager)
    def onAddedFragmentManager(self, gameObject, fragmentManager):
        _logger.debug('Create FragmentManager on GameObject name=%s, id=%s (spaceId=%s)', gameObject.name, gameObject.id, self.spaceID)
        self._fragManager = fragmentManager

    @onRemovedQuery(CGF.GameObject, CosmicFragmentHologram)
    def onRemovedCosmicHoloComponent(self, gameObject, cosmicHolo):
        _logger.debug('Remove CosmicFragmentHologram on GameObject name=%s, id=%s (spaceID=%s)', gameObject.name, gameObject.id, self.spaceID)
        self.__callbackDelayer.clearCallbacks()
        if self._fragManager:
            self._fragManager.onFragmentsUpdate -= cosmicHolo.partialFunc

    @onRemovedQuery(CGF.GameObject, FragmentManager)
    def onRemovedFragmentManager(self, gameObject, fragmentManager):
        _logger.debug('Remove FragmentManager on GameObject name=%s, id=%s (spaceID=%s)', gameObject.name, gameObject.id, self.spaceID)
        self._fragManager = None
        return

    def __onFragmentsUpdate(self, gameObject, vehicleIDs):
        vehicle = getVehicleFromGO(self.spaceID, gameObject)
        if vehicle is not None:
            if vehicle.isPlayerVehicle and vehicle.id in vehicleIDs:
                animator = gameObject.findComponentByType(GenericComponents.AnimatorComponent)
                fragmentsTotal = getVehicleFragments(vehicle.id)
                if fragmentsTotal:
                    for i in range(0, fragmentsTotal):
                        animator.startLayerByIndex(i)

                else:
                    animator.stop()
        return

    def __onSecondCallback(self, comp, gameObject):
        if self._fragManager is None:
            return time_utils.ONE_SECOND
        else:
            self.__subscribeListeners(comp, gameObject)
            return

    def __subscribeListeners(self, comp, gameObject):
        comp.partialFunc = partial(self.__onFragmentsUpdate, gameObject)
        self._fragManager.onFragmentsUpdate += comp.partialFunc


@autoregister(presentInAllWorlds=True, category=COSMIC_CGF_CATEGORY, domain=CGF.DomainOption.DomainClient)
class CosmicRenderTypeManager(CGF.ComponentManager):

    @onAddedQuery(CGF.GameObject, CosmicRenderTypeComponent)
    def onPrefabAdded(self, gameObject, deferredRenderComponent):
        isDeferredRender = isRendererPipelineDeferred()
        if isDeferredRender and not deferredRenderComponent.showInDeferred:
            _logger.debug('A prefab with name=%s with CosmicRenderTypeComponent disabled in deferred mode, it will be removed', gameObject.name)
            gameObject.deactivate()
        elif not isDeferredRender and not deferredRenderComponent.showInForward:
            _logger.debug('A prefab with name=%s with CosmicRenderTypeComponent disabled in forward mode, it will be removed', gameObject.name)
            gameObject.deactivate()