from frameworks.wulf import ViewModel

class PremDashboardHeaderTooltips(ViewModel):
    __slots__ = ()
    TOOLTIP_PERSONAL_RESERVE = 'ttPersonalReserve'
    TOOLTIP_CLAN_RESERVE = 'ttClanReserve'

    def __init__(self, properties=0, commands=0):
        super(PremDashboardHeaderTooltips, self).__init__(properties=properties, commands=commands)

    def _initialize(self):
        super(PremDashboardHeaderTooltips, self)._initialize()