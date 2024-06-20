from helpers import dependency
from skeletons.gui.game_control import IBattleRoyaleController
from constants import GameSeasonType
from gui.shared.system_factory import registerSeasonProviderHandler

def registerBRSeasonProviderHandler():
    registerSeasonProviderHandler(GameSeasonType.BATTLE_ROYALE, lambda *args, **kwargs: dependency.instance(IBattleRoyaleController))