from helpers import dependency
from mixins import Deprecated
from mixins import Quest
from mixins import HasVehiclesList as _HasVehiclesList
from mixins import NoProgressBar
from class_progress import ClassProgressAchievement
from historical import HistoricalAchievement
from nation_specific import NationSpecificAchievement
from rare import RareAchievement
from regular import RegularAchievement
from series import SeriesAchievement
from regular_ext import RegularExtAchievement
from simple_progress import SimpleProgressAchievement
from stage import StageAchievement
from skeletons.gui.server_events import IEventsCache

class DeprecatedAchievement(Deprecated, RegularAchievement):
    pass


class QuestAchievement(Quest, RegularAchievement):
    pass


class DeprecatedClassAchievement(Deprecated, NoProgressBar, ClassProgressAchievement):
    pass


def isRareAchievement(achievement):
    return isinstance(achievement, RareAchievement)


def isSeriesAchievement(achievement):
    return isinstance(achievement, SeriesAchievement)


def achievementHasVehiclesList(achievement):
    return isinstance(achievement, _HasVehiclesList)


def getCompletedPersonalMissionsCount(branch, classifiers):
    eventsCache = dependency.instance(IEventsCache)

    def _filter(quest):
        return quest.isFullCompleted() and quest.getQuestClassifier().classificationAttr in classifiers

    result = 0
    for operation in eventsCache.getPersonalMissions().getOperationsForBranch(branch).itervalues():
        result += len(operation.getQuestsByFilter(_filter))

    return result


__all__ = ('ClassProgressAchievement', 'HistoricalAchievement', 'NationSpecificAchievement',
           'RareAchievement', 'RegularAchievement', 'RegularExtAchievement', 'SeriesAchievement',
           'SimpleProgressAchievement', 'DeprecatedAchievement', 'QuestAchievement',
           'isRareAchievement', 'isSeriesAchievement', 'achievementHasVehiclesList',
           'StageAchievement')