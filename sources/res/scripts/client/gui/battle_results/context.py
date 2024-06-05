from constants import ARENA_BONUS_TYPE
from gui.shared.utils.decorators import ReprInjector
from arena_bonus_type_caps import ARENA_BONUS_TYPE_CAPS as _CAPS

@ReprInjector.simple(('getArenaUniqueID', 'arenaUniqueID'), ('needToShowImmediately',
                                                             'showImmediately'), ('needToShowIfPosted',
                                                                                  'showIfPosted'), ('resetCache',
                                                                                                    'resetCache'))
class RequestResultsContext(object):
    __slots__ = ('__arenaUniqueID', '__showImmediately', '__showIfPosted', '__resetCache',
                 '__arenaBonusType')

    def __init__(self, arenaUniqueID, arenaBonusType=ARENA_BONUS_TYPE.UNKNOWN, showImmediately=True, showIfPosted=False, resetCache=False):
        super(RequestResultsContext, self).__init__()
        self.__arenaUniqueID = arenaUniqueID
        self.__arenaBonusType = arenaBonusType
        self.__showImmediately = showImmediately
        self.__showIfPosted = showIfPosted
        self.__resetCache = resetCache

    def getArenaUniqueID(self):
        return self.__arenaUniqueID

    def getArenaBonusType(self):
        return self.__arenaBonusType

    def needToShowImmediately(self):
        return self.__showImmediately and not _CAPS.checkAny(self.__arenaBonusType, _CAPS.DONT_SHOW_BATTLE_RESULTS_IMMEDIATELY)

    def needToShowIfPosted(self):
        return self.__showIfPosted

    def resetCache(self):
        return self.__resetCache


@ReprInjector.simple(('getEmblemType', 'type'), ('getUniqueID', 'ids'))
class RequestEmblemContext(object):
    __slots__ = ('__emblemType', '__formationDBID', '__textureID')

    def __init__(self, emblemType, formationDBID, textureID=0):
        super(RequestEmblemContext, self).__init__()
        self.__emblemType = emblemType
        self.__formationDBID = formationDBID
        self.__textureID = textureID

    def getEmblemType(self):
        return self.__emblemType

    def getFormationDBID(self):
        return self.__formationDBID

    def getTextureID(self):
        return self.__textureID

    def getUniqueID(self):
        return (
         self.getEmblemType(), self.__formationDBID)