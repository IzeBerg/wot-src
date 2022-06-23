from gui.prb_control.entities.base.pre_queue.permissions import PreQueuePermissions
from helpers import dependency
from skeletons.gui.game_control import IMapboxController

class MapboxPermissions(PreQueuePermissions):
    __mapboxController = dependency.descriptor(IMapboxController)

    def canCreateSquad(self):
        if self.__mapboxController.isInPrimeTime():
            return super(MapboxPermissions, self).canCreateSquad()
        return False