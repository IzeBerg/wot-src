from enum import Enum
from frameworks.wulf import ViewModel

class BankState(Enum):
    AVAILABLE = 'available'
    ACTIVE = 'active'
    DISABLE = 'disable'


class PiggyBankStates(ViewModel):
    __slots__ = ()

    def __init__(self, properties=0, commands=0):
        super(PiggyBankStates, self).__init__(properties=properties, commands=commands)

    def _initialize(self):
        super(PiggyBankStates, self)._initialize()