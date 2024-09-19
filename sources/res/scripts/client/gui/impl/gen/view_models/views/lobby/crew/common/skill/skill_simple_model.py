from frameworks.wulf import ViewModel

class SkillSimpleModel(ViewModel):
    __slots__ = ()

    def __init__(self, properties=3, commands=0):
        super(SkillSimpleModel, self).__init__(properties=properties, commands=commands)

    def getName(self):
        return self._getString(0)

    def setName(self, value):
        self._setString(0, value)

    def getIconName(self):
        return self._getString(1)

    def setIconName(self, value):
        self._setString(1, value)

    def getLevel(self):
        return self._getReal(2)

    def setLevel(self, value):
        self._setReal(2, value)

    def _initialize(self):
        super(SkillSimpleModel, self)._initialize()
        self._addStringProperty('name', '')
        self._addStringProperty('iconName', '')
        self._addRealProperty('level', 0.0)