

class IPrbPermissions(object):

    def canExitFromQueue(self):
        return True

    def canChangeVehicle(self):
        return True

    def canSendInvite(self):
        return False

    def canCreateSquad(self):
        return False

    def canAppeal(self):
        return True