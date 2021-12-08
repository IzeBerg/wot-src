from helpers import dependency
from items.components.ny_constants import ToyTypes, MAX_ATMOSPHERE_LVL, YEARS_INFO, INVALID_TOY_ID
from new_year.ny_level_helper import NewYearAtmospherePresenter
from ny_common.SettingBonus import SettingBonus, SettingBonusConfig
from shared_utils import inPercents
from skeletons.gui.lobby_context import ILobbyContext
from skeletons.gui.shared import IItemsCache
from skeletons.new_year import INewYearController
CREDITS_BONUS = 'creditsFactor'

@dependency.replace_none_kwargs(lobbyCtx=ILobbyContext)
def getBonusConfig(lobbyCtx=None):
    return lobbyCtx.getServerSettings().getNewYearBonusConfig()


def _getMaxCollectionLevels():
    toyCollections = YEARS_INFO.getCollectionTypesByYear(YEARS_INFO.CURRENT_YEAR, useMega=False)
    maxBonusLevel = len(getBonusConfig().getCollectionLevelsRating()) - 1
    return {collectionName:maxBonusLevel for collectionName in toyCollections}


class CreditsBonusHelper(object):
    _itemsCache = dependency.descriptor(IItemsCache)
    _nyController = dependency.descriptor(INewYearController)

    @classmethod
    def getBonus(cls):
        return SettingBonus.calculateBonusForType(bonusType=CREDITS_BONUS, atmosphereLevel=cls.getAtmosphereLevel(), collectionLevels=cls.getCollectionLevels(), megaToysCount=cls.getMegaToysCount(), config=getBonusConfig())

    @classmethod
    def getBonusInPercents(cls):
        return inPercents(cls.getBonus())

    @classmethod
    def getMaxBonus(cls):
        return SettingBonus.calculateBonusForType(bonusType=CREDITS_BONUS, atmosphereLevel=MAX_ATMOSPHERE_LVL, collectionLevels=_getMaxCollectionLevels(), megaToysCount=len(ToyTypes.MEGA), config=getBonusConfig())

    @classmethod
    def getAtmosphereLevel(cls):
        return NewYearAtmospherePresenter.getLevel()

    @classmethod
    def getAtmosphereMultiplier(cls):
        return SettingBonus.getAtmosphereMultiplier(cls.getAtmosphereLevel(), getBonusConfig())

    @classmethod
    def getCollectionsFactor(cls):
        result = 0
        for name in YEARS_INFO.getCollectionTypesByYear(YEARS_INFO.CURRENT_YEAR, useMega=False):
            result += cls.getCollectionFactor(name)

        return result

    @classmethod
    def getCollectionFactor(cls, collectionName):
        level = cls.getCollectionLevelByName(collectionName)
        return SettingBonus.getCollectionFactor(CREDITS_BONUS, collectionName, level, getBonusConfig())

    @classmethod
    def getCollectionLevels(cls):
        result = {}
        for collectionName in YEARS_INFO.getCollectionTypesByYear(YEARS_INFO.CURRENT_YEAR, useMega=False):
            result[collectionName] = cls.getCollectionLevelByName(collectionName)

        return result

    @classmethod
    def getCollectionLevelByName(cls, collectionName):
        config = getBonusConfig()
        requester = cls._itemsCache.items.festivity
        collectionDistrs = requester.getCollectionDistributions()
        collectionStrID = YEARS_INFO.getCollectionSettingID(collectionName, YEARS_INFO.CURRENT_YEAR_STR)
        collectionID = YEARS_INFO.getCollectionIntID(collectionStrID)
        if requester.isSynced():
            return config.getCollectionLevel(collectionDistrs[collectionID])
        return 0

    @classmethod
    def getMegaToysCount(cls):
        result = 0
        slotsDescr = cls._nyController.getSlotDescrs()
        for slotID, toyID in enumerate(cls._itemsCache.items.festivity.getSlots()):
            if toyID != INVALID_TOY_ID and slotsDescr[slotID].type in ToyTypes.MEGA:
                result += 1

        return result

    @classmethod
    def getMegaToysBonus(cls):
        return cls.getMegaToysBonusByCount(cls.getMegaToysCount())

    @classmethod
    def getMegaToysBonusByCount(cls, count):
        return SettingBonus.calculateMegaToysBonus(CREDITS_BONUS, count, getBonusConfig())

    @classmethod
    def getMegaToysBonusValue(cls):
        return getBonusConfig().getMegaToyBonus(CREDITS_BONUS)

    @classmethod
    def getCollectionBonusLevels(cls):
        levels = getBonusConfig().getCollectionLevelsRating()
        result = [ (levels[i], levels[(i + 1)] - 1) for i in xrange(len(levels) - 1) ]
        result.append((levels[(-1)], None))
        return result

    @classmethod
    def getCollectionBonuses(cls, collectionName):
        return getBonusConfig().getCollectionBonuses(CREDITS_BONUS, collectionName)