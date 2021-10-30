from frameworks.wulf import ViewModel

class VehicleTypes(ViewModel):
    __slots__ = ()
    LIGHT_TANK = 'lightTank'
    MEDIUM_TANK = 'mediumTank'
    HEAVY_TANK = 'heavyTank'
    SPG = 'SPG'
    AT_SPG = 'AT-SPG'

    def __init__(self, properties=0, commands=0):
        super(VehicleTypes, self).__init__(properties=properties, commands=commands)

    def _initialize(self):
        super(VehicleTypes, self)._initialize()