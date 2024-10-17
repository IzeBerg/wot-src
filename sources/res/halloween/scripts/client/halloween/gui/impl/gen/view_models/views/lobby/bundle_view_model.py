from enum import Enum
from frameworks.wulf import Array
from frameworks.wulf import ViewModel
from halloween.gui.impl.gen.view_models.views.lobby.bundle_model import BundleModel

class WindowType(Enum):
    KEYWIDGET = 'keyWidget'
    DECRYPT = 'decrypt'
    SKIP = 'skip'


class BundleViewModel(ViewModel):
    __slots__ = ('onClose', 'onPurchase')

    def __init__(self, properties=3, commands=2):
        super(BundleViewModel, self).__init__(properties=properties, commands=commands)

    def getLackOfKeys(self):
        return self._getNumber(0)

    def setLackOfKeys(self, value):
        self._setNumber(0, value)

    def getWindowType(self):
        return WindowType(self._getString(1))

    def setWindowType(self, value):
        self._setString(1, value.value)

    def getBundles(self):
        return self._getArray(2)

    def setBundles(self, value):
        self._setArray(2, value)

    @staticmethod
    def getBundlesType():
        return BundleModel

    def _initialize(self):
        super(BundleViewModel, self)._initialize()
        self._addNumberProperty('lackOfKeys', 0)
        self._addStringProperty('windowType')
        self._addArrayProperty('bundles', Array())
        self.onClose = self._addCommand('onClose')
        self.onPurchase = self._addCommand('onPurchase')