from enum import Enum
from frameworks.wulf import ViewModel

class RoleEnum(Enum):
    HELPER = 'helper'
    INITIATOR = 'initiator'
    UNIVERSAL = 'universal'


class CharacteristicTooltipModel(ViewModel):
    __slots__ = ()

    def __init__(self, properties=1, commands=0):
        super(CharacteristicTooltipModel, self).__init__(properties=properties, commands=commands)

    def getRole(self):
        return RoleEnum(self._getString(0))

    def setRole(self, value):
        self._setString(0, value.value)

    def _initialize(self):
        super(CharacteristicTooltipModel, self)._initialize()
        self._addStringProperty('role')