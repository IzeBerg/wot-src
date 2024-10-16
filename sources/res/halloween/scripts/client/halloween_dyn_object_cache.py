import typing, ResMgr
from dyn_objects_cache import DynObjectsBase
from helpers import dependency
from skeletons.gui.battle_session import IBattleSessionProvider
from skeletons.dynamic_objects_cache import IBattleDynamicObjectsCache

class HWPrefabs(object):
    SOULS_COLLECTOR = 'hwSoulsCollector'
    ALL = (
     SOULS_COLLECTOR,)


class HWEffects(object):
    PHASE_SWITCH = 'hwPhaseSwitch'
    ALL = (
     PHASE_SWITCH,)


@dependency.replace_none_kwargs(dynamicObjectsCache=IBattleDynamicObjectsCache, battleSession=IBattleSessionProvider)
def getPrefabPath(objID, dynamicObjectsCache=None, battleSession=None):
    return dynamicObjectsCache.getConfig(battleSession.arenaVisitor.getArenaGuiType()).getPrefab(objID)


@dependency.replace_none_kwargs(dynamicObjectsCache=IBattleDynamicObjectsCache, battleSession=IBattleSessionProvider)
def getEffectSection(objID, dynamicObjectsCache=None, battleSession=None):
    return dynamicObjectsCache.getConfig(battleSession.arenaVisitor.getArenaGuiType()).getEffectSection(objID)


class _HalloweenDynObjects(DynObjectsBase):

    def __init__(self):
        super(_HalloweenDynObjects, self).__init__()
        self.__prefabPaths = {}
        self.__effectSections = {}

    def init(self, dataSection):
        if self._initialized:
            return
        for prefabKey in HWPrefabs.ALL:
            self.__prefabPaths[prefabKey] = self.__readPrefab(dataSection, prefabKey)

        for effectKey in HWEffects.ALL:
            self.__effectSections[effectKey] = self.__readEffect(dataSection, effectKey)

        super(_HalloweenDynObjects, self).init(dataSection)

    def destroy(self):
        super(_HalloweenDynObjects, self).clear()
        self.__effectSections.clear()

    def getPrefab(self, key):
        return self.__prefabPaths.get(key, None)

    def getEffectSection(self, key):
        return self.__effectSections.get(key, None)

    @staticmethod
    def __readPrefab(dataSection, key):
        return dataSection[key].readString('prefab')

    @staticmethod
    def __readEffect(dataSection, key):
        return ResMgr.openSection(dataSection[key].readString('effect'))