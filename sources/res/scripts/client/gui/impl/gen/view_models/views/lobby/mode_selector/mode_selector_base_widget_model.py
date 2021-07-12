from frameworks.wulf import ViewModel

class ModeSelectorBaseWidgetModel(ViewModel):
    __slots__ = ()

    def __init__(self, properties=1, commands=0):
        super(ModeSelectorBaseWidgetModel, self).__init__(properties=properties, commands=commands)

    def getIsEnabled(self):
        return self._getBool(0)

    def setIsEnabled(self, value):
        self._setBool(0, value)

    def _initialize(self):
        super(ModeSelectorBaseWidgetModel, self)._initialize()
        self._addBoolProperty('isEnabled', False)