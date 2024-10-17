from enum import Enum
from frameworks.wulf import Array
from frameworks.wulf import ViewModel
from halloween.gui.impl.gen.view_models.views.common.bonus_item_view_model import BonusItemViewModel

class ArtefactTypes(Enum):
    TEXT = 'text'
    SOUND = 'sound'
    FINAL = 'final'


class DecryptViewModel(ViewModel):
    __slots__ = ('onAffirmation', 'onMuted')

    def __init__(self, properties=6, commands=2):
        super(DecryptViewModel, self).__init__(properties=properties, commands=commands)

    def getId(self):
        return self._getString(0)

    def setId(self, value):
        self._setString(0, value)

    def getIndex(self):
        return self._getNumber(1)

    def setIndex(self, value):
        self._setNumber(1, value)

    def getName(self):
        return self._getString(2)

    def setName(self, value):
        self._setString(2, value)

    def getIsMuted(self):
        return self._getBool(3)

    def setIsMuted(self, value):
        self._setBool(3, value)

    def getRewards(self):
        return self._getArray(4)

    def setRewards(self, value):
        self._setArray(4, value)

    @staticmethod
    def getRewardsType():
        return BonusItemViewModel

    def getTypes(self):
        return self._getArray(5)

    def setTypes(self, value):
        self._setArray(5, value)

    @staticmethod
    def getTypesType():
        return unicode

    def _initialize(self):
        super(DecryptViewModel, self)._initialize()
        self._addStringProperty('id', '')
        self._addNumberProperty('index', 0)
        self._addStringProperty('name', '')
        self._addBoolProperty('isMuted', False)
        self._addArrayProperty('rewards', Array())
        self._addArrayProperty('types', Array())
        self.onAffirmation = self._addCommand('onAffirmation')
        self.onMuted = self._addCommand('onMuted')