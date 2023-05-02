from gui.prb_control.entities.base.pre_queue.permissions import PreQueuePermissions

class WinbackPermissions(PreQueuePermissions):

    def canCreateSquad(self):
        return False

    def hasSquadArrow(self):
        return True