from collections import defaultdict
import struct, weakref
from debug_utils import LOG_ERROR
from gui.battle_control.battle_constants import CACHE_RECORDS_IDS
from helpers import dependency
from skeletons.gui.battle_session import IBattleSessionProvider
from shared_utils import CONST_CONTAINER

class _Relations(CONST_CONTAINER):
    FRIEND = 1
    IGNORED = 2
    TMP_IGNORED = 4


_MODULE_LIST_SIZE_FORMAT = '<B'
_MODULE_LIST_FORMAT = '{}i'
_MODULE_LIST_RECORD_FORMAT = _MODULE_LIST_SIZE_FORMAT + _MODULE_LIST_FORMAT
_MODULE_LIST_SIZE_LEN = struct.calcsize(_MODULE_LIST_SIZE_FORMAT)
_IGNORE_LIST_SIZE_FORMAT = '<B'
_IGNORE_LIST_FORMAT = '{}L'
_IGNORE_LIST_RECORD_FORMAT = _IGNORE_LIST_SIZE_FORMAT + _IGNORE_LIST_FORMAT
_IGNORE_LIST_SIZE_LEN = struct.calcsize(_IGNORE_LIST_SIZE_FORMAT)
_RELATIONS_SIZE_FORMAT = '<B'
_RELATIONS_KEYS_LIST_FORMAT = '{}L'
_RELATIONS_VALUES_LIST_FORMAT = '{}B'
_IGNORE_LIST_RECORD_FORMAT = _RELATIONS_SIZE_FORMAT + _RELATIONS_KEYS_LIST_FORMAT + _RELATIONS_VALUES_LIST_FORMAT
_RELATIONS_SIZE_LEN = struct.calcsize(_RELATIONS_SIZE_FORMAT)

class AbstractCacheRecord(object):
    sessionProvider = dependency.descriptor(IBattleSessionProvider)

    def __init__(self, cache):
        super(AbstractCacheRecord, self).__init__()
        self.__cache = weakref.proxy(cache)

    @classmethod
    def get(cls):
        return cls.sessionProvider.battleCache.getRecord(cls)

    @classmethod
    def getRecordID(cls):
        raise NotImplementedError

    def unpack(self, record):
        raise NotImplementedError

    def pack(self):
        raise NotImplementedError

    def clear(self):
        pass

    def save(self):
        return self.__cache.save()

    def load(self):
        return self.__cache.load()


class TmpBRProgressionCacheRecord(AbstractCacheRecord):

    def __init__(self, cache):
        super(TmpBRProgressionCacheRecord, self).__init__(cache)
        self._modules = set()

    @classmethod
    def getRecordID(cls):
        return CACHE_RECORDS_IDS.TMP_PROGRESSION

    def addModule(self, value):
        if value not in self._modules:
            self._modules.add(value)
            return True
        return False

    def getModules(self):
        return self._modules

    def pack(self):
        modulesCount = len(self._modules)
        return struct.pack(_MODULE_LIST_RECORD_FORMAT.format(modulesCount), modulesCount, *self._modules)

    def unpack(self, record):
        if record:
            try:
                modulesCount = struct.unpack(_MODULE_LIST_SIZE_FORMAT, record[:_MODULE_LIST_SIZE_LEN])[0]
                if modulesCount > 0:
                    self._modules = set(struct.unpack_from(_MODULE_LIST_FORMAT.format(modulesCount), record, offset=_MODULE_LIST_SIZE_LEN))
            except struct.error as e:
                LOG_ERROR('Could not unpack the following record: ', record, e)

        else:
            self._modules.clear()


class BRInitialModules(TmpBRProgressionCacheRecord):

    @classmethod
    def getRecordID(cls):
        return CACHE_RECORDS_IDS.INITIAL_MODULES


class RelationsCacheRecord(AbstractCacheRecord):

    def __init__(self, cache):
        super(RelationsCacheRecord, self).__init__(cache)
        self.__relations = defaultdict(int)

    @classmethod
    def getRecordID(cls):
        return CACHE_RECORDS_IDS.RELATIONS

    def unpack(self, record):
        if record:
            try:
                count = struct.unpack(_RELATIONS_SIZE_FORMAT, record[:_RELATIONS_SIZE_LEN])[0]
                if count > 0:
                    keys = struct.unpack_from(_RELATIONS_KEYS_LIST_FORMAT.format(count), record, offset=_RELATIONS_SIZE_LEN)
                    values = struct.unpack_from(_RELATIONS_VALUES_LIST_FORMAT.format(count), record, offset=_RELATIONS_SIZE_LEN + struct.calcsize(_RELATIONS_KEYS_LIST_FORMAT.format(count)))
                    self.__relations.clear()
                    self.__relations.update({key:val for key, val in zip(keys, values)})
            except struct.error as e:
                LOG_ERROR('Could not unpack the following record: ', record, e)

        else:
            self.__relations.clear()

    def pack(self):
        amount = len(self.__relations)
        return struct.pack(_IGNORE_LIST_RECORD_FORMAT.format(amount, amount), amount, *(self.__relations.keys() + self.__relations.values()))

    def clear(self):
        self.__relations.clear()

    def addFriend(self, vehicleID):
        return self.__addRelation(vehicleID, _Relations.FRIEND)

    def removeFriend(self, vehicleID):
        return self.__removeRelation(vehicleID, _Relations.FRIEND)

    def isFriend(self, vehicleID):
        return self.__checkRelation(vehicleID, _Relations.FRIEND)

    def addIgnored(self, vehicleID):
        return self.__addRelation(vehicleID, _Relations.IGNORED)

    def removeIgnored(self, vehicleID):
        return self.__removeRelation(vehicleID, _Relations.IGNORED)

    def isIgnored(self, vehicleID):
        return self.__checkRelation(vehicleID, _Relations.IGNORED)

    def addTmpIgnored(self, vehicleID):
        return self.__addRelation(vehicleID, _Relations.TMP_IGNORED)

    def removeTmpIgnored(self, vehicleID):
        return self.__removeRelation(vehicleID, _Relations.TMP_IGNORED)

    def isTmpIgnored(self, vehicleID):
        return self.__checkRelation(vehicleID, _Relations.TMP_IGNORED)

    def __addRelation(self, vehicleID, relationID):
        if not self.__relations[vehicleID] & relationID:
            self.__relations[vehicleID] |= relationID
            return True
        return False

    def __removeRelation(self, vehicleID, relationID):
        if self.__relations[vehicleID] & relationID:
            self.__relations[vehicleID] ^= relationID
            return True
        return False

    def __checkRelation(self, vehicleID, relationID):
        return bool(self.__relations[vehicleID] & relationID)