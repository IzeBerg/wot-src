from frameworks.wulf import ViewModel

class TankSetupConstants(ViewModel):
    __slots__ = ()
    OPT_DEVICES = 'optDevices'
    SHELLS = 'shells'
    CONSUMABLES = 'consumables'
    BATTLE_BOOSTERS = 'battleBoosters'
    BATTLE_ABILITIES = 'battleAbilities'
    TOGGLE_SHELLS = 'toggleShells'
    TOGGLE_CAMOUFLAGE = 'toggleCamouflage'
    EMPTY = ''

    def __init__(self, properties=0, commands=0):
        super(TankSetupConstants, self).__init__(properties=properties, commands=commands)

    def _initialize(self):
        super(TankSetupConstants, self)._initialize()