import BigWorld
from adisp import async
from gui.shared.utils.requesters.abstract import AbstractSyncDataRequester
from skeletons.gui.shared.utils.requesters import IVehicleRotationRequester

class VehicleRotationRequester(AbstractSyncDataRequester, IVehicleRotationRequester):

    def getBattlesCount(self, groupNum):
        battlesCount = self._groupLocks['groupBattles']
        groupIdx = max(0, groupNum - 1)
        if len(battlesCount) > groupIdx:
            return battlesCount[groupIdx]
        return -1

    def isGroupLocked(self, groupNum):
        if groupNum == 0:
            return False
        groupsLocks = self._groupLocks['isGroupLocked']
        groupIdx = max(0, groupNum - 1)
        if len(groupsLocks) > groupIdx:
            return groupsLocks[groupIdx]
        return False

    def getGroupNum(self, vehIntCD):
        return self.getCacheValue('vehiclesGroupMapping', {}).get(vehIntCD, 0)

    def isInfinite(self, groupNum):
        return self.getBattlesCount(groupNum) == -1

    def unlockedBy(self, groupNum):
        playGroupsToUnlock = self._groupLocks['unlockedBy']
        return playGroupsToUnlock.get(groupNum, -1)

    @property
    def _groupLocks(self):
        return self.getCacheValue('groupLocks', {'groupBattles': [], 'isGroupLocked': [], 'unlockedBy': {}})

    @async
    def _requestCache(self, callback):
        BigWorld.player().vehicleRotation.getCache(lambda resID, value: self._response(resID, value, callback))