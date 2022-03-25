from gui.prb_control.entities.base.pre_queue.permissions import PreQueuePermissions

class RTSPermissions(PreQueuePermissions):

    def canCreateSquad(self):
        return False

    def canAppeal(self):
        return False