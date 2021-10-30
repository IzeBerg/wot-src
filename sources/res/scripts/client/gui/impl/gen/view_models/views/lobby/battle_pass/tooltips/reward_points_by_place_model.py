from frameworks.wulf import ViewModel

class RewardPointsByPlaceModel(ViewModel):
    __slots__ = ()

    def __init__(self, properties=2, commands=0):
        super(RewardPointsByPlaceModel, self).__init__(properties=properties, commands=commands)

    def getPlace(self):
        return self._getString(0)

    def setPlace(self, value):
        self._setString(0, value)

    def getPoints(self):
        return self._getNumber(1)

    def setPoints(self, value):
        self._setNumber(1, value)

    def _initialize(self):
        super(RewardPointsByPlaceModel, self)._initialize()
        self._addStringProperty('place', '')
        self._addNumberProperty('points', 0)