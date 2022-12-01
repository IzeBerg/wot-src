from fun_random.gui.battle_control import registerFunRandomBattle
from fun_random.gui.game_control import registerFunRandomGameControllers
from fun_random.gui.prb_control import registerFunRandomPrebattles
from fun_random.gui.Scaleform import registerFunRandomScaleform
from fun_random.gui.server_events import registerFunRandomQuests
from fun_random.notification import registerFunRandomNotifications

def preInit():
    registerFunRandomGameControllers()
    registerFunRandomScaleform()
    registerFunRandomNotifications()
    registerFunRandomPrebattles(__name__)
    registerFunRandomBattle()
    registerFunRandomQuests()


def init():
    pass


def start():
    pass


def fini():
    pass