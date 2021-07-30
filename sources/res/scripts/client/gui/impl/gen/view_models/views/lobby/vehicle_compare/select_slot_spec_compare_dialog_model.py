from gui.impl.gen.view_models.views.lobby.common.select_slot_spec_dialog_content_model import SelectSlotSpecDialogContentModel
from gui.impl.gen.view_models.windows.full_screen_dialog_window_model import FullScreenDialogWindowModel

class SelectSlotSpecCompareDialogModel(FullScreenDialogWindowModel):
    __slots__ = ()

    def __init__(self, properties=11, commands=3):
        super(SelectSlotSpecCompareDialogModel, self).__init__(properties=properties, commands=commands)

    @property
    def mainContent(self):
        return self._getViewModel(10)

    def _initialize(self):
        super(SelectSlotSpecCompareDialogModel, self)._initialize()
        self._addViewModelProperty('mainContent', SelectSlotSpecDialogContentModel())