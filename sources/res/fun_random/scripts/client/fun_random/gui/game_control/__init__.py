from fun_random.gui.game_control.awards_controller import FunProgressionQuestsHandler
from fun_random.gui.game_control.fun_random_controller import FunRandomController
from skeletons.gui.game_control import IFunRandomController
from gui.shared.system_factory import registerGameControllers, registerAwardControllerHandler

def registerFunRandomGameControllers():
    registerGameControllers(((IFunRandomController, FunRandomController, True),))
    registerAwardControllerHandler(FunProgressionQuestsHandler)