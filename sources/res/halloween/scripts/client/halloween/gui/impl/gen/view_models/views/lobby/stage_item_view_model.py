from enum import Enum
from frameworks.wulf import ViewModel

class StageStatus(Enum):
    ACTIVE = 'active'
    LOCKED = 'locked'
    COMPLETED = 'completed'


class StageItemViewModel(ViewModel):
    __slots__ = ()

    def __init__(self, properties=2, commands=0):
        super(StageItemViewModel, self).__init__(properties=properties, commands=commands)

    def getStage(self):
        return self._getNumber(0)

    def setStage(self, value):
        self._setNumber(0, value)

    def getStatus(self):
        return StageStatus(self._getString(1))

    def setStatus(self, value):
        self._setString(1, value.value)

    def _initialize(self):
        super(StageItemViewModel, self)._initialize()
        self._addNumberProperty('stage', 0)
        self._addStringProperty('status')