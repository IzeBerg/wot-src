from enum import IntEnum
from frameworks.wulf import ViewModel
from historical_battles.gui.impl.gen.view_models.views.lobby.progression.progression_view_model import ProgressionViewModel

class MainViews(IntEnum):
    PROGRESSION = 0


class ProgressionMainViewModel(ViewModel):
    __slots__ = ()

    def __init__(self, properties=2, commands=0):
        super(ProgressionMainViewModel, self).__init__(properties=properties, commands=commands)

    @property
    def progressionModel(self):
        return self._getViewModel(0)

    @staticmethod
    def getProgressionModelType():
        return ProgressionViewModel

    def getViewType(self):
        return MainViews(self._getNumber(1))

    def setViewType(self, value):
        self._setNumber(1, value.value)

    def _initialize(self):
        super(ProgressionMainViewModel, self)._initialize()
        self._addViewModelProperty('progressionModel', ProgressionViewModel())
        self._addNumberProperty('viewType')