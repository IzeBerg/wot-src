from gui.impl.gen.view_models.views.lobby.mode_selector.mode_selector_epic_widget_model import ModeSelectorEpicWidgetModel
from gui.impl.gen.view_models.views.lobby.mode_selector.mode_selector_normal_card_model import ModeSelectorNormalCardModel

class ModeSelectorEpicModel(ModeSelectorNormalCardModel):
    __slots__ = ()

    def __init__(self, properties=22, commands=0):
        super(ModeSelectorEpicModel, self).__init__(properties=properties, commands=commands)

    @property
    def widget(self):
        return self._getViewModel(21)

    @staticmethod
    def getWidgetType():
        return ModeSelectorEpicWidgetModel

    def _initialize(self):
        super(ModeSelectorEpicModel, self)._initialize()
        self._addViewModelProperty('widget', ModeSelectorEpicWidgetModel())