from enum import Enum
from frameworks.wulf import ViewModel

class SkillType(Enum):
    NEW = 'new'
    LEARNED = 'learned'
    LEARNING = 'learning'
    IRRELEVANT = 'irrelevant'
    POSSIBLE = 'possible'


class CrewWidgetTankmanSkillModel(ViewModel):
    __slots__ = ()

    def __init__(self, properties=3, commands=0):
        super(CrewWidgetTankmanSkillModel, self).__init__(properties=properties, commands=commands)

    def getName(self):
        return self._getString(0)

    def setName(self, value):
        self._setString(0, value)

    def getIcon(self):
        return self._getString(1)

    def setIcon(self, value):
        self._setString(1, value)

    def getType(self):
        return SkillType(self._getString(2))

    def setType(self, value):
        self._setString(2, value.value)

    def _initialize(self):
        super(CrewWidgetTankmanSkillModel, self)._initialize()
        self._addStringProperty('name', '')
        self._addStringProperty('icon', '')
        self._addStringProperty('type')