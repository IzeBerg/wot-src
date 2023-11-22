from gui.impl.gen.view_models.views.lobby.mode_selector.mode_selector_fun_random_widget_model import ModeSelectorFunRandomWidgetModel
from gui.impl.gen.view_models.views.lobby.mode_selector.mode_selector_normal_card_model import ModeSelectorNormalCardModel

class ModeSelectorFunRandomModel(ModeSelectorNormalCardModel):
    __slots__ = ()

    def __init__(self, properties=21, commands=0):
        super(ModeSelectorFunRandomModel, self).__init__(properties=properties, commands=commands)

    @property
    def widget(self):
        return self._getViewModel(20)

    @staticmethod
    def getWidgetType():
        return ModeSelectorFunRandomWidgetModel

    def _initialize(self):
        super(ModeSelectorFunRandomModel, self)._initialize()
        self._addViewModelProperty('widget', ModeSelectorFunRandomWidgetModel())