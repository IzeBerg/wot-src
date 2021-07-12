from gui.impl.gen.view_models.views.lobby.premacc.daily_experience_base_model import DailyExperienceBaseModel

class PremDashboardDoubleExperienceCardModel(DailyExperienceBaseModel):
    __slots__ = ('onGoToDoubleExpView', )

    def __init__(self, properties=5, commands=1):
        super(PremDashboardDoubleExperienceCardModel, self).__init__(properties=properties, commands=commands)

    def getIsAvailable(self):
        return self._getBool(4)

    def setIsAvailable(self, value):
        self._setBool(4, value)

    def _initialize(self):
        super(PremDashboardDoubleExperienceCardModel, self)._initialize()
        self._addBoolProperty('isAvailable', True)
        self.onGoToDoubleExpView = self._addCommand('onGoToDoubleExpView')