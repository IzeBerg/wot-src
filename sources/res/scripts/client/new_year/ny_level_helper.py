import logging, typing
from gui.server_events.recruit_helper import getRecruitInfo
from helpers import dependency
from items import new_year
from items.components import ny_constants
from ny_common.GeneralConfig import GeneralConfig
from shared_utils import first
from skeletons.gui.lobby_context import ILobbyContext
from skeletons.gui.server_events import IEventsCache
from skeletons.new_year import INewYearController
if typing.TYPE_CHECKING:
    from gui.server_events.bonuses import SimpleBonus
    from gui.server_events.recruit_helper import _BaseRecruitInfo
_logger = logging.getLogger(__name__)

@dependency.replace_none_kwargs(lobbyCtx=ILobbyContext)
def getNYGeneralConfig(lobbyCtx=None):
    return lobbyCtx.getServerSettings().getNewYearGeneralConfig()


def getLevelIndexes():
    for index in xrange(new_year.MIN_ATMOSPHERE_LVL, new_year.MAX_ATMOSPHERE_LVL + 1):
        yield index


class NewYearAtmospherePresenter(object):
    __nyController = dependency.descriptor(INewYearController)

    @classmethod
    def getLevelProgress(cls):
        generalConfig = getNYGeneralConfig()
        levelProgress, levelTotalPoints = generalConfig.getAtmosphereProgress(cls.getTotalAtmospherePoints())
        return (levelProgress, levelTotalPoints)

    @classmethod
    def getAtmosphereLevelLimits(cls):
        generalConfig = getNYGeneralConfig()
        return generalConfig.getAtmosphereLevelLimits()

    @classmethod
    def getAtmosphereMaxLevelLimit(cls):
        return cls.getAtmosphereLevelLimits()[(-1)]

    @classmethod
    def getPointsLimitByLevel(cls, level):
        limits = cls.getAtmosphereLevelLimits()
        if level <= len(limits):
            return limits[(level - 1)]
        return 0

    @classmethod
    def getTotalAtmospherePoints(cls):
        return cls.__nyController.requester.getAtmPoints()

    @classmethod
    def getLevel(cls):
        generalConfig = getNYGeneralConfig()
        return generalConfig.calculateLevelByPoints(cls.getTotalAtmospherePoints())

    @classmethod
    def getNextLevel(cls):
        level = cls.getLevel()
        if level < cls.getMaxLevel():
            return level + 1
        return level

    @classmethod
    def getReachedLevel(cls):
        return cls.__nyController.requester.getMaxLevel()

    @classmethod
    def getMaxLevel(cls):
        return new_year.MAX_ATMOSPHERE_LVL

    @classmethod
    def isMaxLevel(cls):
        return cls.getMaxLevel() == cls.getLevel()


class LevelInfo(object):
    __slots__ = ('__level', '__bonuses', '__questID', '__tankmanToken', '__tankmanInfo')
    __nyController = dependency.descriptor(INewYearController)
    __eventsCache = dependency.descriptor(IEventsCache)

    def __init__(self, level, quest):
        self.__level = level
        self.__tankmanToken = None
        self.__tankmanInfo = None
        self.__bonuses = []
        self.__questID = quest.getID()
        self.__bonusProcessing(quest)
        return

    def isCurrent(self):
        return self.__level == NewYearAtmospherePresenter.getLevel()

    def isAchieved(self):
        return self.__level <= self.__nyController.requester.getMaxLevel()

    def isLastLevel(self):
        return self.__level == new_year.MAX_ATMOSPHERE_LVL

    def isQuestCompleted(self):
        levelQuest = self.__eventsCache.getQuestByID(self.__questID)
        if levelQuest is None:
            return False
        else:
            return levelQuest.isCompleted()

    def hasTankSlot(self):
        return self.__level >= ny_constants.MIN_TANK_SLOTS_LVL

    def level(self):
        return self.__level

    def hasTankman(self):
        return self.__tankmanToken is not None

    def getTankmanInfo(self):
        if self.__tankmanToken is not None:
            return getRecruitInfo(self.__tankmanToken)
        else:
            return

    def getBonuses(self):
        return self.__bonuses

    def updateBonuses(self):
        if not self.__bonuses:
            self.__bonusProcessing()

    def __bonusProcessing(self, quest=None):
        if quest is None:
            quest = self.__eventsCache.getQuestByID(self.__questID)
        if quest is None:
            return
        else:
            for bonus in quest.getBonuses():
                self.__bonuses.append(bonus)
                if bonus.getName() == 'tmanToken':
                    self.__tankmanToken = first(bonus.getValue().iterkeys())

            return