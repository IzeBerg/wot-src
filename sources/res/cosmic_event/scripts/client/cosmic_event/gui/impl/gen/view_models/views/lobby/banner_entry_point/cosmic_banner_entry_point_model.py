from enum import Enum
from frameworks.wulf import ViewModel

class State(Enum):
    ACTIVE = 'active'
    DISABLED = 'disabled'


class CosmicBannerEntryPointModel(ViewModel):
    __slots__ = ('onOpen', )

    def __init__(self, properties=2, commands=1):
        super(CosmicBannerEntryPointModel, self).__init__(properties=properties, commands=commands)

    def getState(self):
        return State(self._getString(0))

    def setState(self, value):
        self._setString(0, value.value)

    def getTimestamp(self):
        return self._getNumber(1)

    def setTimestamp(self, value):
        self._setNumber(1, value)

    def _initialize(self):
        super(CosmicBannerEntryPointModel, self)._initialize()
        self._addStringProperty('state')
        self._addNumberProperty('timestamp', 0)
        self.onOpen = self._addCommand('onOpen')