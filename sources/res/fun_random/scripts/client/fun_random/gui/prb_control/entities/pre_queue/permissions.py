from gui.prb_control.entities.base.pre_queue.permissions import PreQueuePermissions
from helpers import dependency
from skeletons.gui.game_control import IFunRandomController

class FunRandomPermissions(PreQueuePermissions):
    __funRandomController = dependency.descriptor(IFunRandomController)

    def canCreateSquad(self):
        if self.__funRandomController.isInPrimeTime():
            return super(FunRandomPermissions, self).canCreateSquad()
        return False