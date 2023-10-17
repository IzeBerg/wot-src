from enum import Enum
from frameworks.wulf import Array
from frameworks.wulf import ViewModel
from halloween.gui.impl.gen.view_models.views.lobby.bonus_item_view_model import BonusItemViewModel

class ArtefactStates(Enum):
    NONE = 'none'
    INPROGRESS = 'inProgress'
    RECIVE = 'recive'
    OPEN = 'open'


class ArtefactTypes(Enum):
    TEXT = 'text'
    SOUND = 'sound'
    FINAL = 'final'


class ArtefactViewModel(ViewModel):
    __slots__ = ()

    def __init__(self, properties=12, commands=0):
        super(ArtefactViewModel, self).__init__(properties=properties, commands=commands)

    def getId(self):
        return self._getString(0)

    def setId(self, value):
        self._setString(0, value)

    def getQuestName(self):
        return self._getString(1)

    def setQuestName(self, value):
        self._setString(1, value)

    def getQuestDescr(self):
        return self._getString(2)

    def setQuestDescr(self, value):
        self._setString(2, value)

    def getQuestProgress(self):
        return self._getNumber(3)

    def setQuestProgress(self, value):
        self._setNumber(3, value)

    def getQuestMaxProgress(self):
        return self._getNumber(4)

    def setQuestMaxProgress(self, value):
        self._setNumber(4, value)

    def getSkipPrice(self):
        return self._getNumber(5)

    def setSkipPrice(self, value):
        self._setNumber(5, value)

    def getDecodePrice(self):
        return self._getNumber(6)

    def setDecodePrice(self, value):
        self._setNumber(6, value)

    def getDifficulty(self):
        return self._getNumber(7)

    def setDifficulty(self, value):
        self._setNumber(7, value)

    def getIsMoneyEnough(self):
        return self._getNumber(8)

    def setIsMoneyEnough(self, value):
        self._setNumber(8, value)

    def getRewards(self):
        return self._getArray(9)

    def setRewards(self, value):
        self._setArray(9, value)

    @staticmethod
    def getRewardsType():
        return BonusItemViewModel

    def getState(self):
        return ArtefactStates(self._getString(10))

    def setState(self, value):
        self._setString(10, value.value)

    def getTypes(self):
        return self._getArray(11)

    def setTypes(self, value):
        self._setArray(11, value)

    @staticmethod
    def getTypesType():
        return unicode

    def _initialize(self):
        super(ArtefactViewModel, self)._initialize()
        self._addStringProperty('id', '')
        self._addStringProperty('questName', '')
        self._addStringProperty('questDescr', '')
        self._addNumberProperty('questProgress', 0)
        self._addNumberProperty('questMaxProgress', 0)
        self._addNumberProperty('skipPrice', 0)
        self._addNumberProperty('decodePrice', 0)
        self._addNumberProperty('difficulty', 0)
        self._addNumberProperty('isMoneyEnough', 0)
        self._addArrayProperty('rewards', Array())
        self._addStringProperty('state')
        self._addArrayProperty('types', Array())