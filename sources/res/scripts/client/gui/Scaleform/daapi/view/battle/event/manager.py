from gui.Scaleform.daapi.view.battle.shared.markers2d import MarkersManager
from gui.Scaleform.daapi.view.battle.event.plugins import EventVehicleMarkerPlugin
from gui.Scaleform.daapi.view.battle.event.plugins import EventEventBusPlugin
from gui.Scaleform.daapi.view.battle.event.plugins import EventBaseAreaMarkerPlugin

class EventMarkersManager(MarkersManager):

    def _setupPlugins(self, arenaVisitor):
        setup = super(EventMarkersManager, self)._setupPlugins(arenaVisitor)
        setup['vehicles'] = EventVehicleMarkerPlugin
        setup['eventBus'] = EventEventBusPlugin
        setup['area_markers'] = EventBaseAreaMarkerPlugin
        return setup