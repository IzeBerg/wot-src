from frameworks.wulf import ViewModel

class WtEventTicketTooltipViewModel(ViewModel):
    __slots__ = ()

    def __init__(self, properties=1, commands=0):
        super(WtEventTicketTooltipViewModel, self).__init__(properties=properties, commands=commands)

    def getQuantity(self):
        return self._getNumber(0)

    def setQuantity(self, value):
        self._setNumber(0, value)

    def _initialize(self):
        super(WtEventTicketTooltipViewModel, self)._initialize()
        self._addNumberProperty('quantity', 0)