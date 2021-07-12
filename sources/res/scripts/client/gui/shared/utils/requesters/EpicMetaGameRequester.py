import BigWorld
from adisp import async
from gui.shared.utils.requesters.abstract import AbstractSyncDataRequester
from skeletons.gui.shared.utils.requesters import IEpicMetaGameRequester

class EpicMetaGameRequester(AbstractSyncDataRequester, IEpicMetaGameRequester):

    @property
    def playerLevelInfo(self):
        return self.getCacheValue('metaLevel', (0, 0, 0))

    @property
    def seasonData(self):
        return self.getCacheValue('seasonData', (0, False, None))

    @property
    def skillPoints(self):
        return self.getCacheValue('abilityPts', 0)

    def selectedSkills(self, vehicleCD):
        skillsDict = self.getCacheValue('selectedAbilities', None)
        if skillsDict is not None:
            return skillsDict.get(vehicleCD, [])
        else:
            return []

    @property
    def skillLevels(self):
        return self.getCacheValue('abilities', {})

    @property
    def battleCount(self):
        return self.getCacheValue('battleCount', 0)

    @property
    def averageXP(self):
        if self.battleCount > 0:
            return self.getCacheValue('famePts', 0) / self.battleCount
        return 0

    @async
    def _requestCache(self, callback):
        BigWorld.player().epicMetaGame.getCache(lambda resID, value: self._response(resID, value, callback))

    def _preprocessValidData(self, data):
        if 'epicMetaGame' in data:
            return dict(data['epicMetaGame'])
        return dict()