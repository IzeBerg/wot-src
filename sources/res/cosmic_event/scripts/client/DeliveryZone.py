import logging
from typing import TYPE_CHECKING
import BigWorld, CGF, Math, cosmic_prefabs
from EmptyEntity import EmptyEntity
from cosmic_event_common.cosmic_constants import PhaseTypes
from cosmic_event.skeletons.battle_controller import ICosmicEventBattleController
from helpers import dependency
from gui.shared import g_eventBus, EVENT_BUS_SCOPE
from cosmic_event.gui.shared.events import ZoneEvent
from cosmic_event import getGamePhaseComponent
_logger = logging.getLogger(__name__)
if TYPE_CHECKING:
    from typing import List
    from gui.shared.event_bus import SharedEvent

class DeliveryZone(EmptyEntity):
    __cosmicController = dependency.descriptor(ICosmicEventBattleController)

    def onEnterWorld(self, *_):
        self._loadZonePrefabs()
        self._sendEvent(ZoneEvent.ZONE_CREATED)

    def onLeaveWorld(self):
        self._sendEvent(ZoneEvent.ZONE_DESTROYED)

    def onFragmentsDelivered(self, vehicleId):
        vehicle = BigWorld.entities.get(vehicleId, None)
        if vehicle:
            CGF.loadGameObjectIntoHierarchy(cosmic_prefabs.Fragment.FRAGMENT_DELIVERED, vehicle.entityGameObject, Math.Vector3())
            if vehicle.isPlayerVehicle:
                self._sendEvent(ZoneEvent.ON_FRAGMENTS_DELIVERED)
        else:
            _logger.error('Cant find vehicle with id=%s', vehicleId)
        return

    def onVehicleEnter(self, vehicleID):
        if self._isEvacuationPhase:
            attachedVehicle = BigWorld.player().getVehicleAttached()
            if attachedVehicle and attachedVehicle.id == vehicleID:
                self._sendEvent(ZoneEvent.ON_VEHICLE_ENTER)

    def onVehicleLeave(self, vehicleID):
        if self._isEvacuationPhase:
            attachedVehicle = BigWorld.player().getVehicleAttached()
            if attachedVehicle and attachedVehicle.id == vehicleID:
                self._sendEvent(ZoneEvent.ON_VEHICLE_LEAVE)

    @property
    def _isEvacuationPhase(self):
        gamePhaseComponent = getGamePhaseComponent()
        return gamePhaseComponent.phaseType == PhaseTypes.EVACUATION

    def _loadZonePrefabs(self):
        modeSettings = self.__cosmicController.getModeSettings()
        zone = modeSettings.zonesConfig.getZoneByName(self.zoneTypeName)
        if zone is None:
            _logger.error('Cant find zone in mode settings with name=%s', self.zoneTypeName)
            return
        else:
            for prefab in zone.prefabs:
                _logger.debug('Delivery zone: spawn new prefab %s', prefab)
                CGF.loadGameObjectIntoHierarchy(prefab, self.entityGameObject, Math.Vector3())

            return

    def _sendEvent(self, event):
        g_eventBus.handleEvent(ZoneEvent(event, self.id), scope=EVENT_BUS_SCOPE.BATTLE)