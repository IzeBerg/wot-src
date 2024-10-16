from enum import Enum
from frameworks.wulf import Array
from frameworks.wulf import ViewModel
from halloween.gui.impl.gen.view_models.views.common.bonus_item_view_model import BonusItemViewModel

class ArtefactStates(Enum):
    NONE = 'none'
    INPROGRESS = 'inProgress'
    RECIVE = 'recive'
    OPEN = 'open'


class EventMissionTooltipViewModel(ViewModel):
    __slots__ = ()

    def __init__(self, properties=11, commands=0):
        super(EventMissionTooltipViewModel, self).__init__(properties=properties, commands=commands)

    def getIsHangar(self):
        return self._getBool(0)

    def setIsHangar(self, value):
        self._setBool(0, value)

    def getId(self):
        return self._getString(1)

    def setId(self, value):
        self._setString(1, value)

    def getIndex(self):
        return self._getNumber(2)

    def setIndex(self, value):
        self._setNumber(2, value)

    def getName(self):
        return self._getString(3)

    def setName(self, value):
        self._setString(3, value)

    def getRegularArtefactCount(self):
        return self._getNumber(4)

    def setRegularArtefactCount(self, value):
        self._setNumber(4, value)

    def getSkipPrice(self):
        return self._getNumber(5)

    def setSkipPrice(self, value):
        self._setNumber(5, value)

    def getDecodePrice(self):
        return self._getNumber(6)

    def setDecodePrice(self, value):
        self._setNumber(6, value)

    def getRewards(self):
        return self._getArray(7)

    def setRewards(self, value):
        self._setArray(7, value)

    @staticmethod
    def getRewardsType():
        return BonusItemViewModel

    def getEndDate(self):
        return self._getNumber(8)

    def setEndDate(self, value):
        self._setNumber(8, value)

    def getState(self):
        return ArtefactStates(self._getString(9))

    def setState(self, value):
        self._setString(9, value.value)

    def getIsKingReward(self):
        return self._getBool(10)

    def setIsKingReward(self, value):
        self._setBool(10, value)

    def _initialize(self):
        super(EventMissionTooltipViewModel, self)._initialize()
        self._addBoolProperty('isHangar', False)
        self._addStringProperty('id', '')
        self._addNumberProperty('index', 0)
        self._addStringProperty('name', '')
        self._addNumberProperty('regularArtefactCount', 0)
        self._addNumberProperty('skipPrice', 0)
        self._addNumberProperty('decodePrice', 0)
        self._addArrayProperty('rewards', Array())
        self._addNumberProperty('endDate', 0)
        self._addStringProperty('state')
        self._addBoolProperty('isKingReward', False)