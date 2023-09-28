from frameworks.wulf import ViewModel

class CrewTooltipModel(ViewModel):
    __slots__ = ()

    def __init__(self, properties=2, commands=0):
        super(CrewTooltipModel, self).__init__(properties=properties, commands=commands)

    def getCrewGroup(self):
        return self._getString(0)

    def setCrewGroup(self, value):
        self._setString(0, value)

    def getCrewRole(self):
        return self._getString(1)

    def setCrewRole(self, value):
        self._setString(1, value)

    def _initialize(self):
        super(CrewTooltipModel, self)._initialize()
        self._addStringProperty('crewGroup', '')
        self._addStringProperty('crewRole', '')