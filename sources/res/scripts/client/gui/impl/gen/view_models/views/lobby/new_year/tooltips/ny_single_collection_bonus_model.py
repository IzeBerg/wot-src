from frameworks.wulf import ViewModel

class NySingleCollectionBonusModel(ViewModel):
    __slots__ = ()

    def __init__(self, properties=2, commands=0):
        super(NySingleCollectionBonusModel, self).__init__(properties=properties, commands=commands)

    def getIsEnabled(self):
        return self._getBool(0)

    def setIsEnabled(self, value):
        self._setBool(0, value)

    def getValue(self):
        return self._getReal(1)

    def setValue(self, value):
        self._setReal(1, value)

    def _initialize(self):
        super(NySingleCollectionBonusModel, self)._initialize()
        self._addBoolProperty('isEnabled', False)
        self._addRealProperty('value', 0.0)