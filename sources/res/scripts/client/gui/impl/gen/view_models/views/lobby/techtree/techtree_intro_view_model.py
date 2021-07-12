from frameworks.wulf import Array
from frameworks.wulf import ViewModel

class TechtreeIntroViewModel(ViewModel):
    __slots__ = ('onAcceptBtnClick', 'onLinkClick')

    def __init__(self, properties=2, commands=2):
        super(TechtreeIntroViewModel, self).__init__(properties=properties, commands=commands)

    def getBlueprints(self):
        return self._getArray(0)

    def setBlueprints(self, value):
        self._setArray(0, value)

    def getLinkLabel(self):
        return self._getString(1)

    def setLinkLabel(self, value):
        self._setString(1, value)

    def _initialize(self):
        super(TechtreeIntroViewModel, self)._initialize()
        self._addArrayProperty('blueprints', Array())
        self._addStringProperty('linkLabel', '')
        self.onAcceptBtnClick = self._addCommand('onAcceptBtnClick')
        self.onLinkClick = self._addCommand('onLinkClick')