from gui.prb_control.entities.base.pre_queue.permissions import PreQueuePermissions

class MapsTrainingPermissions(PreQueuePermissions):

    def canCreateSquad(self):
        return False