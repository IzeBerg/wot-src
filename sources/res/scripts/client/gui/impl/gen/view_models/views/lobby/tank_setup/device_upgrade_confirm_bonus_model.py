from frameworks.wulf import Array
from frameworks.wulf import ViewModel

class DeviceUpgradeConfirmBonusModel(ViewModel):
    __slots__ = ()

    def __init__(self, properties=2, commands=0):
        super(DeviceUpgradeConfirmBonusModel, self).__init__(properties=properties, commands=commands)

    def getKpiName(self):
        return self._getString(0)

    def setKpiName(self, value):
        self._setString(0, value)

    def getValues(self):
        return self._getArray(1)

    def setValues(self, value):
        self._setArray(1, value)

    def _initialize(self):
        super(DeviceUpgradeConfirmBonusModel, self)._initialize()
        self._addStringProperty('kpiName', '')
        self._addArrayProperty('values', Array())