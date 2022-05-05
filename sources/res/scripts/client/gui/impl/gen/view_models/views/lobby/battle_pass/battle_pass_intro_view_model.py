from gui.impl.gen.view_models.views.lobby.common.base_intro_view_model import BaseIntroViewModel

class BattlePassIntroViewModel(BaseIntroViewModel):
    __slots__ = ()

    def __init__(self, properties=4, commands=3):
        super(BattlePassIntroViewModel, self).__init__(properties=properties, commands=commands)

    def _initialize(self):
        super(BattlePassIntroViewModel, self)._initialize()