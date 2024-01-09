from gui.prb_control.entities.base.pre_queue.permissions import PreQueuePermissions
from helpers import time_utils, dependency
from skeletons.gui.game_control import IEpicBattleMetaGameController

class EpicPermissions(PreQueuePermissions):
    __epicCtrl = dependency.descriptor(IEpicBattleMetaGameController)

    def canCreateSquad(self):
        currentSeason = self.__epicCtrl.getCurrentSeason()
        if currentSeason and super(EpicPermissions, self).canCreateSquad():
            if currentSeason.hasActiveCycle(time_utils.getCurrentLocalServerTimestamp()):
                return True
        return False