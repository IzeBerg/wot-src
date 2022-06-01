from gui.Scaleform.daapi.view.battle.shared.markers2d import MarkersManager
from gui.Scaleform.daapi.view.battle.stronghold.plugins import StrongholdVehicleMarkerPlugin

class StrongholdMarkersManager(MarkersManager):

    def _setupPlugins(self, arenaVisitor):
        setup = super(StrongholdMarkersManager, self)._setupPlugins(arenaVisitor)
        setup['vehicles'] = StrongholdVehicleMarkerPlugin
        return setup