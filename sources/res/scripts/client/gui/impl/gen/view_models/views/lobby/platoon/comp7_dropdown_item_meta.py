from frameworks.wulf import ViewModel

class Comp7DropdownItemMeta(ViewModel):
    __slots__ = ()

    def __init__(self, properties=1, commands=0):
        super(Comp7DropdownItemMeta, self).__init__(properties=properties, commands=commands)

    def getTooltipText(self):
        return self._getString(0)

    def setTooltipText(self, value):
        self._setString(0, value)

    def _initialize(self):
        super(Comp7DropdownItemMeta, self)._initialize()
        self._addStringProperty('tooltipText', '')