from gui.prb_control.entities.base.unit.permissions import UnitPermissions

class SquadPermissions(UnitPermissions):

    def canChangeLeadership(self):
        return True

    def canStealLeadership(self):
        return False

    def canExitFromQueue(self):
        return self.isCommander(self._roles)