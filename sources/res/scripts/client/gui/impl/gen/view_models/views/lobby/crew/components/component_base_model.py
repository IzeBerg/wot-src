from frameworks.wulf import ViewModel

class ComponentBaseModel(ViewModel):
    __slots__ = ()

    def __init__(self, properties=1, commands=0):
        super(ComponentBaseModel, self).__init__(properties=properties, commands=commands)

    def getComponentKey(self):
        return self._getString(0)

    def setComponentKey(self, value):
        self._setString(0, value)

    def _initialize(self):
        super(ComponentBaseModel, self)._initialize()
        self._addStringProperty('componentKey', '')