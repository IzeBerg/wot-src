from historical_battles.gui.impl.gen.view_models.views.common.base_team_member_model import BaseTeamMemberModel

class EventStatsTeamMemberModel(BaseTeamMemberModel):
    __slots__ = ()

    def __init__(self, properties=11, commands=0):
        super(EventStatsTeamMemberModel, self).__init__(properties=properties, commands=commands)

    def _initialize(self):
        super(EventStatsTeamMemberModel, self)._initialize()