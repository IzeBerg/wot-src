from frameworks.wulf import ViewModel

class DialogPresets(ViewModel):
    __slots__ = ()
    QUIT_GAME = 'quitGame'
    ERROR = 'error'
    WARNING = 'warning'
    INFO = 'info'
    BLUEPRINTS_CONVERSION = 'blueprintsConversion'
    MAPS_BLACKLIST = 'mapsBlacklist'
    TROPHY_DEVICE_UPGRADE = 'trophyDeviceUpgrade'
    BUY_BATTLE_PASS = 'buyBattlePass'
    CUSTOMIZATION_INSTALL_BOUND = 'customizationInstallBound'
    DEFAULT = 'default'

    def __init__(self, properties=0, commands=0):
        super(DialogPresets, self).__init__(properties=properties, commands=commands)

    def _initialize(self):
        super(DialogPresets, self)._initialize()