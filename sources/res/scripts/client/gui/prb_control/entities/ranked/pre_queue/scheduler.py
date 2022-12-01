from gui.impl.gen import R
from gui.periodic_battles.prb_control.scheduler import PeriodicScheduler
from helpers import dependency
from skeletons.gui.game_control import IRankedBattlesController

class RankedScheduler(PeriodicScheduler):
    _RES_ROOT = R.strings.system_messages.ranked
    __rankedController = dependency.descriptor(IRankedBattlesController)

    def _getController(self):
        return self.__rankedController