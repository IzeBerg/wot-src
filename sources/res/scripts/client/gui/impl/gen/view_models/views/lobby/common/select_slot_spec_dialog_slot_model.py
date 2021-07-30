from frameworks.wulf import ViewModel

class SelectSlotSpecDialogSlotModel(ViewModel):
    __slots__ = ()

    def __init__(self, properties=1, commands=0):
        super(SelectSlotSpecDialogSlotModel, self).__init__(properties=properties, commands=commands)

    def getSpecialization(self):
        return self._getString(0)

    def setSpecialization(self, value):
        self._setString(0, value)

    def _initialize(self):
        super(SelectSlotSpecDialogSlotModel, self)._initialize()
        self._addStringProperty('specialization', '')