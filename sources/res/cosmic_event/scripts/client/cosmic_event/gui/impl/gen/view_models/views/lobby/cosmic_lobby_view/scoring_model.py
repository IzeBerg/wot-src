from enum import Enum
from frameworks.wulf import ViewModel

class ScoringTypeEnum(Enum):
    RAM = 'ram'
    SHOT = 'shot'
    ABILITYHIT = 'abilityHit'
    KILL = 'kill'
    FRAGMENTHOLDERKILL = 'fragmentHolderKill'
    KILLASSIST = 'killAssist'
    ABILITYPICKUP = 'abilityPickup'
    FRAGMENTPICKUP = 'fragmentPickup'
    FRAGMENTCARRYING = 'fragmentCarrying'
    FRAGMENTDELIVERING = 'fragmentDelivering'
    EVACUATION = 'evacuation'


class ScoringModel(ViewModel):
    __slots__ = ()

    def __init__(self, properties=3, commands=0):
        super(ScoringModel, self).__init__(properties=properties, commands=commands)

    def getType(self):
        return ScoringTypeEnum(self._getString(0))

    def setType(self, value):
        self._setString(0, value.value)

    def getEventPoints(self):
        return self._getNumber(1)

    def setEventPoints(self, value):
        self._setNumber(1, value)

    def getCount(self):
        return self._getNumber(2)

    def setCount(self, value):
        self._setNumber(2, value)

    def _initialize(self):
        super(ScoringModel, self)._initialize()
        self._addStringProperty('type')
        self._addNumberProperty('eventPoints', 0)
        self._addNumberProperty('count', 0)