from halloween.gui.impl.gen.view_models.views.common.base_team_member_model import BaseTeamMemberModel

class PlayerInfoModel(BaseTeamMemberModel):
    __slots__ = ()

    def __init__(self, properties=13, commands=0):
        super(PlayerInfoModel, self).__init__(properties=properties, commands=commands)

    def getIsKilled(self):
        return self._getBool(11)

    def setIsKilled(self, value):
        self._setBool(11, value)

    def getDifficultyLevel(self):
        return self._getNumber(12)

    def setDifficultyLevel(self, value):
        self._setNumber(12, value)

    def _initialize(self):
        super(PlayerInfoModel, self)._initialize()
        self._addBoolProperty('isKilled', False)
        self._addNumberProperty('difficultyLevel', 0)