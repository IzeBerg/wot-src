from frameworks.wulf import ViewModel

class MapsTrainingGroupModel(ViewModel):
    __slots__ = ()

    def __init__(self, properties=3, commands=0):
        super(MapsTrainingGroupModel, self).__init__(properties=properties, commands=commands)

    def getGroupId(self):
        return self._getNumber(0)

    def setGroupId(self, value):
        self._setNumber(0, value)

    def getGroupTitle(self):
        return self._getString(1)

    def setGroupTitle(self, value):
        self._setString(1, value)

    def getIsGroupDisabled(self):
        return self._getBool(2)

    def setIsGroupDisabled(self, value):
        self._setBool(2, value)

    def _initialize(self):
        super(MapsTrainingGroupModel, self)._initialize()
        self._addNumberProperty('groupId', 0)
        self._addStringProperty('groupTitle', '')
        self._addBoolProperty('isGroupDisabled', False)