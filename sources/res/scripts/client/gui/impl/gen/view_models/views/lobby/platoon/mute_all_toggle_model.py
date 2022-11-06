from frameworks.wulf import ViewModel

class MuteAllToggleModel(ViewModel):
    __slots__ = ('onClick', )

    def __init__(self, properties=4, commands=1):
        super(MuteAllToggleModel, self).__init__(properties=properties, commands=commands)

    def getTooltipHeader(self):
        return self._getString(0)

    def setTooltipHeader(self, value):
        self._setString(0, value)

    def getTooltipBody(self):
        return self._getString(1)

    def setTooltipBody(self, value):
        self._setString(1, value)

    def getIsSelected(self):
        return self._getBool(2)

    def setIsSelected(self, value):
        self._setBool(2, value)

    def getIsVisible(self):
        return self._getBool(3)

    def setIsVisible(self, value):
        self._setBool(3, value)

    def _initialize(self):
        super(MuteAllToggleModel, self)._initialize()
        self._addStringProperty('tooltipHeader', '')
        self._addStringProperty('tooltipBody', '')
        self._addBoolProperty('isSelected', False)
        self._addBoolProperty('isVisible', True)
        self.onClick = self._addCommand('onClick')