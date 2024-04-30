import BigWorld, Event

class HBAttackDirectionMarkerComponent(BigWorld.DynamicScriptComponent):
    onMarkersUpdated = Event.Event()

    def set_markers(self, _):
        self.onMarkersUpdated(self.markers)