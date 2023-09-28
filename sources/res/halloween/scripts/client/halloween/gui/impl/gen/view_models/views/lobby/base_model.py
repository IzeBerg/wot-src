from enum import Enum
from frameworks.wulf import ViewModel

class BaseStateEnum(Enum):
    ENEMYCAPTURED = 'EnemyCaptured'
    PLAYERCAPTURED = 'PlayerCaptured'
    NEUTRAL = 'Neutral'


class BaseModel(ViewModel):
    __slots__ = ()

    def __init__(self, properties=2, commands=0):
        super(BaseModel, self).__init__(properties=properties, commands=commands)

    def getBaseLetter(self):
        return self._getString(0)

    def setBaseLetter(self, value):
        self._setString(0, value)

    def getBaseState(self):
        return BaseStateEnum(self._getString(1))

    def setBaseState(self, value):
        self._setString(1, value.value)

    def _initialize(self):
        super(BaseModel, self)._initialize()
        self._addStringProperty('baseLetter', '')
        self._addStringProperty('baseState')