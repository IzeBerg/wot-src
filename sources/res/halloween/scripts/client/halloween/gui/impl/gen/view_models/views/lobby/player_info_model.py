from halloween.gui.impl.gen.view_models.views.common.base_team_member_model import BaseTeamMemberModel

class PlayerInfoModel(BaseTeamMemberModel):
    __slots__ = ()

    def __init__(self, properties=12, commands=0):
        super(PlayerInfoModel, self).__init__(properties=properties, commands=commands)

    def getRespCount(self):
        return self._getNumber(11)

    def setRespCount(self, value):
        self._setNumber(11, value)

    def _initialize(self):
        super(PlayerInfoModel, self)._initialize()
        self._addNumberProperty('respCount', 0)