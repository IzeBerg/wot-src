from gui.impl.gen import R
from gui.periodic_battles.prb_control.scheduler import PeriodicScheduler
from helpers import dependency
from skeletons.gui.game_control import IFunRandomController

class FunRandomScheduler(PeriodicScheduler):
    _RES_ROOT = R.strings.fun_random.message
    _controller = dependency.descriptor(IFunRandomController)