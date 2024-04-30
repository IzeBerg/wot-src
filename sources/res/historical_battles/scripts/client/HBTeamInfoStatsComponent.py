import BigWorld, Event

class HBTeamInfoStatsComponent(BigWorld.DynamicScriptComponent):

    def __init__(self):
        super(HBTeamInfoStatsComponent, self).__init__()
        self.onTeamStatsUpdated = Event.Event()

    def getDamage(self, vehicleID):
        return self._getValue(self.damage, vehicleID)

    def getBlocked(self, vehicleID):
        return self._getValue(self.blocked, vehicleID)

    def getAssist(self, vehicleID):
        return self._getValue(self.assist, vehicleID)

    def set_damage(self, prev):
        self.onTeamStatsUpdated()

    def set_blocked(self, prev):
        self.onTeamStatsUpdated()

    def set_assist(self, prev):
        self.onTeamStatsUpdated()

    @staticmethod
    def _getValue(data, vehicleID):
        return next((info.value for info in data if info.id == vehicleID), 0)