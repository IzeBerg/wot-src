import logging, plugins
from gui.Scaleform.daapi.view.battle.epic.minimap import EpicMinimapComponent
_logger = logging.getLogger(__name__)

class BattleRoyaleMinimapComponent(EpicMinimapComponent):

    def _setupPlugins(self, arenaVisitor):
        setup = super(BattleRoyaleMinimapComponent, self)._setupPlugins(arenaVisitor)
        setup['personal'] = plugins.BattleRoyalePersonalEntriesPlugin
        setup['deathZones'] = plugins.DeathZonesPlugin
        setup[plugins.RADAR_PLUGIN] = plugins.BattleRoyaleRadarPlugin
        setup['airdrop'] = plugins.AirDropPlugin
        setup[plugins.VEHICLES_PLUGIN] = plugins.BattleRoyaleVehiclePlugin
        setup['pinging'] = plugins.BattleRoyalMinimapPingPlugin
        return setup