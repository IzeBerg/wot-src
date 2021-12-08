from typing import List, Optional, Dict, Callable, Iterable, TYPE_CHECKING
from constants import IS_BASEAPP, IS_CLIENT
from debug_utils import LOG_CURRENT_EXCEPTION
from items import collectibles
from items.components.ny_constants import YEARS_INFO, MAX_MEGA_TOY_RANK
from wotdecorators import singleton
from ny_common.ny_exception import NYSoftException
from itertools import chain
from items.components import ny_constants as CONSTS
from items.readers.ny_readers import readLevelRewards, readSlots, readCollectionRewards, readToysTransformations, buildVariadicDiscountsCache
if TYPE_CHECKING:
    from items.collectibles import ToyDescriptor

def _countToysByCollection(toysDescrs, collectingFunction=None):
    counts = {}
    for toy in toysDescrs:
        cid = collectingFunction(toyDescr=toy)
        counts.setdefault(cid, 0)
        counts[cid] += 1

    return [ counts[cid] for cid in sorted(counts.keys(), key=YEARS_INFO.getCollectionIntID) ]


def _buildToyGroups(toysDescrs):
    groups = {}
    for toy in toysDescrs:
        groupID = getToyGroupID(toyDescr=toy)
        groups.setdefault(groupID, [])
        groups[groupID].append(toy.id)

    if any(len(gv) < 1 for gk, gv in groups.iteritems()):
        raise NYSoftException('Inconsistent toys description. Degenerate group size < 1')
    currYearMaxToyRank = YEARS_INFO.currYearMaxToyRank()
    toysInfos = [
     (
      currYearMaxToyRank, CONSTS.ToySettings.NEW, CONSTS.TOY_USUAL_TYPES),
     (
      MAX_MEGA_TOY_RANK, CONSTS.ToySettings.MEGA, CONSTS.MEGA_TOY_TYPES)]
    expectedGroupsCount = _calculateExpectedCount(toysInfos)
    if len(groups) == expectedGroupsCount:
        return groups
    missingToys = _findMissingToys(toysInfos, groups)
    raise NYSoftException(('Inconsistent toys description. Missing toys (groups len={}, expectedGroupsLen={} toyRank={}): {} of {}').format(len(groups), expectedGroupsCount, currYearMaxToyRank, len(missingToys), missingToys))


def _calculateExpectedCount(toysInfos):
    expectedCount = 0
    for toysInfo in toysInfos:
        maxRank, toySettingsList, toyTypesList = toysInfo
        expectedCount += maxRank * len(toySettingsList) * len(toyTypesList)

    return expectedCount


def _findMissingToys(toysInfos, obtainedGroups):

    def _find(maxRank, toySettingsList, toyTypesList):
        missing = []
        for typeID, typeName in enumerate(toyTypesList):
            for settingID, settingName in enumerate(toySettingsList):
                for rank in xrange(1, maxRank + 1):
                    if getToyGroupID(typeID, settingID, rank) not in obtainedGroups:
                        missing.append((typeName, settingName, rank))

        return missing

    missingToys = []
    for toysInfo in toysInfos:
        missingToys.extend(_find(*toysInfo))

    return missingToys


def dictlike(f):
    return type('', (object,), {'__call__': lambda s, arg: f(arg), '__getitem__': lambda s, k: f(*(k if isinstance(k, tuple) else (k,)))})()


@singleton
class g_cache(object):

    def __init__(self):
        self.__cfg = {}

    def __getattr__(self, attr):
        return self.__cfg[attr]

    def init(self, nofail=True):
        cfg = self.__cfg
        try:
            getToyCollectionID = getToySettingID
            ny18Toys = collectibles.g_cache.ny18.toys
            ny19Toys = collectibles.g_cache.ny19.toys
            ny20Toys = collectibles.g_cache.ny20.toys
            ny21Toys = collectibles.g_cache.ny21.toys
            ny22Toys = collectibles.g_cache.ny22.toys
            cfg['toys'] = ny22Toys
            collections = set(getToyCollectionID(toyDescr=toyDescr) for toyDescr in chain(ny22Toys.itervalues(), ny21Toys.itervalues(), ny20Toys.itervalues(), ny19Toys.itervalues(), ny18Toys.itervalues()))
            cfg['collections'] = {name:YEARS_INFO.getCollectionIntID(name) for name in collections}
            cfg['collectionStrIDs'] = sorted(cfg['collections'].keys(), key=YEARS_INFO.getCollectionIntID)
            cfg['slots'] = readSlots(CONSTS.COLLECTION2022_SLOTS_XML_PATH)
            cfg['levels'] = readLevelRewards(CONSTS.COLLECTION2022_LEVEL_REWARDS_XML_PATH)
            cfg['collectionRewardsByCollectionID'] = dict(chain(readCollectionRewards(CONSTS.COLLECTION2022_REWARDS_XML_PATH).iteritems(), readCollectionRewards(CONSTS.COLLECTION2021_REWARDS_XML_PATH).iteritems(), readCollectionRewards(CONSTS.COLLECTION2020_REWARDS_XML_PATH).iteritems(), readCollectionRewards(CONSTS.COLLECTION2019_REWARDS_XML_PATH).iteritems(), readCollectionRewards(CONSTS.COLLECTION2018_REWARDS_XML_PATH).iteritems()))
            cfg['toyCountByCollectionID'] = _countToysByCollection(chain(ny22Toys.itervalues(), ny21Toys.itervalues(), ny20Toys.itervalues(), ny19Toys.itervalues(), ny18Toys.itervalues()), collectingFunction=getToyCollectionID)
            cfg['variadicDiscounts'] = buildVariadicDiscountsCache(CONSTS.VARIADIC_DISCOUNTS_XML_PATH)
            if IS_CLIENT:
                cfg['toysTransformations'] = readToysTransformations(CONSTS.TOYS_TRANSFORMATIONS_XML_PATH)
            if IS_BASEAPP:
                cfg['collectionIDs'] = dictlike(getToyCollectionID)
                cfg['levelRewardsByID'] = dict((lr.level, lid) for lid, lr in self.levels.iteritems())
                cfg['toyGroups'] = _buildToyGroups(self.toys.itervalues())
        except Exception:
            self.ffini()
            if nofail:
                raise
            LOG_CURRENT_EXCEPTION()

    def ffini(self):
        self.__cfg.clear()

    def __nonzero__(self):
        return bool(self.__cfg)


def getObjectByToyType(toyType):
    for customizationType, toyTypes in CONSTS.TOY_TYPES_BY_OBJECT.iteritems():
        if toyType in toyTypes:
            return customizationType

    return


def getToyGroupID(typeID=None, settingID=None, rank=None, toyDescr=None):
    typeID = CONSTS.TOY_TYPE_IDS_BY_NAME[toyDescr.type] if toyDescr is not None else typeID
    settingID = YEARS_INFO.CURRENT_SETTING_IDS_BY_NAME[toyDescr.setting] if toyDescr is not None else settingID
    rank = toyDescr.rank if toyDescr else rank
    return typeID << 16 | settingID << 8 | rank


def getToyObjectID(toyID=None, toyDescr=None):
    if toyDescr is None:
        toyDescr = g_cache.toys[toyID]
    myType = toyDescr.type
    for o, types in CONSTS.TOY_TYPES_BY_OBJECT.iteritems():
        if myType in types:
            return CONSTS.TOY_OBJECTS_IDS_BY_NAME.get(o, -1)

    return -1


def getToySettingID(toyID=None, toyDescr=None):
    if toyDescr is None:
        toyDescr = g_cache.toys[toyID]
    return YEARS_INFO.getCollectionSettingID(toyDescr.setting, toyDescr.collection)


def getToyMask(toyID, year):
    offset = YEARS_INFO.getToyCollectionOffsetForYear(year)
    bytePos = offset + toyID / 8
    mask = 1 << toyID % 8
    return (bytePos, mask)


def getCollectionByStrID(collectionStrID):
    year, settingID = YEARS_INFO.splitCollectionStrID(collectionStrID)
    if settingID < 0:
        return (None, None)
    else:
        collectionName = YEARS_INFO.getCollectionTypesByYear(year)[settingID]
        return (year, collectionName)


def getCollectionByIntID(collectionIntID):
    collectionStrID = g_cache.collectionStrIDs[collectionIntID]
    return getCollectionByStrID(collectionStrID)


def init(nofail=True):
    if not g_cache:
        g_cache.init(nofail)