from gui.impl.gen.view_models.views.loot_box_view.blueprint_congrats_model import BlueprintCongratsModel
from gui.impl.gen.view_models.views.loot_box_view.loot_animated_renderer_model import LootAnimatedRendererModel

class BlueprintFinalFragmentRendererModel(LootAnimatedRendererModel):
    __slots__ = ()

    def __init__(self, properties=18, commands=0):
        super(BlueprintFinalFragmentRendererModel, self).__init__(properties=properties, commands=commands)

    @property
    def congratsViewModel(self):
        return self._getViewModel(17)

    @staticmethod
    def getCongratsViewModelType():
        return BlueprintCongratsModel

    def _initialize(self):
        super(BlueprintFinalFragmentRendererModel, self)._initialize()
        self._addViewModelProperty('congratsViewModel', BlueprintCongratsModel())