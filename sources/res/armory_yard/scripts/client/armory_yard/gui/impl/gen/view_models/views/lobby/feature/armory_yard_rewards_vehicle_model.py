from gui.impl.gen.view_models.common.vehicle_info_model import VehicleInfoModel

class ArmoryYardRewardsVehicleModel(VehicleInfoModel):
    __slots__ = ()

    def __init__(self, properties=8, commands=0):
        super(ArmoryYardRewardsVehicleModel, self).__init__(properties=properties, commands=commands)

    def getIndex(self):
        return self._getNumber(4)

    def setIndex(self, value):
        self._setNumber(4, value)

    def getVehicleImg(self):
        return self._getString(5)

    def setVehicleImg(self, value):
        self._setString(5, value)

    def getTooltipId(self):
        return self._getString(6)

    def setTooltipId(self, value):
        self._setString(6, value)

    def getTooltipContentId(self):
        return self._getString(7)

    def setTooltipContentId(self, value):
        self._setString(7, value)

    def _initialize(self):
        super(ArmoryYardRewardsVehicleModel, self)._initialize()
        self._addNumberProperty('index', 0)
        self._addStringProperty('vehicleImg', '')
        self._addStringProperty('tooltipId', '')
        self._addStringProperty('tooltipContentId', '')