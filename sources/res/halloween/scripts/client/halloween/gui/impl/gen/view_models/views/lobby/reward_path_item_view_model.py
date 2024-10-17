from enum import Enum
from frameworks.wulf import Array
from frameworks.wulf import ViewModel
from halloween.gui.impl.gen.view_models.views.common.bonus_item_view_model import BonusItemViewModel

class ArtefactStates(Enum):
    NONE = 'none'
    INPROGRESS = 'inProgress'
    RECIVE = 'recive'
    OPEN = 'open'


class RewardPathItemViewModel(ViewModel):
    __slots__ = ()

    def __init__(self, properties=5, commands=0):
        super(RewardPathItemViewModel, self).__init__(properties=properties, commands=commands)

    def getId(self):
        return self._getString(0)

    def setId(self, value):
        self._setString(0, value)

    def getIndex(self):
        return self._getNumber(1)

    def setIndex(self, value):
        self._setNumber(1, value)

    def getRewards(self):
        return self._getArray(2)

    def setRewards(self, value):
        self._setArray(2, value)

    @staticmethod
    def getRewardsType():
        return BonusItemViewModel

    def getState(self):
        return ArtefactStates(self._getString(3))

    def setState(self, value):
        self._setString(3, value.value)

    def getTypes(self):
        return self._getArray(4)

    def setTypes(self, value):
        self._setArray(4, value)

    @staticmethod
    def getTypesType():
        return unicode

    def _initialize(self):
        super(RewardPathItemViewModel, self)._initialize()
        self._addStringProperty('id', '')
        self._addNumberProperty('index', 0)
        self._addArrayProperty('rewards', Array())
        self._addStringProperty('state')
        self._addArrayProperty('types', Array())