from frameworks.wulf import Array
from frameworks.wulf import ViewModel
from halloween.gui.impl.gen.view_models.views.lobby.bundle_model import BundleModel

class BundleViewModel(ViewModel):
    __slots__ = ('onClose', 'onPurchaseBundle')

    def __init__(self, properties=2, commands=2):
        super(BundleViewModel, self).__init__(properties=properties, commands=commands)

    def getLacksKeys(self):
        return self._getNumber(0)

    def setLacksKeys(self, value):
        self._setNumber(0, value)

    def getBundles(self):
        return self._getArray(1)

    def setBundles(self, value):
        self._setArray(1, value)

    @staticmethod
    def getBundlesType():
        return BundleModel

    def _initialize(self):
        super(BundleViewModel, self)._initialize()
        self._addNumberProperty('lacksKeys', 0)
        self._addArrayProperty('bundles', Array())
        self.onClose = self._addCommand('onClose')
        self.onPurchaseBundle = self._addCommand('onPurchaseBundle')