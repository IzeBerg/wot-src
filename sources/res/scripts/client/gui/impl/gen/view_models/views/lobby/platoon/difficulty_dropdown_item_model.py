from frameworks.wulf import ViewModel

class DifficultyDropdownItemModel(ViewModel):
    __slots__ = ()

    def __init__(self, properties=4, commands=0):
        super(DifficultyDropdownItemModel, self).__init__(properties=properties, commands=commands)

    def getId(self):
        return self._getNumber(0)

    def setId(self, value):
        self._setNumber(0, value)

    def getShowInfoIcon(self):
        return self._getBool(1)

    def setShowInfoIcon(self, value):
        self._setBool(1, value)

    def getLabel(self):
        return self._getString(2)

    def setLabel(self, value):
        self._setString(2, value)

    def getIsDisabled(self):
        return self._getBool(3)

    def setIsDisabled(self, value):
        self._setBool(3, value)

    def _initialize(self):
        super(DifficultyDropdownItemModel, self)._initialize()
        self._addNumberProperty('id', 0)
        self._addBoolProperty('showInfoIcon', False)
        self._addStringProperty('label', '')
        self._addBoolProperty('isDisabled', False)