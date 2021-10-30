from gui.impl.gen import R
from frameworks.wulf import ViewModel

class OfferBannerModel(ViewModel):
    __slots__ = ('onSelect', 'onClose')

    def __init__(self, properties=4, commands=2):
        super(OfferBannerModel, self).__init__(properties=properties, commands=commands)

    def getTitle(self):
        return self._getResource(0)

    def setTitle(self, value):
        self._setResource(0, value)

    def getName(self):
        return self._getString(1)

    def setName(self, value):
        self._setString(1, value)

    def getDescription(self):
        return self._getString(2)

    def setDescription(self, value):
        self._setString(2, value)

    def getIcon(self):
        return self._getString(3)

    def setIcon(self, value):
        self._setString(3, value)

    def _initialize(self):
        super(OfferBannerModel, self)._initialize()
        self._addResourceProperty('title', R.invalid())
        self._addStringProperty('name', '')
        self._addStringProperty('description', '')
        self._addStringProperty('icon', '')
        self.onSelect = self._addCommand('onSelect')
        self.onClose = self._addCommand('onClose')