from historical_battles.gui.impl.gen.view_models.views.common.base_team_member_model import BaseTeamMemberModel

class BattleResultTeamMemberModel(BaseTeamMemberModel):
    __slots__ = ()

    def __init__(self, properties=11, commands=0):
        super(BattleResultTeamMemberModel, self).__init__(properties=properties, commands=commands)

    def _initialize(self):
        super(BattleResultTeamMemberModel, self)._initialize()