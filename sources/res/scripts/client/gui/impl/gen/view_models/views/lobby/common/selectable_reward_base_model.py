from frameworks.wulf import ViewModel
from gui.impl.gen.view_models.views.lobby.common.selectable_reward_model import SelectableRewardModel

class SelectableRewardBaseModel(ViewModel):
    __slots__ = ()

    def __init__(self, properties=1, commands=0):
        super(SelectableRewardBaseModel, self).__init__(properties=properties, commands=commands)

    @property
    def selectableRewardModel(self):
        return self._getViewModel(0)

    def _initialize(self):
        super(SelectableRewardBaseModel, self)._initialize()
        self._addViewModelProperty('selectableRewardModel', SelectableRewardModel())