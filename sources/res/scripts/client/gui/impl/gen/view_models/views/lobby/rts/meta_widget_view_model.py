from frameworks.wulf import ViewModel

class MetaWidgetViewModel(ViewModel):
    __slots__ = ('onClick', )

    def __init__(self, properties=2, commands=1):
        super(MetaWidgetViewModel, self).__init__(properties=properties, commands=commands)

    def getCurrentCollectionCount(self):
        return self._getNumber(0)

    def setCurrentCollectionCount(self, value):
        self._setNumber(0, value)

    def getTotalCollectionCount(self):
        return self._getNumber(1)

    def setTotalCollectionCount(self, value):
        self._setNumber(1, value)

    def _initialize(self):
        super(MetaWidgetViewModel, self)._initialize()
        self._addNumberProperty('currentCollectionCount', 0)
        self._addNumberProperty('totalCollectionCount', 0)
        self.onClick = self._addCommand('onClick')