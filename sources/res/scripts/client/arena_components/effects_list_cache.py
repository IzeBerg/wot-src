from arena_component_system.client_arena_component_system import ClientArenaComponent
from helpers import EffectsList

class EffectsListCache(object):

    def __init__(self):
        self.__cache = {}

    def load(self, effectsListName, effectsListDataSection):
        effectsListTimeLine = self.__cache.get(effectsListName)
        if effectsListTimeLine is not None:
            return effectsListTimeLine
        else:
            effectsListTimeLine = EffectsList.effectsFromSection(effectsListDataSection)
            self.__cache[effectsListName] = effectsListTimeLine
            return effectsListTimeLine

    def loadFromRootDataSection(self, effectsListName, effectsListRootDataSection):
        return self.load(effectsListName, effectsListRootDataSection[effectsListName])


class EffectsListCacheComponent(ClientArenaComponent, EffectsListCache):

    def __init__(self, componentSystem):
        ClientArenaComponent.__init__(self, componentSystem)
        EffectsListCache.__init__(self)