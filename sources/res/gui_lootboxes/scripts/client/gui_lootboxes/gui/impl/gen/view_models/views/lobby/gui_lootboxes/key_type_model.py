from enum import Enum
from frameworks.wulf import ViewModel

class KeyType(Enum):
    SIMPLE = 'simpleKey'
    LOCKPICK = 'lockpick'


class KeyTypeModel(ViewModel):
    __slots__ = ()

    def __init__(self, properties=1, commands=0):
        super(KeyTypeModel, self).__init__(properties=properties, commands=commands)

    def getValue(self):
        return KeyType(self._getString(0))

    def setValue(self, value):
        self._setString(0, value.value)

    def _initialize(self):
        super(KeyTypeModel, self)._initialize()
        self._addStringProperty('value')