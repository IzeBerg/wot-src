from frameworks.wulf import ViewModel

class MapBoxIntroModel(ViewModel):
    __slots__ = ('onClose', )

    def __init__(self, properties=2, commands=1):
        super(MapBoxIntroModel, self).__init__(properties=properties, commands=commands)

    def getDate(self):
        return self._getNumber(0)

    def setDate(self, value):
        self._setNumber(0, value)

    def getIsActive(self):
        return self._getBool(1)

    def setIsActive(self, value):
        self._setBool(1, value)

    def _initialize(self):
        super(MapBoxIntroModel, self)._initialize()
        self._addNumberProperty('date', 0)
        self._addBoolProperty('isActive', False)
        self.onClose = self._addCommand('onClose')