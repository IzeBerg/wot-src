from frameworks.wulf import ViewModel

class ExchangeDialogState(ViewModel):
    __slots__ = ()
    DEFAULT = 'default'
    NOT_POSSIBLE = 'notPossible'
    NOT_REQUIRED = 'notRequired'

    def __init__(self, properties=0, commands=0):
        super(ExchangeDialogState, self).__init__(properties=properties, commands=commands)

    def _initialize(self):
        super(ExchangeDialogState, self)._initialize()