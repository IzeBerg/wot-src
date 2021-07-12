import BigWorld
from adisp import async
from gui.shared.utils.requesters.abstract import AbstractSyncDataRequester

class BattlePassRequester(AbstractSyncDataRequester):

    def getSeasonID(self):
        return self.getCacheValue('seasonID', 0)

    def getPoints(self):
        return self.getCacheValue('sumPoints', 0)

    def getCurrentLevel(self):
        return self.getCacheValue('level', 0)

    def getState(self):
        return self.getCacheValue('state', 0)

    def getPointsForVehicle(self, vehicleID, default=0):
        return self.getCacheValue('vehiclePoints', {}).get(vehicleID, default)

    def getPackedStats(self):
        return self.getCacheValue('packedStats', '')

    def getChosenItems(self):
        return self.getCacheValue('seasonStats', {}).get('chosenItems', {})

    def _preprocessValidData(self, data):
        return dict(data.get('battlePass', {}))

    @async
    def _requestCache(self, callback):
        BigWorld.player().battlePass.getCache(lambda resID, value: self._response(resID, value, callback))