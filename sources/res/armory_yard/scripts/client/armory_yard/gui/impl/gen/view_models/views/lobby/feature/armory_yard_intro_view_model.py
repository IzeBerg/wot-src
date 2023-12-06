from gui.impl.gen.view_models.common.vehicle_info_model import VehicleInfoModel

class ArmoryYardIntroViewModel(VehicleInfoModel):
    __slots__ = ('onClose', 'onContinue', 'onGoBack')

    def __init__(self, properties=11, commands=3):
        super(ArmoryYardIntroViewModel, self).__init__(properties=properties, commands=commands)

    def getStartDate(self):
        return self._getNumber(8)

    def setStartDate(self, value):
        self._setNumber(8, value)

    def getEndDate(self):
        return self._getNumber(9)

    def setEndDate(self, value):
        self._setNumber(9, value)

    def getHasIntroVideoLink(self):
        return self._getBool(10)

    def setHasIntroVideoLink(self, value):
        self._setBool(10, value)

    def _initialize(self):
        super(ArmoryYardIntroViewModel, self)._initialize()
        self._addNumberProperty('startDate', 0)
        self._addNumberProperty('endDate', 0)
        self._addBoolProperty('hasIntroVideoLink', False)
        self.onClose = self._addCommand('onClose')
        self.onContinue = self._addCommand('onContinue')
        self.onGoBack = self._addCommand('onGoBack')