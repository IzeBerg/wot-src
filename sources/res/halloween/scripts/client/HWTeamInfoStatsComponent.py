import BigWorld, Event
from helpers import isPlayerAvatar

class HWTeamInfoStatsComponent(BigWorld.DynamicScriptComponent):

    def __init__(self):
        super(HWTeamInfoStatsComponent, self).__init__()
        self.onTeamStatsUpdated = Event.Event()
        self.onTeamBuffsUpdated = Event.Event()
        self.onTeamHealthUpdated = Event.Event()

    def onDestroy(self):
        self.onTeamStatsUpdated.clear()
        self.onTeamBuffsUpdated.clear()
        self.onTeamHealthUpdated.clear()

    def getDamage(self, vehicleID):
        return self._getValue(self.damage, vehicleID)

    def getBlocked(self, vehicleID):
        return self._getValue(self.blocked, vehicleID)

    def getAssist(self, vehicleID):
        return self._getValue(self.assist, vehicleID)

    def getTeamSouls(self):
        return sum(info.value for info in self.souls)

    def getVehicleBuffs(self, vehicleID):
        return self._getValue(self.vehicleBuffs, vehicleID, default=[])

    def getTeamHealth(self):
        return self.teamHealth

    def set_damage(self, prev):
        self.onTeamStatsUpdated()

    def set_blocked(self, prev):
        self.onTeamStatsUpdated()

    def set_assist(self, prev):
        self.onTeamStatsUpdated()

    def set_vehicleBuffs(self, prev):
        self.onTeamBuffsUpdated()

    def set_teamHealth(self, prev):
        self.onTeamHealthUpdated()

    @classmethod
    def getInstance(cls):
        if not isPlayerAvatar():
            return
        else:
            player = BigWorld.player()
            if not player:
                return
            if not player.arena or not player.arena.teamInfo:
                return
            return getattr(player.arena.teamInfo, cls.__name__, None)

    @staticmethod
    def _getValue(data, vehicleID, default=0):
        return next((info.value for info in data if info.id == vehicleID), default)