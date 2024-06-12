from enum import Enum
from frameworks.wulf import ViewModel

class State(Enum):
    ACTIVE = 'active'
    POSTPROGRESSION = 'postProgression'
    BUY = 'buy'
    COMPLETED = 'completed'


class EarlyAccessStateEnum(ViewModel):
    __slots__ = ()

    def __init__(self, properties=0, commands=0):
        super(EarlyAccessStateEnum, self).__init__(properties=properties, commands=commands)

    def _initialize(self):
        super(EarlyAccessStateEnum, self)._initialize()