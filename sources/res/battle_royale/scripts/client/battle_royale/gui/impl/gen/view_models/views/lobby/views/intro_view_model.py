from gui.impl.gen.view_models.views.lobby.common.base_intro_view_model import BaseIntroViewModel

class IntroViewModel(BaseIntroViewModel):
    __slots__ = ()

    def __init__(self, properties=5, commands=3):
        super(IntroViewModel, self).__init__(properties=properties, commands=commands)

    def _initialize(self):
        super(IntroViewModel, self)._initialize()