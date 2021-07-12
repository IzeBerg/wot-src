import BigWorld
from gui.battle_control.controllers.respawn_ctrl import RespawnsController, IRespawnView
from helpers import dependency
from gui.battle_control import avatar_getter
from skeletons.gui.battle_session import IBattleSessionProvider
from helpers import i18n
from debug_utils import LOG_ERROR, LOG_DEBUG
from gui.Scaleform.locale.EPIC_BATTLE import EPIC_BATTLE
EB_MIN_RESPAWN_LANE_IDX = 1
EB_MAX_RESPAWN_LANE_IDX = 4

class IEpicRespawnView(IRespawnView):

    def setSelectedLane(self, laneId):
        raise NotImplementedError

    def setSelectedPoint(self, pointId):
        raise NotImplementedError

    def setRespawnInfo(self, respawnInfo):
        raise NotImplementedError

    def setLaneState(self, laneID, enabled, blockedText):
        raise NotImplementedError


class EpicRespawnsController(RespawnsController):
    sessionProvider = dependency.descriptor(IBattleSessionProvider)

    def startControl(self):
        super(EpicRespawnsController, self).startControl()
        playerDataComp = getattr(self.sessionProvider.arenaVisitor.getComponentSystem(), 'playerDataComponent', None)
        if playerDataComp is not None:
            playerDataComp.onPlayerRespawnLaneUpdated += self.__onPlayerRespawnLaneUpdated
            playerDataComp.onPlayerGroupsChanged += self.__onPlayerGroupsChanged
        else:
            LOG_ERROR('Expected PlayerDataComponent not present!')
        return

    def stopControl(self):
        super(EpicRespawnsController, self).stopControl()
        playerDataComp = getattr(self.sessionProvider.arenaVisitor.getComponentSystem(), 'playerDataComponent', None)
        if playerDataComp is not None:
            playerDataComp.onPlayerRespawnLaneUpdated -= self.__onPlayerRespawnLaneUpdated
            playerDataComp.onPlayerGroupsChanged -= self.__onPlayerGroupsChanged
        return

    def updateVehicleLimits(self, limits):
        super(EpicRespawnsController, self).updateVehicleLimits(limits)
        self.__onPlayerGroupsChanged(None)
        return

    def updateRespawnInfo(self, respawnInfo):
        super(EpicRespawnsController, self).updateRespawnInfo(respawnInfo)
        self.__onRespawnInfoUpdated(self.respawnInfo)

    @staticmethod
    def requestLaneForRespawn(laneID):
        BigWorld.player().base.respawnController_requestRespawnGroupChange(laneID)

    @staticmethod
    def requestPointForRespawn(respawnZone):
        BigWorld.player().base.respawnController_chooseRespawnZone(respawnZone)

    def _show(self):
        super(EpicRespawnsController, self)._show()
        playerDataComp = getattr(self.sessionProvider.arenaVisitor.getComponentSystem(), 'playerDataComponent', None)
        if playerDataComp is not None:
            self.__onRespawnInfoUpdated(self.respawnInfo)
            self.__onPlayerRespawnLaneUpdated(playerDataComp.respawnLane)
            self.__onPlayerGroupsChanged(None)
        return

    def __onPlayerRespawnLaneUpdated(self, laneID):
        for viewCmp in self._viewComponents:
            viewCmp.setSelectedLane(laneID)

        self.__onPlayerGroupsChanged(None)
        return

    def __onRespawnInfoUpdated(self, respawnInfo):
        if not self.isRespawnVisible():
            return
        else:
            for viewCmp in self._viewComponents:
                viewCmp.setRespawnInfo(respawnInfo)

            self.__onPlayerGroupsChanged(None)
            return

    def __onPlayerGroupsChanged(self, _):
        if not self.isRespawnVisible():
            return
        else:
            arena = avatar_getter.getArena()
            if arena is None:
                return
            playerDataComp = getattr(self.sessionProvider.arenaVisitor.getComponentSystem(), 'playerDataComponent', None)
            if playerDataComp is None:
                LOG_ERROR('Expected PlayerDataComponent not present!')
                return
            vehicleLimits = self.getLimits()
            limit = arena.arenaType.playerGroupLimit
            selectedVehicleID = 0
            availableLanes = [ lane for lane in range(EB_MIN_RESPAWN_LANE_IDX, EB_MAX_RESPAWN_LANE_IDX) if playerDataComp.getPlayersForTeamAndGroup(avatar_getter.getPlayerTeam(), lane) < limit
                             ]
            if self.respawnInfo:
                selectedVehicleID = self.respawnInfo.vehicleID
            for lane in range(EB_MIN_RESPAWN_LANE_IDX, EB_MAX_RESPAWN_LANE_IDX):
                if playerDataComp.respawnLane == lane:
                    isEnoughPlace = True
                else:
                    isEnoughPlace = playerDataComp.getPlayersForTeamAndGroup(avatar_getter.getPlayerTeam(), lane) < limit
                isVehicleBlocked = lane in vehicleLimits and selectedVehicleID in vehicleLimits[lane]
                isAvailableForPlayer = (isEnoughPlace or playerDataComp.respawnLane == lane and not availableLanes) and not isVehicleBlocked
                reasonText = ''
                if not isEnoughPlace:
                    reasonText = EPIC_BATTLE.DEPLOYMENTMAP_LANEPLAYERLIMITREACHED
                else:
                    if isVehicleBlocked:
                        reasonText = EPIC_BATTLE.DEPLOYMENTMAP_SPGLIMITREACHED
                    if not isEnoughPlace or isVehicleBlocked:
                        LOG_DEBUG('lane %d is blocked for %d ', lane, selectedVehicleID, isVehicleBlocked, 0 if lane not in vehicleLimits else vehicleLimits[lane])
                    for viewCmp in self._viewComponents:
                        viewCmp.setLaneState(lane, isAvailableForPlayer, i18n.makeString(reasonText))

            return