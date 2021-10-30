from gui.impl.gen.view_models.views.lobby.mode_selector.mode_selector_event_widget_model import ModeSelectorEventWidgetModel
from gui.impl.gen.view_models.views.lobby.mode_selector.mode_selector_normal_card_model import ModeSelectorNormalCardModel

class ModeSelectorEventModel(ModeSelectorNormalCardModel):
    __slots__ = ()

    def __init__(self, properties=21, commands=0):
        super(ModeSelectorEventModel, self).__init__(properties=properties, commands=commands)

    @property
    def widget(self):
        return self._getViewModel(20)

    def _initialize(self):
        super(ModeSelectorEventModel, self)._initialize()
        self._addViewModelProperty('widget', ModeSelectorEventWidgetModel())