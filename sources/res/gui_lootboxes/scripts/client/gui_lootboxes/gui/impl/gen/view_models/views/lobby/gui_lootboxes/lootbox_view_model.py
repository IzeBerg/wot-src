from frameworks.wulf import Array
from gui.impl.gen import R
from frameworks.wulf import ViewModel

class LootboxViewModel(ViewModel):
    __slots__ = ()

    def __init__(self, properties=10, commands=0):
        super(LootboxViewModel, self).__init__(properties=properties, commands=commands)

    def getBoxID(self):
        return self._getNumber(0)

    def setBoxID(self, value):
        self._setNumber(0, value)

    def getBoxType(self):
        return self._getString(1)

    def setBoxType(self, value):
        self._setString(1, value)

    def getCount(self):
        return self._getNumber(2)

    def setCount(self, value):
        self._setNumber(2, value)

    def getTier(self):
        return self._getNumber(3)

    def setTier(self, value):
        self._setNumber(3, value)

    def getIsOpenEnabled(self):
        return self._getBool(4)

    def setIsOpenEnabled(self, value):
        self._setBool(4, value)

    def getIconName(self):
        return self._getString(5)

    def setIconName(self, value):
        self._setString(5, value)

    def getUserName(self):
        return self._getString(6)

    def setUserName(self, value):
        self._setString(6, value)

    def getDescriptionKey(self):
        return self._getString(7)

    def setDescriptionKey(self, value):
        self._setString(7, value)

    def getVideoRes(self):
        return self._getResource(8)

    def setVideoRes(self, value):
        self._setResource(8, value)

    def getBonusGroups(self):
        return self._getArray(9)

    def setBonusGroups(self, value):
        self._setArray(9, value)

    @staticmethod
    def getBonusGroupsType():
        return unicode

    def _initialize(self):
        super(LootboxViewModel, self)._initialize()
        self._addNumberProperty('boxID', 0)
        self._addStringProperty('boxType', 'unknown')
        self._addNumberProperty('count', 0)
        self._addNumberProperty('tier', 0)
        self._addBoolProperty('isOpenEnabled', True)
        self._addStringProperty('iconName', 'unknown')
        self._addStringProperty('userName', 'unknown')
        self._addStringProperty('descriptionKey', 'unknown')
        self._addResourceProperty('videoRes', R.invalid())
        self._addArrayProperty('bonusGroups', Array())