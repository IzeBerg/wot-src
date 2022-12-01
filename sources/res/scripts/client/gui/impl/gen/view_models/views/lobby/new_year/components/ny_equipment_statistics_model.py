from frameworks.wulf import ViewModel

class NyEquipmentStatisticsModel(ViewModel):
    __slots__ = ()

    def __init__(self, properties=3, commands=0):
        super(NyEquipmentStatisticsModel, self).__init__(properties=properties, commands=commands)

    def getEquipmentName(self):
        return self._getString(0)

    def setEquipmentName(self, value):
        self._setString(0, value)

    def getTier(self):
        return self._getNumber(1)

    def setTier(self, value):
        self._setNumber(1, value)

    def getCount(self):
        return self._getNumber(2)

    def setCount(self, value):
        self._setNumber(2, value)

    def _initialize(self):
        super(NyEquipmentStatisticsModel, self)._initialize()
        self._addStringProperty('equipmentName', '')
        self._addNumberProperty('tier', 1)
        self._addNumberProperty('count', 0)