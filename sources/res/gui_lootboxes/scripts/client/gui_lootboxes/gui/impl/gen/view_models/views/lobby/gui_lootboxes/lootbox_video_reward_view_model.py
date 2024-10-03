from gui.impl.gen import R
from gui.impl.gen.view_models.common.vehicle_info_model import VehicleInfoModel

class LootboxVideoRewardViewModel(VehicleInfoModel):
    __slots__ = ('onClose', 'onVideoStarted')

    def __init__(self, properties=13, commands=2):
        super(LootboxVideoRewardViewModel, self).__init__(properties=properties, commands=commands)

    def getIsWindowAccessible(self):
        return self._getBool(10)

    def setIsWindowAccessible(self, value):
        self._setBool(10, value)

    def getVideoRes(self):
        return self._getResource(11)

    def setVideoRes(self, value):
        self._setResource(11, value)

    def getIsGuaranteedReward(self):
        return self._getBool(12)

    def setIsGuaranteedReward(self, value):
        self._setBool(12, value)

    def _initialize(self):
        super(LootboxVideoRewardViewModel, self)._initialize()
        self._addBoolProperty('isWindowAccessible', True)
        self._addResourceProperty('videoRes', R.invalid())
        self._addBoolProperty('isGuaranteedReward', False)
        self.onClose = self._addCommand('onClose')
        self.onVideoStarted = self._addCommand('onVideoStarted')