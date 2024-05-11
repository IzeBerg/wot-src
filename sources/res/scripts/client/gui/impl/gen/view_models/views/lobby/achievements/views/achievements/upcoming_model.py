from gui.impl.gen.view_models.views.lobby.achievements.advanced_achievement_model import AdvancedAchievementModel

class UpcomingModel(AdvancedAchievementModel):
    __slots__ = ()

    def __init__(self, properties=16, commands=0):
        super(UpcomingModel, self).__init__(properties=properties, commands=commands)

    def getSpecificItemName(self):
        return self._getString(14)

    def setSpecificItemName(self, value):
        self._setString(14, value)

    def getIsResearchable(self):
        return self._getBool(15)

    def setIsResearchable(self, value):
        self._setBool(15, value)

    def _initialize(self):
        super(UpcomingModel, self)._initialize()
        self._addStringProperty('specificItemName', '')
        self._addBoolProperty('isResearchable', False)