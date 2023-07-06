from frameworks.wulf import ViewModel

class RandomQuestTooltipModel(ViewModel):
    __slots__ = ()

    def __init__(self, properties=3, commands=0):
        super(RandomQuestTooltipModel, self).__init__(properties=properties, commands=commands)

    def getExpireTime(self):
        return self._getNumber(0)

    def setExpireTime(self, value):
        self._setNumber(0, value)

    def getVehicleName(self):
        return self._getString(1)

    def setVehicleName(self, value):
        self._setString(1, value)

    def getCondition(self):
        return self._getString(2)

    def setCondition(self, value):
        self._setString(2, value)

    def _initialize(self):
        super(RandomQuestTooltipModel, self)._initialize()
        self._addNumberProperty('expireTime', 0)
        self._addStringProperty('vehicleName', '')
        self._addStringProperty('condition', '')