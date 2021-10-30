from gui.impl.gen import R
from frameworks.wulf import ViewModel

class ValuePrice(ViewModel):
    __slots__ = ()
    CUSTOM = 'custom'
    CREDITS = 'credits'
    GOLD = 'gold'
    EXP = 'exp'
    FREE_XP = 'freeXP'
    CRYSTAL = 'crystal'

    def __init__(self, properties=4, commands=0):
        super(ValuePrice, self).__init__(properties=properties, commands=commands)

    def getValue(self):
        return self._getString(0)

    def setValue(self, value):
        self._setString(0, value)

    def getType(self):
        return self._getString(1)

    def setType(self, value):
        self._setString(1, value)

    def getIcon(self):
        return self._getResource(2)

    def setIcon(self, value):
        self._setResource(2, value)

    def getNotEnough(self):
        return self._getBool(3)

    def setNotEnough(self, value):
        self._setBool(3, value)

    def _initialize(self):
        super(ValuePrice, self)._initialize()
        self._addStringProperty('value', '0')
        self._addStringProperty('type', 'custom')
        self._addResourceProperty('icon', R.invalid())
        self._addBoolProperty('notEnough', False)