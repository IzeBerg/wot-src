import BigWorld, Event
from helpers import isPlayerAvatar
from script_component.DynamicScriptComponent import DynamicScriptComponent

class TeamInfoLivesComponent(DynamicScriptComponent):

    def __init__(self, *_, **__):
        super(TeamInfoLivesComponent, self).__init__(*_, **__)
        self.onTeamLivesUpdated = Event.SafeEvent()

    onRespawnInfoUpdated = Event.Event()

    def onDestroy(self):
        self.onTeamLivesUpdated.clear()
        super(TeamInfoLivesComponent, self).onDestroy()

    def _onAvatarReady(self):
        self.onTeamLivesUpdated()
        self.onRespawnInfoUpdated(self.__getRespawnInfoIDs())

    def set_teamLives(self, prev):
        if self._isAvatarReady:
            self.onTeamLivesUpdated()

    def set_respawnInfo(self, prev):
        teleport = self.entity.sessionProvider.dynamic.teleport
        if teleport is None:
            return
        else:
            teleport.onTeamRespawnInfoUpdated(self.__getRespawnInfoIDs())
            return

    def getLives(self, vehicleID):
        return self.getVehicleLives(vehicleID).get('lives', 0)

    def getLockedLives(self, vehicleID):
        return self.getVehicleLives(vehicleID).get('lockedLives', 0)

    def getUsedLives(self, vehicleID):
        return self.getVehicleLives(vehicleID).get('usedLives', 0)

    def getVehicleLives(self, vehicleID):
        for vl in self.teamLives:
            if vl['vehicleID'] == vehicleID:
                return dict(vl)

        return {}

    def getRespawnInfo(self, vehicleID):
        for entry in self.respawnInfo:
            if entry['vehicleID'] != vehicleID:
                continue
            return (
             entry.spawnTime, entry.delay)

        return (0.0, 0.0)

    def __getRespawnInfoIDs(self):
        if self.respawnInfo is None:
            return []
        else:
            return [ entry['vehicleID'] for entry in self.respawnInfo ]

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
            return getattr(player.arena.teamInfo, 'teamLivesComponent', None)