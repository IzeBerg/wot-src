from frameworks.wulf import ViewModel

class MapsTrainingVehicleMarkerModel(ViewModel):
    __slots__ = ()

    def __init__(self, properties=1, commands=0):
        super(MapsTrainingVehicleMarkerModel, self).__init__(properties=properties, commands=commands)

    def getTop(self):
        return self._getReal(0)

    def setTop(self, value):
        self._setReal(0, value)

    def _initialize(self):
        super(MapsTrainingVehicleMarkerModel, self)._initialize()
        self._addRealProperty('top', 0.0)