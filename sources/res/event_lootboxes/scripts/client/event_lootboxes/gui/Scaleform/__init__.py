from gui.Scaleform.genConsts.TOOLTIPS_CONSTANTS import TOOLTIPS_CONSTANTS
from gui.shared.system_factory import registerLobbyTooltipsBuilders

def registerLootboxesTooltipsBuilders():
    registerLobbyTooltipsBuilders([
     (
      'event_lootboxes.gui.Scaleform.daapi.view.tooltips.lobby_builders', TOOLTIPS_CONSTANTS.EVLB_LOBBY_SET)])