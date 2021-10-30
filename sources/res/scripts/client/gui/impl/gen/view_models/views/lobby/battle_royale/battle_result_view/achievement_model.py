from frameworks.wulf import ViewModel

class AchievementModel(ViewModel):
    __slots__ = ()

    def __init__(self, properties=1, commands=0):
        super(AchievementModel, self).__init__(properties=properties, commands=commands)

    def getName(self):
        return self._getString(0)

    def setName(self, value):
        self._setString(0, value)

    def _initialize(self):
        super(AchievementModel, self)._initialize()
        self._addStringProperty('name', '')