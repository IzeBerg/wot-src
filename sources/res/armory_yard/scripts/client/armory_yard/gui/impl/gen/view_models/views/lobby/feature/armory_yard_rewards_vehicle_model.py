from gui.impl.gen.view_models.common.vehicle_info_model import VehicleInfoModel

class ArmoryYardRewardsVehicleModel(VehicleInfoModel):
    __slots__ = ()

    def __init__(self, properties=11, commands=0):
        super(ArmoryYardRewardsVehicleModel, self).__init__(properties=properties, commands=commands)

    def getIndex(self):
        return self._getNumber(7)

    def setIndex(self, value):
        self._setNumber(7, value)

    def getVehicleImg(self):
        return self._getString(8)

    def setVehicleImg(self, value):
        self._setString(8, value)

    def getTooltipId(self):
        return self._getString(9)

    def setTooltipId(self, value):
        self._setString(9, value)

    def getTooltipContentId(self):
        return self._getString(10)

    def setTooltipContentId(self, value):
        self._setString(10, value)

    def _initialize(self):
        super(ArmoryYardRewardsVehicleModel, self)._initialize()
        self._addNumberProperty('index', 0)
        self._addStringProperty('vehicleImg', '')
        self._addStringProperty('tooltipId', '')
        self._addStringProperty('tooltipContentId', '')