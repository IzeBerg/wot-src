from frameworks.wulf import ViewModel

class NyWithRomanNumbersModel(ViewModel):
    __slots__ = ()

    def __init__(self, properties=1, commands=0):
        super(NyWithRomanNumbersModel, self).__init__(properties=properties, commands=commands)

    def getIsRomanNumbersAllowed(self):
        return self._getBool(0)

    def setIsRomanNumbersAllowed(self, value):
        self._setBool(0, value)

    def _initialize(self):
        super(NyWithRomanNumbersModel, self)._initialize()
        self._addBoolProperty('isRomanNumbersAllowed', True)