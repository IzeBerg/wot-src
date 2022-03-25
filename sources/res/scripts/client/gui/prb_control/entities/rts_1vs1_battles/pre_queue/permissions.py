from gui.prb_control.entities.base.pre_queue.permissions import PreQueuePermissions

class RTS1x1Permissions(PreQueuePermissions):

    def canCreateSquad(self):
        return False