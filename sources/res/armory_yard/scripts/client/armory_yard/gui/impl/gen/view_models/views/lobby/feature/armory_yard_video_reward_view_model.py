from gui.impl.gen.view_models.common.vehicle_info_model import VehicleInfoModel

class ArmoryYardVideoRewardViewModel(VehicleInfoModel):
    __slots__ = ('onClose', 'onShowVehicle', 'onVideoStarted')

    def __init__(self, properties=8, commands=3):
        super(ArmoryYardVideoRewardViewModel, self).__init__(properties=properties, commands=commands)

    def getIsWindowAccessible(self):
        return self._getBool(6)

    def setIsWindowAccessible(self, value):
        self._setBool(6, value)

    def getVideoName(self):
        return self._getString(7)

    def setVideoName(self, value):
        self._setString(7, value)

    def _initialize(self):
        super(ArmoryYardVideoRewardViewModel, self)._initialize()
        self._addBoolProperty('isWindowAccessible', True)
        self._addStringProperty('videoName', '')
        self.onClose = self._addCommand('onClose')
        self.onShowVehicle = self._addCommand('onShowVehicle')
        self.onVideoStarted = self._addCommand('onVideoStarted')