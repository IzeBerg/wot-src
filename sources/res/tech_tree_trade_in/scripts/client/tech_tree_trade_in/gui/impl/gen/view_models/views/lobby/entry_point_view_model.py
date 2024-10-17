from frameworks.wulf import ViewModel

class EntryPointViewModel(ViewModel):
    __slots__ = ('onClick', )

    def __init__(self, properties=2, commands=1):
        super(EntryPointViewModel, self).__init__(properties=properties, commands=commands)

    def getDateEnd(self):
        return self._getNumber(0)

    def setDateEnd(self, value):
        self._setNumber(0, value)

    def getIsExtended(self):
        return self._getBool(1)

    def setIsExtended(self, value):
        self._setBool(1, value)

    def _initialize(self):
        super(EntryPointViewModel, self)._initialize()
        self._addNumberProperty('dateEnd', 0)
        self._addBoolProperty('isExtended', False)
        self.onClick = self._addCommand('onClick')