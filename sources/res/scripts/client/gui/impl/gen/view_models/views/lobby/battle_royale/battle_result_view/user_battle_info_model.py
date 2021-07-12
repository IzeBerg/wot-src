from gui.impl.gen.view_models.common.user_name_model import UserNameModel

class UserBattleInfoModel(UserNameModel):
    __slots__ = ()

    def __init__(self, properties=14, commands=0):
        super(UserBattleInfoModel, self).__init__(properties=properties, commands=commands)

    def getVehicleName(self):
        return self._getString(9)

    def setVehicleName(self, value):
        self._setString(9, value)

    def getVehicleNation(self):
        return self._getString(10)

    def setVehicleNation(self, value):
        self._setString(10, value)

    def getVehicleLevel(self):
        return self._getNumber(11)

    def setVehicleLevel(self, value):
        self._setNumber(11, value)

    def getDamage(self):
        return self._getNumber(12)

    def setDamage(self, value):
        self._setNumber(12, value)

    def getKills(self):
        return self._getNumber(13)

    def setKills(self, value):
        self._setNumber(13, value)

    def _initialize(self):
        super(UserBattleInfoModel, self)._initialize()
        self._addStringProperty('vehicleName', '')
        self._addStringProperty('vehicleNation', '')
        self._addNumberProperty('vehicleLevel', 1)
        self._addNumberProperty('damage', 0)
        self._addNumberProperty('kills', 0)