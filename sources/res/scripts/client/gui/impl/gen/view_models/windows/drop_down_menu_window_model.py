from frameworks.wulf import ViewModel

class DropDownMenuWindowModel(ViewModel):
    __slots__ = ()

    def __init__(self, properties=4, commands=0):
        super(DropDownMenuWindowModel, self).__init__(properties=properties, commands=commands)

    def getX(self):
        return self._getReal(0)

    def setX(self, value):
        self._setReal(0, value)

    def getY(self):
        return self._getReal(1)

    def setY(self, value):
        self._setReal(1, value)

    def getTargetWidth(self):
        return self._getReal(2)

    def setTargetWidth(self, value):
        self._setReal(2, value)

    def getTargetHeight(self):
        return self._getReal(3)

    def setTargetHeight(self, value):
        self._setReal(3, value)

    def _initialize(self):
        super(DropDownMenuWindowModel, self)._initialize()
        self._addRealProperty('x', 0.0)
        self._addRealProperty('y', 0.0)
        self._addRealProperty('targetWidth', 0.0)
        self._addRealProperty('targetHeight', 0.0)