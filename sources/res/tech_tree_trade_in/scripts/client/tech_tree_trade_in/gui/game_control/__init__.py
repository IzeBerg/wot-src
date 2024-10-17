from gui.shared.system_factory import registerGameControllers
from tech_tree_trade_in.skeletons.gui.game_control import ITechTreeTradeInController
from tech_tree_trade_in.gui.game_control.tech_tree_trade_in_controller import TechTreeTradeInController

def registerTradeInController():
    registerGameControllers([
     (
      ITechTreeTradeInController, TechTreeTradeInController, False)])