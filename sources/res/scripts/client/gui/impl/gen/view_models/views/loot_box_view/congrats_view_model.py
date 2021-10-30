from frameworks.wulf import ViewModel

class CongratsViewModel(ViewModel):
    __slots__ = ()
    SHINE_ORANGE_ALIAS = 'ShineAnimUI'
    SHINE_BLUE_ALIAS = 'BlueShineAnimUI'
    ADVANCED_SHINE_ORANGE = 'advancedShine'
    ADVANCED_SHINE_BLUE = 'advancedShineBlue'

    def __init__(self, properties=10, commands=0):
        super(CongratsViewModel, self).__init__(properties=properties, commands=commands)

    def getVehicleIsElite(self):
        return self._getBool(0)

    def setVehicleIsElite(self, value):
        self._setBool(0, value)

    def getShowCongrats(self):
        return self._getBool(1)

    def setShowCongrats(self, value):
        self._setBool(1, value)

    def getVehicleType(self):
        return self._getString(2)

    def setVehicleType(self, value):
        self._setString(2, value)

    def getVehicleLvl(self):
        return self._getString(3)

    def setVehicleLvl(self, value):
        self._setString(3, value)

    def getVehicleName(self):
        return self._getString(4)

    def setVehicleName(self, value):
        self._setString(4, value)

    def getVehicleImage(self):
        return self._getString(5)

    def setVehicleImage(self, value):
        self._setString(5, value)

    def getCongratsType(self):
        return self._getString(6)

    def setCongratsType(self, value):
        self._setString(6, value)

    def getCongratsSourceId(self):
        return self._getString(7)

    def setCongratsSourceId(self, value):
        self._setString(7, value)

    def getShineSwfAlias(self):
        return self._getString(8)

    def setShineSwfAlias(self, value):
        self._setString(8, value)

    def getAdvancedShineName(self):
        return self._getString(9)

    def setAdvancedShineName(self, value):
        self._setString(9, value)

    def _initialize(self):
        super(CongratsViewModel, self)._initialize()
        self._addBoolProperty('vehicleIsElite', False)
        self._addBoolProperty('showCongrats', False)
        self._addStringProperty('vehicleType', '')
        self._addStringProperty('vehicleLvl', '')
        self._addStringProperty('vehicleName', '')
        self._addStringProperty('vehicleImage', '')
        self._addStringProperty('congratsType', '')
        self._addStringProperty('congratsSourceId', '')
        self._addStringProperty('shineSwfAlias', 'ShineAnimUI')
        self._addStringProperty('advancedShineName', 'advancedShine')