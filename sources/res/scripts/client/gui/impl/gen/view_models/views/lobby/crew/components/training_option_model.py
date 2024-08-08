from gui.impl.gen.view_models.views.lobby.crew.components.component_base_model import ComponentBaseModel

class TrainingOptionModel(ComponentBaseModel):
    __slots__ = ('onSelected', 'onValueUpdated')

    def __init__(self, properties=3, commands=2):
        super(TrainingOptionModel, self).__init__(properties=properties, commands=commands)

    def getIsEligibleForBuy(self):
        return self._getBool(1)

    def setIsEligibleForBuy(self, value):
        self._setBool(1, value)

    def getIsPersonal(self):
        return self._getBool(2)

    def setIsPersonal(self, value):
        self._setBool(2, value)

    def _initialize(self):
        super(TrainingOptionModel, self)._initialize()
        self._addBoolProperty('isEligibleForBuy', False)
        self._addBoolProperty('isPersonal', False)
        self.onSelected = self._addCommand('onSelected')
        self.onValueUpdated = self._addCommand('onValueUpdated')