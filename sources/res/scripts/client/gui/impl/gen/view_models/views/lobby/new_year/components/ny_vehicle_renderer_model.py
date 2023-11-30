from frameworks.wulf import ViewModel

class NyVehicleRendererModel(ViewModel):
    __slots__ = ()

    def __init__(self, properties=3, commands=0):
        super(NyVehicleRendererModel, self).__init__(properties=properties, commands=commands)

    def getTier(self):
        return self._getNumber(0)

    def setTier(self, value):
        self._setNumber(0, value)

    def getTankType(self):
        return self._getString(1)

    def setTankType(self, value):
        self._setString(1, value)

    def getLongName(self):
        return self._getString(2)

    def setLongName(self, value):
        self._setString(2, value)

    def _initialize(self):
        super(NyVehicleRendererModel, self)._initialize()
        self._addNumberProperty('tier', 0)
        self._addStringProperty('tankType', '')
        self._addStringProperty('longName', '')