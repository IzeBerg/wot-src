from gui.impl.gen.view_models.views.lobby.post_progression.dialogs.research_steps_main_content import ResearchStepsMainContent
from gui.impl.gen.view_models.views.lobby.tank_setup.common.deal_panel_model import DealPanelModel
from gui.impl.gen.view_models.windows.full_screen_dialog_window_model import FullScreenDialogWindowModel

class ResearchStepsDialog(FullScreenDialogWindowModel):
    __slots__ = ()

    def __init__(self, properties=12, commands=3):
        super(ResearchStepsDialog, self).__init__(properties=properties, commands=commands)

    @property
    def dealPanel(self):
        return self._getViewModel(10)

    @property
    def mainContent(self):
        return self._getViewModel(11)

    def _initialize(self):
        super(ResearchStepsDialog, self)._initialize()
        self._addViewModelProperty('dealPanel', DealPanelModel())
        self._addViewModelProperty('mainContent', ResearchStepsMainContent())