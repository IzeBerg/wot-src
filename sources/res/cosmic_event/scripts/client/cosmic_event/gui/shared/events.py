from gui.shared.events import HasCtxEvent

class ArtifactScanningEvent(HasCtxEvent):
    VEHICLES_IN_ZONE_CHANGED = 'artifact/vehiclesInZoneChanged'
    ANNOUNCEMENT_CREATED = 'artifact/announced'
    ARTIFACT_SCANNING_READY = 'artifact/scanningReady'
    ARTIFACT_DESTROYED = 'artifact/destroyed'