from gui.impl.gen import R
from frameworks.wulf import ViewModel

class CraftmachineEntryPointViewModel(ViewModel):
    __slots__ = ('onActionClick', )

    def __init__(self, properties=10, commands=1):
        super(CraftmachineEntryPointViewModel, self).__init__(properties=properties, commands=commands)

    def getTitle(self):
        return self._getString(0)

    def setTitle(self, value):
        self._setString(0, value)

    def getSubTitle(self):
        return self._getString(1)

    def setSubTitle(self, value):
        self._setString(1, value)

    def getStatusDate(self):
        return self._getString(2)

    def setStatusDate(self, value):
        self._setString(2, value)

    def getIconSmall(self):
        return self._getResource(3)

    def setIconSmall(self, value):
        self._setResource(3, value)

    def getIconBig(self):
        return self._getResource(4)

    def setIconBig(self, value):
        self._setResource(4, value)

    def getBgSmallThin(self):
        return self._getResource(5)

    def setBgSmallThin(self, value):
        self._setResource(5, value)

    def getBgSmallWide(self):
        return self._getResource(6)

    def setBgSmallWide(self, value):
        self._setResource(6, value)

    def getBgBigThin(self):
        return self._getResource(7)

    def setBgBigThin(self, value):
        self._setResource(7, value)

    def getBgBigWide(self):
        return self._getResource(8)

    def setBgBigWide(self, value):
        self._setResource(8, value)

    def getEndDate(self):
        return self._getNumber(9)

    def setEndDate(self, value):
        self._setNumber(9, value)

    def _initialize(self):
        super(CraftmachineEntryPointViewModel, self)._initialize()
        self._addStringProperty('title', '')
        self._addStringProperty('subTitle', '')
        self._addStringProperty('statusDate', '')
        self._addResourceProperty('iconSmall', R.invalid())
        self._addResourceProperty('iconBig', R.invalid())
        self._addResourceProperty('bgSmallThin', R.invalid())
        self._addResourceProperty('bgSmallWide', R.invalid())
        self._addResourceProperty('bgBigThin', R.invalid())
        self._addResourceProperty('bgBigWide', R.invalid())
        self._addNumberProperty('endDate', -1)
        self.onActionClick = self._addCommand('onActionClick')