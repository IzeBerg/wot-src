from frameworks.wulf import ViewModel

class NationChangeTooltips(ViewModel):
    __slots__ = ()
    TOOLTIP_NC_VEHICLE = 'carouselVehicle'
    TOOLTIP_NC_TANKMAN = 'tankman'
    TOOLTIP_NC_HANGARMODULE = 'nationChangeHangarModule'
    TOOLTIP_NC_HANGARSHELL = 'nationChangeHangarShell'
    TOOLTIP_NC_BATTLEBOOSTER = 'nationChangeBattleBooster'

    def __init__(self, properties=0, commands=0):
        super(NationChangeTooltips, self).__init__(properties=properties, commands=commands)

    def _initialize(self):
        super(NationChangeTooltips, self)._initialize()