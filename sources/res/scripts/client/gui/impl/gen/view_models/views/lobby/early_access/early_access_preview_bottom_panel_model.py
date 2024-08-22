from frameworks.wulf import ViewModel

class EarlyAccessPreviewBottomPanelModel(ViewModel):
    __slots__ = ()

    def __init__(self, properties=1, commands=0):
        super(EarlyAccessPreviewBottomPanelModel, self).__init__(properties=properties, commands=commands)

    def getIsBlockedVehicle(self):
        return self._getBool(0)

    def setIsBlockedVehicle(self, value):
        self._setBool(0, value)

    def _initialize(self):
        super(EarlyAccessPreviewBottomPanelModel, self)._initialize()
        self._addBoolProperty('isBlockedVehicle', False)