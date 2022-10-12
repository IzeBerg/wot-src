from frameworks.wulf import ViewModel

class MainRewardModel(ViewModel):
    __slots__ = ()

    def __init__(self, properties=2, commands=0):
        super(MainRewardModel, self).__init__(properties=properties, commands=commands)

    def getImage(self):
        return self._getString(0)

    def setImage(self, value):
        self._setString(0, value)

    def getDescription(self):
        return self._getString(1)

    def setDescription(self, value):
        self._setString(1, value)

    def _initialize(self):
        super(MainRewardModel, self)._initialize()
        self._addStringProperty('image', '')
        self._addStringProperty('description', '')