from frameworks.wulf import Array
from frameworks.wulf import ViewModel

class RestrictionsModel(ViewModel):
    __slots__ = ()

    def __init__(self, properties=1, commands=0):
        super(RestrictionsModel, self).__init__(properties=properties, commands=commands)

    def getAllowedLevels(self):
        return self._getArray(0)

    def setAllowedLevels(self, value):
        self._setArray(0, value)

    @staticmethod
    def getAllowedLevelsType():
        return int

    def _initialize(self):
        super(RestrictionsModel, self)._initialize()
        self._addArrayProperty('allowedLevels', Array())