from frameworks.wulf import ViewModel

class StyleInfoModel(ViewModel):
    __slots__ = ()

    def __init__(self, properties=2, commands=0):
        super(StyleInfoModel, self).__init__(properties=properties, commands=commands)

    def getStyleName(self):
        return self._getString(0)

    def setStyleName(self, value):
        self._setString(0, value)

    def getStyleId(self):
        return self._getNumber(1)

    def setStyleId(self, value):
        self._setNumber(1, value)

    def _initialize(self):
        super(StyleInfoModel, self)._initialize()
        self._addStringProperty('styleName', '')
        self._addNumberProperty('styleId', 0)