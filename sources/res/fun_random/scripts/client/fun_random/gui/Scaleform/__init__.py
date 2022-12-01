from constants import ARENA_GUI_TYPE, QUEUE_TYPE
from fun_random.gui.Scaleform.daapi.view.lobby.battle_queue import FunRandomQueueProvider
from gui.Scaleform.daapi.settings import config as sf_config
from gui.Scaleform.genConsts.TOOLTIPS_CONSTANTS import TOOLTIPS_CONSTANTS as _TOOLTIPS
from gui.shared.system_factory import registerScaleformLobbyPackages, registerLobbyTooltipsBuilders, registerScaleformBattlePackages, registerBattleQueueProvider

def registerFunRandomScaleform():
    registerScaleformLobbyPackages(('fun_random.gui.Scaleform.daapi.view.lobby', ))
    registerScaleformBattlePackages(ARENA_GUI_TYPE.FUN_RANDOM, sf_config.BATTLE_PACKAGES + ('fun_random.gui.Scaleform.daapi.view.battle', ))
    registerLobbyTooltipsBuilders([
     (
      'fun_random.gui.Scaleform.daapi.view.tooltips.lobby_builders', _TOOLTIPS.FUN_RANDOM_LOBBY_SET)])
    registerBattleQueueProvider(QUEUE_TYPE.FUN_RANDOM, FunRandomQueueProvider)