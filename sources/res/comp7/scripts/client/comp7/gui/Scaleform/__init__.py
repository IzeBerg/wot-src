from gui.Scaleform.genConsts.TOOLTIPS_CONSTANTS import TOOLTIPS_CONSTANTS
from gui.shared.system_factory import registerScaleformLobbyPackages, registerLobbyTooltipsBuilders

def registerComp7Scaleform():
    registerScaleformLobbyPackages(('comp7.gui.Scaleform.daapi.view.lobby', ))


def registerComp7TooltipsBuilders():
    registerLobbyTooltipsBuilders([
     (
      'comp7.gui.Scaleform.daapi.view.tooltips.lobby_builders',
      [
       TOOLTIPS_CONSTANTS.COMP7_VEHICLE_PARAMS_TOOLTIP])])