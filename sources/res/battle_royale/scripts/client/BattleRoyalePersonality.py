from battle_royale.gui.battle_control.controllers.repository import registerBRBattleRepo
from battle_royale.gui.Scaleform import registerBRBattlePackages, registerBRLobbyPackages, registerBRTooltipsBuilders
from battle_royale.gui.battle_control.controllers.equipment_items import registerBREquipmentsItems
from battle_royale.gui.prb_control import registerBRPrebattles
import gui.customization
from battle_royale.gui.game_control import registerBRGameControllers

def preInit():
    registerBRBattleRepo()
    registerBRBattlePackages()
    registerBRLobbyPackages()
    registerBRTooltipsBuilders()
    registerBRGameControllers()
    registerBREquipmentsItems()
    registerBRPrebattles()


def init():
    pass


def start():
    pass


def fini():
    pass