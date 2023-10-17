from enum import Enum
from frameworks.wulf import ViewModel

class WindowTypeEnum(Enum):
    MEDIUM = 'medium'
    HARD = 'hard'


class DifficultyWindowViewModel(ViewModel):
    __slots__ = ('onClose', )

    def __init__(self, properties=1, commands=1):
        super(DifficultyWindowViewModel, self).__init__(properties=properties, commands=commands)

    def getWindowType(self):
        return WindowTypeEnum(self._getString(0))

    def setWindowType(self, value):
        self._setString(0, value.value)

    def _initialize(self):
        super(DifficultyWindowViewModel, self)._initialize()
        self._addStringProperty('windowType')
        self.onClose = self._addCommand('onClose')