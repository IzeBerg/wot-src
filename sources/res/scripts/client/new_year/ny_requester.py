import typing, BigWorld
from adisp import async
from gui.shared.utils.requesters.abstract import AbstractSyncDataRequester
from new_year.ny_constants import SyncDataKeys
from new_year.ny_toy_info import NewYearCurrentToyInfo

class _NewYearToy(NewYearCurrentToyInfo):
    __slots__ = ('__totalCount', '__unseenCount', '__unseenInCollection', '__slotsCount')

    def __init__(self, toyId, totalCount, unseenFlag, slotsCount, pureCount):
        super(_NewYearToy, self).__init__(toyId)
        self.__totalCount = totalCount
        self.__slotsCount = slotsCount
        self.__pureCount = pureCount
        self.__unseenCount = unseenFlag >> 1
        self.__unseenInCollection = not bool(unseenFlag % 2)

    def getCount(self):
        return self.__totalCount

    def getUnseenCount(self):
        return self.__unseenCount

    def getSlotsCount(self):
        return self.__slotsCount

    def getPureCount(self):
        return self.__pureCount

    def getUsedCount(self):
        return self.__totalCount - self.__pureCount

    def isNewInCollection(self):
        return self.__unseenInCollection

    def __cmp__(self, other):
        if other.getRank() != self.getRank():
            return other.getRank() - self.getRank()
        if self.__unseenCount and not other.getUnseenCount():
            return -1
        if not self.__unseenCount and other.getUnseenCount():
            return 1
        return self.getID() - other.getID()


class NewYearRequester(AbstractSyncDataRequester):
    dataKey = 'newYear22'

    def getToys(self):
        return self.getCacheValue(SyncDataKeys.INVENTORY_TOYS, {})

    def getSlots(self):
        return self.getCacheValue(SyncDataKeys.SLOTS, [])

    def getAtmPoints(self):
        return self.getCacheValue(SyncDataKeys.POINTS, 0)

    def getMaxLevel(self):
        return self.getCacheValue(SyncDataKeys.LEVEL, 0)

    def getAlbums(self):
        return self.getCacheValue(SyncDataKeys.ALBUMS, {})

    def getToyCollection(self):
        return self.getCacheValue(SyncDataKeys.TOY_COLLECTION)

    def getCollectionDistributions(self):
        return self.getCacheValue(SyncDataKeys.COLLECTION_DISTRIBUTIONS, {})

    def getShardsCount(self):
        return self.getCacheValue(SyncDataKeys.TOY_FRAGMENTS, 0)

    def getFillersCount(self):
        return self.getCacheValue(SyncDataKeys.FILLERS, 0)

    def getVehicleBranch(self):
        return self.getCacheValue(SyncDataKeys.VEHICLE_BRANCH, [])

    def getVehicleBonusChoices(self):
        return self.getCacheValue(SyncDataKeys.VEHICLE_BONUS_CHOICES, [])

    def getVehicleCooldown(self):
        return self.getCacheValue(SyncDataKeys.VEHICLE_COOLDOWN, [])

    def getSelectedDiscounts(self):
        return self.getCacheValue(SyncDataKeys.SELECTED_DISCOUNTS, set())

    def getMaxReachedBonusValue(self, bonusType):
        return self._getMaxReachedBonus(bonusType).get(SyncDataKeys.MAX_BONUS_VALUE, 0.0)

    def getMaxReachedBonusInfo(self, bonusType):
        return self._getMaxReachedBonus(bonusType).get(SyncDataKeys.MAX_BONUS_INFO, (0,
                                                                                     0,
                                                                                     0))

    def getPureSlots(self):
        return self.getCacheValue(SyncDataKeys.PURE_SLOTS, [])

    def _getMaxReachedBonus(self, bonusType):
        return self.getCacheValue(SyncDataKeys.MAX_BONUS, {}).get(bonusType, {})

    @async
    def _requestCache(self, callback):
        BigWorld.player().festivities.getCache(lambda resID, value: self._response(resID, value, callback))

    def _preprocessValidData(self, data):
        nyData = data.get(self.dataKey, {})
        result = dict(nyData)
        if SyncDataKeys.INVENTORY_TOYS in nyData:
            inventoryToys = {}
            for toyId, (totalCount, unseenCount, slotsCount, pureCount) in nyData[SyncDataKeys.INVENTORY_TOYS].iteritems():
                inventoryToys[toyId] = _NewYearToy(toyId, totalCount, unseenCount, slotsCount, pureCount)

            result[SyncDataKeys.INVENTORY_TOYS] = inventoryToys
        return result