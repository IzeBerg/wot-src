from frameworks.wulf import ViewModel

class ScheduleModel(ViewModel):
    __slots__ = ()

    def __init__(self, properties=2, commands=0):
        super(ScheduleModel, self).__init__(properties=properties, commands=commands)

    def getPeriod(self):
        return self._getString(0)

    def setPeriod(self, value):
        self._setString(0, value)

    def getDescription(self):
        return self._getString(1)

    def setDescription(self, value):
        self._setString(1, value)

    def _initialize(self):
        super(ScheduleModel, self)._initialize()
        self._addStringProperty('period', '')
        self._addStringProperty('description', '')