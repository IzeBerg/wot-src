from enum import Enum
from frameworks.wulf import ViewModel

class IdleCrewBonusEnum(Enum):
    DISABLED = 'Disabled'
    ENABLED = 'Enabled'
    ACTIVEONCURRENTVEHICLE = 'ActiveOnCurrentVehicle'
    INCOMPATIBLEWITHCURRENTVEHICLE = 'IncompatibleWithCurrentVehicle'
    ACTIVEONANOTHERVEHICLE = 'ActiveOnAnotherVehicle'
    POSTPROGRESSIONREACHED = 'PostProgressionReached'
    INVISIBLE = 'Invisible'


class IdleCrewBonus(ViewModel):
    __slots__ = ()

    def __init__(self, properties=1, commands=0):
        super(IdleCrewBonus, self).__init__(properties=properties, commands=commands)

    def getIdleCrewBonus(self):
        return IdleCrewBonusEnum(self._getString(0))

    def setIdleCrewBonus(self, value):
        self._setString(0, value.value)

    def _initialize(self):
        super(IdleCrewBonus, self)._initialize()
        self._addStringProperty('IdleCrewBonus')