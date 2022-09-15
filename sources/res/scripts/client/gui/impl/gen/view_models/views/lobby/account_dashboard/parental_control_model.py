from frameworks.wulf import ViewModel

class ParentalControlModel(ViewModel):
    __slots__ = ()

    def __init__(self, properties=1, commands=0):
        super(ParentalControlModel, self).__init__(properties=properties, commands=commands)

    def getPopoverContentId(self):
        return self._getNumber(0)

    def setPopoverContentId(self, value):
        self._setNumber(0, value)

    def _initialize(self):
        super(ParentalControlModel, self)._initialize()
        self._addNumberProperty('popoverContentId', 1)