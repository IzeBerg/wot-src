from enum import IntEnum
from frameworks.wulf import Array
from frameworks.wulf import ViewModel

class TabID(IntEnum):
    NONE = 0
    VEHICLE = 1
    STYLE = 2
    BASE_VEHICLE = 3
    PERSONAL_NUMBER_VEHICLE = 4


class TopPanelTabsModel(ViewModel):
    __slots__ = ('onTabChanged', )

    def __init__(self, properties=3, commands=1):
        super(TopPanelTabsModel, self).__init__(properties=properties, commands=commands)

    def getTabIDs(self):
        return self._getArray(0)

    def setTabIDs(self, value):
        self._setArray(0, value)

    def getTabCustomNames(self):
        return self._getArray(1)

    def setTabCustomNames(self, value):
        self._setArray(1, value)

    def getCurrentTabID(self):
        return TabID(self._getNumber(2))

    def setCurrentTabID(self, value):
        self._setNumber(2, value.value)

    def _initialize(self):
        super(TopPanelTabsModel, self)._initialize()
        self._addArrayProperty('tabIDs', Array())
        self._addArrayProperty('tabCustomNames', Array())
        self._addNumberProperty('currentTabID')
        self.onTabChanged = self._addCommand('onTabChanged')