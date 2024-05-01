from frameworks.wulf import Array
from frameworks.wulf import ViewModel
from cosmic_event.gui.impl.gen.view_models.views.lobby.cosmic_lobby_view.scoring_model import ScoringModel

class CosmicBattleHelpViewModel(ViewModel):
    __slots__ = ()

    def __init__(self, properties=1, commands=0):
        super(CosmicBattleHelpViewModel, self).__init__(properties=properties, commands=commands)

    def getScoring(self):
        return self._getArray(0)

    def setScoring(self, value):
        self._setArray(0, value)

    @staticmethod
    def getScoringType():
        return ScoringModel

    def _initialize(self):
        super(CosmicBattleHelpViewModel, self)._initialize()
        self._addArrayProperty('scoring', Array())