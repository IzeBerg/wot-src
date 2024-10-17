from frameworks.wulf import ViewModel

class SubcategoryInfoValueViewModel(ViewModel):
    __slots__ = ()

    def __init__(self, properties=2, commands=0):
        super(SubcategoryInfoValueViewModel, self).__init__(properties=properties, commands=commands)

    def getLabel(self):
        return self._getString(0)

    def setLabel(self, value):
        self._setString(0, value)

    def getAmount(self):
        return self._getNumber(1)

    def setAmount(self, value):
        self._setNumber(1, value)

    def _initialize(self):
        super(SubcategoryInfoValueViewModel, self)._initialize()
        self._addStringProperty('label', '')
        self._addNumberProperty('amount', 0)