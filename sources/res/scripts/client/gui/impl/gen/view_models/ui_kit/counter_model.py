from frameworks.wulf import ViewModel

class CounterModel(ViewModel):
    __slots__ = ()

    def __init__(self, properties=1, commands=0):
        super(CounterModel, self).__init__(properties=properties, commands=commands)

    def getValue(self):
        return self._getNumber(0)

    def setValue(self, value):
        self._setNumber(0, value)

    def _initialize(self):
        super(CounterModel, self)._initialize()
        self._addNumberProperty('value', -1)