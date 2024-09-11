from armory_yard.gui.game_control.armory_yard_controller import ArmoryYardController
from armory_yard.gui.game_control.armory_yard_shop_controller import ArmoryYardShopController
from armory_yard.gui.game_control.awards_controller import ArmoryYardStyleQuestsHandler
from skeletons.gui.game_control import IArmoryYardController, IArmoryYardShopController
from gui.shared.system_factory import registerGameControllers, registerAwardControllerHandler

def registerAYGameControllers():
    registerGameControllers([
     (
      IArmoryYardController, ArmoryYardController, False)])


def registerAYAwardControllers():
    registerAwardControllerHandler(ArmoryYardStyleQuestsHandler)


def registerAYShopControllers():
    registerGameControllers([
     (
      IArmoryYardShopController, ArmoryYardShopController, False)])