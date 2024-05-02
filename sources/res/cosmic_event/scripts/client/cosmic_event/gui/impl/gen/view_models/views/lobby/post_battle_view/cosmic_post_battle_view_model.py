from frameworks.wulf import Array
from frameworks.wulf import ViewModel
from cosmic_event.gui.impl.gen.view_models.views.lobby.cosmic_lobby_view.announcer_model import AnnouncerModel
from cosmic_event.gui.impl.gen.view_models.views.lobby.cosmic_lobby_view.mission_model import MissionModel
from cosmic_event.gui.impl.gen.view_models.views.lobby.post_battle_view.player_entry import PlayerEntry

class CosmicPostBattleViewModel(ViewModel):
    __slots__ = ('onClose', )

    def __init__(self, properties=9, commands=1):
        super(CosmicPostBattleViewModel, self).__init__(properties=properties, commands=commands)

    @property
    def currentPlayerEntry(self):
        return self._getViewModel(0)

    @staticmethod
    def getCurrentPlayerEntryType():
        return PlayerEntry

    @property
    def announcer(self):
        return self._getViewModel(1)

    @staticmethod
    def getAnnouncerType():
        return AnnouncerModel

    def getBattleOverTimestamp(self):
        return self._getNumber(2)

    def setBattleOverTimestamp(self, value):
        self._setNumber(2, value)

    def getTotalPoints(self):
        return self._getNumber(3)

    def setTotalPoints(self, value):
        self._setNumber(3, value)

    def getFragmentsDelivered(self):
        return self._getNumber(4)

    def setFragmentsDelivered(self, value):
        self._setNumber(4, value)

    def getEvacuationPosition(self):
        return self._getNumber(5)

    def setEvacuationPosition(self, value):
        self._setNumber(5, value)

    def getKillAmount(self):
        return self._getNumber(6)

    def setKillAmount(self, value):
        self._setNumber(6, value)

    def getPlayersList(self):
        return self._getArray(7)

    def setPlayersList(self, value):
        self._setArray(7, value)

    @staticmethod
    def getPlayersListType():
        return PlayerEntry

    def getDailyQuests(self):
        return self._getArray(8)

    def setDailyQuests(self, value):
        self._setArray(8, value)

    @staticmethod
    def getDailyQuestsType():
        return MissionModel

    def _initialize(self):
        super(CosmicPostBattleViewModel, self)._initialize()
        self._addViewModelProperty('currentPlayerEntry', PlayerEntry())
        self._addViewModelProperty('announcer', AnnouncerModel())
        self._addNumberProperty('battleOverTimestamp', 0)
        self._addNumberProperty('totalPoints', 0)
        self._addNumberProperty('fragmentsDelivered', 0)
        self._addNumberProperty('evacuationPosition', 0)
        self._addNumberProperty('killAmount', 0)
        self._addArrayProperty('playersList', Array())
        self._addArrayProperty('dailyQuests', Array())
        self.onClose = self._addCommand('onClose')