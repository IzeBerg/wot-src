from gui.impl.gen import R
from frameworks.wulf import ViewModel

class FragmentItemModel(ViewModel):
    __slots__ = ()

    def __init__(self, properties=4, commands=0):
        super(FragmentItemModel, self).__init__(properties=properties, commands=commands)

    def getValue(self):
        return self._getString(0)

    def setValue(self, value):
        self._setString(0, value)

    def getIcon(self):
        return self._getResource(1)

    def setIcon(self, value):
        self._setResource(1, value)

    def getFragmentCD(self):
        return self._getNumber(2)

    def setFragmentCD(self, value):
        self._setNumber(2, value)

    def getSpecialIcon(self):
        return self._getResource(3)

    def setSpecialIcon(self, value):
        self._setResource(3, value)

    def _initialize(self):
        super(FragmentItemModel, self)._initialize()
        self._addStringProperty('value', '--')
        self._addResourceProperty('icon', R.invalid())
        self._addNumberProperty('fragmentCD', 0)
        self._addResourceProperty('specialIcon', R.invalid())