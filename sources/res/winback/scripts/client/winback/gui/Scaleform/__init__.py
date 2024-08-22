from gui.Scaleform.genConsts.TOOLTIPS_CONSTANTS import TOOLTIPS_CONSTANTS
from gui.shared.system_factory import registerLobbyTooltipsBuilders

def registerWinbackTooltipsBuilders():
    registerLobbyTooltipsBuilders([
     (
      'winback.gui.Scaleform.daapi.view.tooltips.winback_builders', TOOLTIPS_CONSTANTS.WINBACK_SET)])