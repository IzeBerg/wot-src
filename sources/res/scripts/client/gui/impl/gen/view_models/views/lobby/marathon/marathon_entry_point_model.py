from frameworks.wulf import Array
from frameworks.wulf import ViewModel
from gui.impl.wrappers.user_list_model import UserListModel
from gui.impl.gen.view_models.views.lobby.marathon.base_event_model import BaseEventModel

class MarathonEntryPointModel(ViewModel):
    __slots__ = ('onClick', )
    STATE_MARATHON_DISABLED = -1
    STATE_MARATHON_NOT_STARTED = 0
    STATE_MARATHON_IN_PROGRESS = 1
    STATE_MARATHON_FINISHED = 3

    def __init__(self, properties=19, commands=1):
        super(MarathonEntryPointModel, self).__init__(properties=properties, commands=commands)

    @property
    def progressGrind(self):
        return self._getViewModel(0)

    @property
    def progressPro(self):
        return self._getViewModel(1)

    @property
    def progressPost(self):
        return self._getViewModel(2)

    def getState(self):
        return self._getNumber(3)

    def setState(self, value):
        self._setNumber(3, value)

    def getTimeTillNextState(self):
        return self._getNumber(4)

    def setTimeTillNextState(self, value):
        self._setNumber(4, value)

    def getFormattedTimeTillNextState(self):
        return self._getString(5)

    def setFormattedTimeTillNextState(self, value):
        self._setString(5, value)

    def getCurrentPhase(self):
        return self._getNumber(6)

    def setCurrentPhase(self, value):
        self._setNumber(6, value)

    def getRewardObtained(self):
        return self._getBool(7)

    def setRewardObtained(self, value):
        self._setBool(7, value)

    def getIsPremShopURL(self):
        return self._getBool(8)

    def setIsPremShopURL(self, value):
        self._setBool(8, value)

    def getIsPostProgression(self):
        return self._getBool(9)

    def setIsPostProgression(self, value):
        self._setBool(9, value)

    def getIsVehicleInHangar(self):
        return self._getBool(10)

    def setIsVehicleInHangar(self, value):
        self._setBool(10, value)

    def getIsVehicleStyleInHangar(self):
        return self._getBool(11)

    def setIsVehicleStyleInHangar(self, value):
        self._setBool(11, value)

    def getIsPostQuestDone(self):
        return self._getBool(12)

    def setIsPostQuestDone(self, value):
        self._setBool(12, value)

    def getCurrentPostQuestIndex(self):
        return self._getNumber(13)

    def setCurrentPostQuestIndex(self, value):
        self._setNumber(13, value)

    def getFormattedTimeTillPostQuestFinish(self):
        return self._getString(14)

    def setFormattedTimeTillPostQuestFinish(self, value):
        self._setString(14, value)

    def getDiscount(self):
        return self._getReal(15)

    def setDiscount(self, value):
        self._setReal(15, value)

    def getTokenTemplate(self):
        return self._getString(16)

    def setTokenTemplate(self, value):
        self._setString(16, value)

    def getTokenDoneTemplate(self):
        return self._getString(17)

    def setTokenDoneTemplate(self, value):
        self._setString(17, value)

    def getUserTokens(self):
        return self._getArray(18)

    def setUserTokens(self, value):
        self._setArray(18, value)

    def _initialize(self):
        super(MarathonEntryPointModel, self)._initialize()
        self._addViewModelProperty('progressGrind', UserListModel())
        self._addViewModelProperty('progressPro', UserListModel())
        self._addViewModelProperty('progressPost', UserListModel())
        self._addNumberProperty('state', -1)
        self._addNumberProperty('timeTillNextState', -1)
        self._addStringProperty('formattedTimeTillNextState', '')
        self._addNumberProperty('currentPhase', -1)
        self._addBoolProperty('rewardObtained', False)
        self._addBoolProperty('isPremShopURL', False)
        self._addBoolProperty('isPostProgression', False)
        self._addBoolProperty('isVehicleInHangar', False)
        self._addBoolProperty('isVehicleStyleInHangar', False)
        self._addBoolProperty('isPostQuestDone', False)
        self._addNumberProperty('currentPostQuestIndex', 0)
        self._addStringProperty('formattedTimeTillPostQuestFinish', '')
        self._addRealProperty('discount', 0.0)
        self._addStringProperty('tokenTemplate', '')
        self._addStringProperty('tokenDoneTemplate', '')
        self._addArrayProperty('userTokens', Array())
        self.onClick = self._addCommand('onClick')