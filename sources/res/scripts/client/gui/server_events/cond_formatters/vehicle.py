from gui.server_events.cond_formatters.formatters import MissionsBattleConditionsFormatter, EmptyMissionsFormatter

class MissionsVehicleConditionsFormatter(MissionsBattleConditionsFormatter):

    def __init__(self):
        super(MissionsVehicleConditionsFormatter, self).__init__({'customization': _CustomizationFormatter()})


class _CustomizationFormatter(EmptyMissionsFormatter):
    pass