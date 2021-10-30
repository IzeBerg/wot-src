from frameworks.wulf import Array
from frameworks.wulf import ViewModel

class SeniorityRewardAwardViewModel(ViewModel):
    __slots__ = ('onCloseAction', 'onOpenBtnClick')

    def __init__(self, properties=4, commands=2):
        super(SeniorityRewardAwardViewModel, self).__init__(properties=properties, commands=commands)

    def getCategory(self):
        return self._getString(0)

    def setCategory(self, value):
        self._setString(0, value)

    def getBonuses(self):
        return self._getArray(1)

    def setBonuses(self, value):
        self._setArray(1, value)

    def getVehicles(self):
        return self._getArray(2)

    def setVehicles(self, value):
        self._setArray(2, value)

    def getSecretBoxAvailable(self):
        return self._getBool(3)

    def setSecretBoxAvailable(self, value):
        self._setBool(3, value)

    def _initialize(self):
        super(SeniorityRewardAwardViewModel, self)._initialize()
        self._addStringProperty('category', '')
        self._addArrayProperty('bonuses', Array())
        self._addArrayProperty('vehicles', Array())
        self._addBoolProperty('secretBoxAvailable', False)
        self.onCloseAction = self._addCommand('onCloseAction')
        self.onOpenBtnClick = self._addCommand('onOpenBtnClick')