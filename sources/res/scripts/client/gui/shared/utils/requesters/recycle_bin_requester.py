from collections import namedtuple
import BigWorld
from ItemRestore import RESTORE_VEHICLE_TYPE
from adisp import adisp_async
from gui.shared.utils.requesters.abstract import AbstractSyncDataRequester
from helpers import time_utils
from skeletons.gui.shared.utils.requesters import IRecycleBinRequester
_VehicleRestoreInfo = namedtuple('_VehicleRestoreInfo', ('restoreType', 'changedAt',
                                                         'restoreDuration', 'restoreCooldown'))

class VehicleRestoreInfo(_VehicleRestoreInfo):

    def getRestoreTimeLeft(self):
        if self.changedAt:
            return max(self.restoreDuration - self.__getTimeGone(), 0)
        return 0

    def getRestoreCooldownTimeLeft(self):
        if self.changedAt:
            return max(self.restoreCooldown - self.__getTimeGone(), 0)
        return 0

    def isLimited(self):
        return self.restoreType == RESTORE_VEHICLE_TYPE.PREMIUM and self.changedAt != 0 and self.restoreDuration < float('inf')

    def isInCooldown(self):
        if self.changedAt:
            return self.restoreType == RESTORE_VEHICLE_TYPE.ACTION and self.getRestoreCooldownTimeLeft() > 0
        return False

    def isUnlimited(self):
        return self.restoreType == RESTORE_VEHICLE_TYPE.ACTION and self.changedAt == 0 or self.restoreType == RESTORE_VEHICLE_TYPE.PREMIUM and self.changedAt != 0 and not self.restoreDuration < float('inf')

    def isRestorePossible(self):
        if self.restoreType == RESTORE_VEHICLE_TYPE.PREMIUM:
            return self.isUnlimited() or self.isLimited() and self.getRestoreTimeLeft() > 0
        return True

    def __getTimeGone(self):
        if self.changedAt:
            return float(time_utils.getTimeDeltaTillNow(time_utils.makeLocalServerTime(self.changedAt)))
        return 0


class RecycleBinRequester(AbstractSyncDataRequester, IRecycleBinRequester):

    @property
    def recycleBin(self):
        return self.getCacheValue('recycleBin', {})

    @property
    def vehiclesBuffer(self):
        return self.recycleBin.get('vehicles', {}).get('buffer', {})

    def getVehicleRestoreInfo(self, intCD, restoreDuration, restoreCooldown):
        restoreData = self.vehiclesBuffer.get(intCD)
        if restoreData:
            restoreType, changedAt = restoreData
            return VehicleRestoreInfo(restoreType, changedAt, restoreDuration, restoreCooldown)
        else:
            return

    def getVehiclesIntCDs(self):
        return self.vehiclesBuffer.keys()

    def getTankmen(self, maxDuration):
        filteredBuffer = {}
        tankmenBuffer = self.recycleBin.get('tankmen', {}).get('buffer', {})
        for tankmanId, (strCD, dismissedAt) in tankmenBuffer.iteritems():
            if time_utils.getTimeDeltaTillNow(dismissedAt) < maxDuration:
                filteredBuffer[tankmanId] = (
                 strCD, dismissedAt)

        return filteredBuffer

    def getTankman(self, invID, maxDuration):
        return self.getTankmen(maxDuration).get(invID)

    @adisp_async
    def _requestCache(self, callback):
        BigWorld.player().recycleBin.getCache(lambda resID, value: self._response(resID, value, callback))