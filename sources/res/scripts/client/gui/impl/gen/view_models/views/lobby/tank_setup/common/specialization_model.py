from frameworks.wulf import ViewModel

class SpecializationModel(ViewModel):
    __slots__ = ()
    EMPTY = 'empty'

    def __init__(self, properties=3, commands=0):
        super(SpecializationModel, self).__init__(properties=properties, commands=commands)

    def getName(self):
        return self._getString(0)

    def setName(self, value):
        self._setString(0, value)

    def getIsCorrect(self):
        return self._getBool(1)

    def setIsCorrect(self, value):
        self._setBool(1, value)

    def getIsClickable(self):
        return self._getBool(2)

    def setIsClickable(self, value):
        self._setBool(2, value)

    def _initialize(self):
        super(SpecializationModel, self)._initialize()
        self._addStringProperty('name', '')
        self._addBoolProperty('isCorrect', False)
        self._addBoolProperty('isClickable', False)