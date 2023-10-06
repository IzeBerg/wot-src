import plugins
from gui.Scaleform.daapi.view.battle.shared.markers2d.manager import MarkersManager

class BattleRoyaleMarkersManager(MarkersManager):

    def _setupPlugins(self, arenaVisitor):
        setup = super(BattleRoyaleMarkersManager, self)._setupPlugins(arenaVisitor)
        setup['vehicles'] = plugins.BattleRoyaleVehicleMarkerPlugin
        return setup