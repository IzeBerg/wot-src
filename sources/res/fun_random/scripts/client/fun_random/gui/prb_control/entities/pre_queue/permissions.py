from fun_random.gui.feature.util.fun_mixins import FunSubModesWatcher
from fun_random.gui.feature.util.fun_wrappers import hasDesiredSubMode
from gui.prb_control.entities.base.pre_queue.permissions import PreQueuePermissions

class FunRandomPermissions(PreQueuePermissions, FunSubModesWatcher):

    @hasDesiredSubMode(defReturn=False)
    def canCreateSquad(self):
        return super(FunRandomPermissions, self).canCreateSquad()