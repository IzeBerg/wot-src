from gui.impl.gen.view_models.views.loot_box_view.congrats_view_model import CongratsViewModel
from gui.impl.gen.view_models.views.loot_box_view.loot_def_renderer_model import LootDefRendererModel

class LootVehicleRendererModel(LootDefRendererModel):
    __slots__ = ()

    def __init__(self, properties=12, commands=0):
        super(LootVehicleRendererModel, self).__init__(properties=properties, commands=commands)

    @property
    def congratsViewModel(self):
        return self._getViewModel(11)

    def _initialize(self):
        super(LootVehicleRendererModel, self)._initialize()
        self._addViewModelProperty('congratsViewModel', CongratsViewModel())