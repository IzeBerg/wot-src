from gui.Scaleform.genConsts.TOOLTIPS_CONSTANTS import TOOLTIPS_CONSTANTS
from gui.shared.system_factory import registerScaleformLobbyPackages, registerLobbyTooltipsBuilders

def registerArmoryYardScaleform():
    registerScaleformLobbyPackages(('armory_yard.gui.Scaleform.daapi.view.lobby', ))


def registerArmoryYardTooltipsBuilders():
    registerLobbyTooltipsBuilders([
     (
      'armory_yard.gui.Scaleform.daapi.view.tooltips.lobby_builders',
      TOOLTIPS_CONSTANTS.ARMORY_YARD_LOBBY_SET)])