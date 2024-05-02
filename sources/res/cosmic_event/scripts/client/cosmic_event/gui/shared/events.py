from gui.shared.events import HasCtxEvent
from gui.shared.event_bus import SharedEvent
from gui.shared.events import DeathCamEvent

class FragmentEvent(SharedEvent):
    FRAGMENT_COLLECTED = 'fragment/onCollected'
    FRAGMENT_DROPPED = 'fragment/onDropped'
    FRAGMENT_FULL = 'fragment/onFullCount'


class ZoneEvent(SharedEvent):
    ZONE_CREATED = 'deliveryZone/onZoneCreated'
    ZONE_DESTROYED = 'deliveryZone/onZoneDestroyed'
    ON_FRAGMENTS_DELIVERED = 'deliveryZone/onFragmentsDelivered'
    ON_VEHICLE_ENTER = 'deliveryZone/onVehicleEnter'
    ON_VEHICLE_LEAVE = 'deliveryZone/onVehicleLeave'

    def __init__(self, eventType, zoneEntityId):
        super(ZoneEvent, self).__init__(eventType)
        self.zoneEntityId = zoneEntityId


class ProgressBarEvent(HasCtxEvent):
    PHASE_CHANGED = 'progressBar/phaseChanged'
    PHASE_COUNT_CHANGED = 'progressBar/phaseCountChanged'


class VehicleEvent(SharedEvent):
    VEHICLE_EVACUATED = 'vehicleEvent/vehicleEvacuated'