from gui.prb_control.entities.base.pre_queue.permissions import PreQueuePermissions
from helpers import time_utils, dependency
from skeletons.gui.game_control import IBattleRoyaleController

class BattleRoyalePermissions(PreQueuePermissions):
    __battleRoyaleController = dependency.descriptor(IBattleRoyaleController)

    def canCreateSquad(self):
        currentSeason = self.__battleRoyaleController.getCurrentSeason()
        if currentSeason and super(BattleRoyalePermissions, self).canCreateSquad():
            if currentSeason.hasActiveCycle(time_utils.getCurrentLocalServerTimestamp()):
                return True
        return False