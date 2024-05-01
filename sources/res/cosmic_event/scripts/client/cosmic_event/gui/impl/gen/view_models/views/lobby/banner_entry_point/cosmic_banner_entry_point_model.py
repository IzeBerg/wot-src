from enum import Enum
from frameworks.wulf import ViewModel

class State(Enum):
    ACTIVE = 'active'
    DISABLED = 'disabled'
    ENDSOON = 'endSoon'


class PerformanceRiskEnum(Enum):
    LOWRISK = 'lowRisk'
    MEDIUMRISK = 'mediumRisk'
    HIGHRISK = 'highRisk'


class CosmicBannerEntryPointModel(ViewModel):
    __slots__ = ('onOpen', )

    def __init__(self, properties=6, commands=1):
        super(CosmicBannerEntryPointModel, self).__init__(properties=properties, commands=commands)

    def getState(self):
        return State(self._getString(0))

    def setState(self, value):
        self._setString(0, value.value)

    def getIsSingle(self):
        return self._getBool(1)

    def setIsSingle(self, value):
        self._setBool(1, value)

    def getTimestamp(self):
        return self._getNumber(2)

    def setTimestamp(self, value):
        self._setNumber(2, value)

    def getEndTimestamp(self):
        return self._getNumber(3)

    def setEndTimestamp(self, value):
        self._setNumber(3, value)

    def getIsNew(self):
        return self._getBool(4)

    def setIsNew(self, value):
        self._setBool(4, value)

    def getPerformanceRisk(self):
        return PerformanceRiskEnum(self._getString(5))

    def setPerformanceRisk(self, value):
        self._setString(5, value.value)

    def _initialize(self):
        super(CosmicBannerEntryPointModel, self)._initialize()
        self._addStringProperty('state')
        self._addBoolProperty('isSingle', False)
        self._addNumberProperty('timestamp', 0)
        self._addNumberProperty('endTimestamp', 0)
        self._addBoolProperty('isNew', False)
        self._addStringProperty('performanceRisk')
        self.onOpen = self._addCommand('onOpen')