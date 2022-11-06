from gui.prb_control.entities.base.pre_queue.permissions import PreQueuePermissions

class RankedPermissions(PreQueuePermissions):

    def canCreateSquad(self):
        return False