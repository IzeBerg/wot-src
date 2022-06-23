from gui.impl.gen.view_models.views.battle_royale.battle_results.br_base_view_model import BrBaseViewModel
from gui.impl.gen.view_models.views.battle_royale.battle_results.personal.personal_results_model import PersonalResultsModel

class BattleResultViewModel(BrBaseViewModel):
    __slots__ = ('onHangarBtnClick', 'onCloseBtnClick')

    def __init__(self, properties=3, commands=2):
        super(BattleResultViewModel, self).__init__(properties=properties, commands=commands)

    @property
    def personalResults(self):
        return self._getViewModel(2)

    @staticmethod
    def getPersonalResultsType():
        return PersonalResultsModel

    def _initialize(self):
        super(BattleResultViewModel, self)._initialize()
        self._addViewModelProperty('personalResults', PersonalResultsModel())
        self.onHangarBtnClick = self._addCommand('onHangarBtnClick')
        self.onCloseBtnClick = self._addCommand('onCloseBtnClick')