from frameworks.wulf import ViewModel

class RtsPointsConditionModel(ViewModel):
    __slots__ = ()

    def __init__(self, properties=2, commands=0):
        super(RtsPointsConditionModel, self).__init__(properties=properties, commands=commands)

    def getPoints(self):
        return self._getNumber(0)

    def setPoints(self, value):
        self._setNumber(0, value)

    def getPlaceRange(self):
        return self._getString(1)

    def setPlaceRange(self, value):
        self._setString(1, value)

    def _initialize(self):
        super(RtsPointsConditionModel, self)._initialize()
        self._addNumberProperty('points', 0)
        self._addStringProperty('placeRange', '')