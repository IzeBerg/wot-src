import logging
from collections import namedtuple
from helpers import dependency
from items import collectibles
from gui.impl.gen import R
from items import new_year
from items.components.ny_constants import YEARS_INFO, MAX_TOY_RANK, ToySettings, ToyTypes, UNDEFINED_TOY_RANK
from items.components.ny_constants import YEARS
from new_year.ny_constants import TOY_PREFIX, Collections
from skeletons.gui.shared import IItemsCache
from skeletons.gui.lobby_context import ILobbyContext
from skeletons.new_year import INewYearController
_logger = logging.getLogger(__name__)
TOYS_INFO_REGISTRY = {}
_PASSEPARTOUTS = ('c_1', 'c_2', 'c_3', 'c_4')
_SLOT_TYPE_ORDER = {v:i for i, v in enumerate((
 ToyTypes.MEGA_FIR,
 ToyTypes.MEGA_TABLEFUL,
 ToyTypes.MEGA_INSTALLATION,
 ToyTypes.MEGA_ILLUMINATION,
 ToyTypes.KIOSK,
 ToyTypes.ATTRACTION,
 ToyTypes.GARLAND_FAIR,
 ToyTypes.GARLAND_INSTALLATION,
 ToyTypes.FERRIS_WHEEL,
 ToyTypes.AIR_BALLOON,
 ToyTypes.BRIDGE,
 ToyTypes.CASTLE,
 ToyTypes.TOP,
 ToyTypes.GARLAND,
 ToyTypes.GARLAND_FIR,
 ToyTypes.BALL,
 ToyTypes.FLOOR,
 ToyTypes.TABLE,
 ToyTypes.KITCHEN,
 ToyTypes.SCULPTURE,
 ToyTypes.DECORATION,
 ToyTypes.SCULPTURE_LIGHT,
 ToyTypes.TREES,
 ToyTypes.GROUND_LIGHT,
 ToyTypes.TENT,
 ToyTypes.PAVILION,
 ToyTypes.SNOW_ITEM,
 ToyTypes.PYRO))}
_TOY_SETTING_ORDER = {v:i for i, v in enumerate((
 ToySettings.NEW_YEAR,
 ToySettings.CHRISTMAS,
 ToySettings.ORIENTAL,
 ToySettings.FAIRYTALE,
 ToySettings.MEGA_TOYS))}
_SortPriorityPart = namedtuple('SortPriorityPart', ('value', 'max'))

def registerInDict(registryDict, keyName):

    def wrapper(objectValue):
        registryDict[keyName] = objectValue
        return objectValue

    return wrapper


def _packSortPriority(descriptor):
    order = (
     _SortPriorityPart(int(descriptor.setting != ToySettings.MEGA_TOYS), int(True)),
     _SortPriorityPart(MAX_TOY_RANK - descriptor.rank, MAX_TOY_RANK),
     _SortPriorityPart(_SLOT_TYPE_ORDER[descriptor.type], max(_SLOT_TYPE_ORDER.itervalues())),
     _SortPriorityPart(_TOY_SETTING_ORDER[descriptor.setting], max(_TOY_SETTING_ORDER.itervalues())))
    value = offset = 0
    for part in reversed(order):
        value |= part.value << offset
        offset += part.max.bit_length()

    return value


def _getMegaPassepartoutName(passepartout):
    return passepartout.replace('c_', 'mega_')


class _NewYearCommonToyInfo(object):
    COLLECTION_NAME = ''
    _itemsCache = dependency.descriptor(IItemsCache)
    _lobbyCtx = dependency.descriptor(ILobbyContext)
    __slots__ = ('_descriptor', '_shards')
    _SIZE_TO_FOLDER = {'big': 'medium', 
       's360x270': 'large'}

    def __init__(self, descriptor):
        super(_NewYearCommonToyInfo, self).__init__()
        self._descriptor = descriptor
        self._shards = 0

    def getToyType(self):
        return self._descriptor.type

    def getID(self):
        return self._descriptor.id

    def getSetting(self):
        return self._descriptor.setting

    def getRank(self):
        return self._descriptor.rank

    def getIconName(self):
        return self._descriptor.icon

    def getCollectionName(self):
        return self.getSetting()

    def getCollectionID(self):
        return new_year.getToySettingID(toyDescr=self._descriptor)

    def getShards(self):
        if not self._shards:
            craftCostConfig = self._lobbyCtx.getServerSettings().getNewYearCraftCostConfig()
            self._shards = craftCostConfig.calculateOldCraftCost(self.getID(), self.COLLECTION_NAME)
        return self._shards

    def isInCollection(self):
        toyCollection = self._itemsCache.items.festivity.getToyCollection()
        toyID = self.getID()
        bytePos = YEARS_INFO.getToyCollectionOffsetForYear(self.COLLECTION_NAME) + toyID / 8
        mask = 1 << toyID % 8
        if toyCollection[bytePos] & mask:
            return True
        return False

    def isMega(self):
        return self.getSetting() == ToySettings.MEGA_TOYS

    def getIcon(self, size='big'):
        year = YEARS.getFullYearNumFromYearStr(self.COLLECTION_NAME)
        sizeStr = 'mega' if self.isMega() else self._SIZE_TO_FOLDER[size]
        res = R.images.gui.maps.icons.newYear.toys.num(year).dyn(sizeStr).dyn(self.getIconName())
        if not res.exists():
            _logger.error('Missing NY Toy icon. Toy ID: %s; icon size: %s.', self.getID(), size)
            return R.invalid()
        return res()


class _NewYearBackportToyInfo(_NewYearCommonToyInfo):
    PREFIX = ''
    __slots__ = ()

    def getLocalKey(self):
        if self._descriptor.hasName():
            return self._descriptor.name
        return TOY_PREFIX + str(self.getID())

    def getName(self):
        return R.strings.dyn(self.PREFIX).decorations.dyn(self.getLocalKey()).name()

    def getDesc(self):
        if self.getRank() == YEARS_INFO.getMaxToyRankByYear(self.COLLECTION_NAME) or self.isMega():
            return R.strings.dyn(self.PREFIX).decorations.dyn(self.getLocalKey()).description()
        return R.invalid()

    def getRankIcon(self):
        return R.invalid()


@registerInDict(TOYS_INFO_REGISTRY, Collections.NewYear18)
class NewYear18ToyInfo(_NewYearBackportToyInfo):
    PREFIX = 'toys18'
    COLLECTION_NAME = Collections.NewYear18
    __slots__ = ()

    def __init__(self, toyID):
        super(NewYear18ToyInfo, self).__init__(collectibles.g_cache.ny18.toys[toyID])


@registerInDict(TOYS_INFO_REGISTRY, Collections.NewYear19)
class NewYear19ToyInfo(_NewYearBackportToyInfo):
    PREFIX = 'toys19'
    COLLECTION_NAME = Collections.NewYear19
    __slots__ = ()

    def __init__(self, toyID):
        super(NewYear19ToyInfo, self).__init__(collectibles.g_cache.ny19.toys[toyID])


@registerInDict(TOYS_INFO_REGISTRY, Collections.NewYear20)
class NewYear20ToyInfo(_NewYearBackportToyInfo):
    PREFIX = 'toys20'
    COLLECTION_NAME = Collections.NewYear20
    __slots__ = ()

    def __init__(self, toyID):
        super(NewYear20ToyInfo, self).__init__(collectibles.g_cache.ny20.toys[toyID])


@registerInDict(TOYS_INFO_REGISTRY, Collections.NewYear21)
class NewYear21ToyInfo(_NewYearBackportToyInfo):
    PREFIX = 'toys21'
    COLLECTION_NAME = Collections.NewYear21
    __slots__ = ('__sortPriority', )

    def __init__(self, toyID):
        descriptor = collectibles.g_cache.ny21.toys[toyID]
        super(NewYear21ToyInfo, self).__init__(descriptor)
        self.__sortPriority = _packSortPriority(descriptor)

    def getSortPriority(self):
        return self.__sortPriority


@registerInDict(TOYS_INFO_REGISTRY, Collections.NewYear22)
class NewYear22ToyInfo(_NewYearBackportToyInfo):
    PREFIX = 'toys22'
    COLLECTION_NAME = Collections.NewYear22
    __slots__ = ('__sortPriority', )

    def __init__(self, toyID):
        descriptor = collectibles.g_cache.ny22.toys[toyID]
        super(NewYear22ToyInfo, self).__init__(descriptor)
        self.__sortPriority = _packSortPriority(descriptor)

    def getSortPriority(self):
        return self.__sortPriority

    def getRank(self):
        return UNDEFINED_TOY_RANK

    def getDesc(self):
        return R.strings.dyn(self.PREFIX).decorations.dyn(self.getLocalKey()).description()


@registerInDict(TOYS_INFO_REGISTRY, Collections.NewYear24)
class NewYear24ToyInfo(_NewYearBackportToyInfo):
    PREFIX = 'toys24'
    COLLECTION_NAME = Collections.NewYear24
    __slots__ = ('__sortPriority', )

    def __init__(self, toyID):
        descriptor = collectibles.g_cache.ny24.toys[toyID]
        super(NewYear24ToyInfo, self).__init__(descriptor)
        self.__sortPriority = _packSortPriority(descriptor)

    def getSortPriority(self):
        return self.__sortPriority

    def getRank(self):
        return self._descriptor.rank


class NewYearCurrentToyInfo(NewYear24ToyInfo):
    __nyController = dependency.descriptor(INewYearController)

    def getShards(self):
        if not self._shards:
            toyDecayCostConfig = self._lobbyCtx.getServerSettings().getNewYearToyDecayCostConfig()
            self._shards = toyDecayCostConfig.getToyDecayCost(toyDescr=self._descriptor)
        return self._shards

    def getAtmosphere(self):
        if self.__nyController.isMaxAtmosphereLevel():
            return 0
        generalConfig = self._lobbyCtx.getServerSettings().getNewYearGeneralConfig()
        return generalConfig.getAtmPointsForFillingRankToy(self.getID())

    def getToyObject(self):
        return new_year.getObjectByToyType(self.getToyType())