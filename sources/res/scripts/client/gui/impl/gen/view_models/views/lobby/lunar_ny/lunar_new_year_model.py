from frameworks.wulf import ViewModel
from gui.impl.gen.view_models.views.lobby.lunar_ny.bonuses_model import BonusesModel

class LunarNewYearModel(ViewModel):
    __slots__ = ()

    def __init__(self, properties=1, commands=0):
        super(LunarNewYearModel, self).__init__(properties=properties, commands=commands)

    @property
    def bonuses(self):
        return self._getViewModel(0)

    def _initialize(self):
        super(LunarNewYearModel, self)._initialize()
        self._addViewModelProperty('bonuses', BonusesModel())