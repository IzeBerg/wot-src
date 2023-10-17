from frameworks.wulf import Array
from halloween.gui.impl.gen.view_models.views.lobby.style_card_view_model import StyleCardViewModel
from gui.impl.gen.view_models.views.selectable_view_model import SelectableViewModel

class StylesViewModel(SelectableViewModel):
    __slots__ = ('onOpenShop', 'onChangeStyle', 'onBack', 'onExit')

    def __init__(self, properties=3, commands=6):
        super(StylesViewModel, self).__init__(properties=properties, commands=commands)

    def getSelectedStyleId(self):
        return self._getString(0)

    def setSelectedStyleId(self, value):
        self._setString(0, value)

    def getIsEvent(self):
        return self._getBool(1)

    def setIsEvent(self, value):
        self._setBool(1, value)

    def getStyles(self):
        return self._getArray(2)

    def setStyles(self, value):
        self._setArray(2, value)

    @staticmethod
    def getStylesType():
        return StyleCardViewModel

    def _initialize(self):
        super(StylesViewModel, self)._initialize()
        self._addStringProperty('selectedStyleId', '')
        self._addBoolProperty('isEvent', False)
        self._addArrayProperty('styles', Array())
        self.onOpenShop = self._addCommand('onOpenShop')
        self.onChangeStyle = self._addCommand('onChangeStyle')
        self.onBack = self._addCommand('onBack')
        self.onExit = self._addCommand('onExit')