from enum import Enum
from frameworks.wulf import Array
from frameworks.wulf import ViewModel

class ArtefactStates(Enum):
    NONE = 'none'
    INPROGRESS = 'inProgress'
    RECIVE = 'recive'
    OPEN = 'open'


class MetaViewModel(ViewModel):
    __slots__ = ('onSkip', 'onDecrypt', 'onView', 'onSlideToNext')

    def __init__(self, properties=9, commands=4):
        super(MetaViewModel, self).__init__(properties=properties, commands=commands)

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

    def getDescription(self):
        return self._getString(3)

    def setDescription(self, value):
        self._setString(3, value)

    def getSkipPrice(self):
        return self._getNumber(4)

    def setSkipPrice(self, value):
        self._setNumber(4, value)

    def getDecodePrice(self):
        return self._getNumber(5)

    def setDecodePrice(self, value):
        self._setNumber(5, value)

    def getKeys(self):
        return self._getNumber(6)

    def setKeys(self, value):
        self._setNumber(6, value)

    def getState(self):
        return ArtefactStates(self._getString(7))

    def setState(self, value):
        self._setString(7, value.value)

    def getTypes(self):
        return self._getArray(8)

    def setTypes(self, value):
        self._setArray(8, value)

    @staticmethod
    def getTypesType():
        return unicode

    def _initialize(self):
        super(MetaViewModel, self)._initialize()
        self._addStringProperty('id', '')
        self._addNumberProperty('index', 0)
        self._addStringProperty('name', '')
        self._addStringProperty('description', '')
        self._addNumberProperty('skipPrice', 0)
        self._addNumberProperty('decodePrice', 0)
        self._addNumberProperty('keys', 0)
        self._addStringProperty('state')
        self._addArrayProperty('types', Array())
        self.onSkip = self._addCommand('onSkip')
        self.onDecrypt = self._addCommand('onDecrypt')
        self.onView = self._addCommand('onView')
        self.onSlideToNext = self._addCommand('onSlideToNext')