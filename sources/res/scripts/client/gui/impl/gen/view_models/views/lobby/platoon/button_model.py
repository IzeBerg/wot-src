from frameworks.wulf import ViewModel

class ButtonModel(ViewModel):
    __slots__ = ('onClick', )

    def __init__(self, properties=6, commands=1):
        super(ButtonModel, self).__init__(properties=properties, commands=commands)

    def getCaption(self):
        return self._getString(0)

    def setCaption(self, value):
        self._setString(0, value)

    def getIsEnabled(self):
        return self._getBool(1)

    def setIsEnabled(self, value):
        self._setBool(1, value)

    def getDescription(self):
        return self._getString(2)

    def setDescription(self, value):
        self._setString(2, value)

    def getHasTooltip(self):
        return self._getBool(3)

    def setHasTooltip(self, value):
        self._setBool(3, value)

    def getText(self):
        return self._getString(4)

    def setText(self, value):
        self._setString(4, value)

    def getTooltipCaption(self):
        return self._getString(5)

    def setTooltipCaption(self, value):
        self._setString(5, value)

    def _initialize(self):
        super(ButtonModel, self)._initialize()
        self._addStringProperty('caption', '')
        self._addBoolProperty('isEnabled', True)
        self._addStringProperty('description', '')
        self._addBoolProperty('hasTooltip', True)
        self._addStringProperty('text', '')
        self._addStringProperty('tooltipCaption', '')
        self.onClick = self._addCommand('onClick')