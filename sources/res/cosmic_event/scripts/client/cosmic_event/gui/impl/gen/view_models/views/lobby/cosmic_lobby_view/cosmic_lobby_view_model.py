from enum import Enum
from frameworks.wulf import Array
from frameworks.wulf import ViewModel
from cosmic_event.gui.impl.gen.view_models.views.lobby.cosmic_lobby_view.announcer_model import AnnouncerModel
from cosmic_event.gui.impl.gen.view_models.views.lobby.cosmic_lobby_view.mission_model import MissionModel
from cosmic_event.gui.impl.gen.view_models.views.lobby.cosmic_lobby_view.progression_model import ProgressionModel
from cosmic_event.gui.impl.gen.view_models.views.lobby.cosmic_lobby_view.scoring_model import ScoringModel
from cosmic_event.gui.impl.gen.view_models.views.lobby.queue_view.queue_view_model import QueueViewModel

class LobbyRouteEnum(Enum):
    MAIN = 'main'
    ARTEFACT = 'artefact'
    UHURA = 'uhura'
    KIRK = 'kirk'
    SPOCK = 'spock'
    MISSIONBRIEF = 'mission_brief'
    QUEUE = 'queue'
    RESEARCH = 'research'


class PerformanceRiskEnum(Enum):
    LOWRISK = 'lowRisk'
    MEDIUMRISK = 'mediumRisk'
    HIGHRISK = 'highRisk'
    VERYHIGHRISK = 'veryHighRisk'


class CosmicLobbyViewModel(ViewModel):
    __slots__ = ('onLobbyRouteChange', 'onClose', 'onAboutEvent', 'onGetRewardsClick')

    def __init__(self, properties=14, commands=4):
        super(CosmicLobbyViewModel, self).__init__(properties=properties, commands=commands)

    @property
    def queue(self):
        return self._getViewModel(0)

    @staticmethod
    def getQueueType():
        return QueueViewModel

    @property
    def announcer(self):
        return self._getViewModel(1)

    @staticmethod
    def getAnnouncerType():
        return AnnouncerModel

    def getFadeOut(self):
        return self._getBool(2)

    def setFadeOut(self, value):
        self._setBool(2, value)

    def getFragmentCount(self):
        return self._getNumber(3)

    def setFragmentCount(self, value):
        self._setNumber(3, value)

    def getFragmentLimit(self):
        return self._getNumber(4)

    def setFragmentLimit(self, value):
        self._setNumber(4, value)

    def getLobbyRoute(self):
        return LobbyRouteEnum(self._getString(5))

    def setLobbyRoute(self, value):
        self._setString(5, value.value)

    def getMissions(self):
        return self._getArray(6)

    def setMissions(self, value):
        self._setArray(6, value)

    @staticmethod
    def getMissionsType():
        return MissionModel

    def getEventPoints(self):
        return self._getNumber(7)

    def setEventPoints(self, value):
        self._setNumber(7, value)

    def getEventPointsLimit(self):
        return self._getNumber(8)

    def setEventPointsLimit(self, value):
        self._setNumber(8, value)

    def getProgression(self):
        return self._getArray(9)

    def setProgression(self, value):
        self._setArray(9, value)

    @staticmethod
    def getProgressionType():
        return ProgressionModel

    def getIsResearchDone(self):
        return self._getBool(10)

    def setIsResearchDone(self, value):
        self._setBool(10, value)

    def getIsVehicleInBattle(self):
        return self._getBool(11)

    def setIsVehicleInBattle(self, value):
        self._setBool(11, value)

    def getScoring(self):
        return self._getArray(12)

    def setScoring(self, value):
        self._setArray(12, value)

    @staticmethod
    def getScoringType():
        return ScoringModel

    def getPerformanceGroup(self):
        return PerformanceRiskEnum(self._getString(13))

    def setPerformanceGroup(self, value):
        self._setString(13, value.value)

    def _initialize(self):
        super(CosmicLobbyViewModel, self)._initialize()
        self._addViewModelProperty('queue', QueueViewModel())
        self._addViewModelProperty('announcer', AnnouncerModel())
        self._addBoolProperty('fadeOut', False)
        self._addNumberProperty('fragmentCount', 0)
        self._addNumberProperty('fragmentLimit', 9)
        self._addStringProperty('lobbyRoute', LobbyRouteEnum.MAIN.value)
        self._addArrayProperty('missions', Array())
        self._addNumberProperty('eventPoints', 0)
        self._addNumberProperty('eventPointsLimit', 0)
        self._addArrayProperty('progression', Array())
        self._addBoolProperty('isResearchDone', False)
        self._addBoolProperty('isVehicleInBattle', False)
        self._addArrayProperty('scoring', Array())
        self._addStringProperty('performanceGroup', PerformanceRiskEnum.MEDIUMRISK.value)
        self.onLobbyRouteChange = self._addCommand('onLobbyRouteChange')
        self.onClose = self._addCommand('onClose')
        self.onAboutEvent = self._addCommand('onAboutEvent')
        self.onGetRewardsClick = self._addCommand('onGetRewardsClick')