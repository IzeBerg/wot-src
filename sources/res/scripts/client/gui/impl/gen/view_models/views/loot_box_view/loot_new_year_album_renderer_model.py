from gui.impl.gen.view_models.views.loot_box_view.loot_def_renderer_model import LootDefRendererModel

class LootNewYearAlbumRendererModel(LootDefRendererModel):
    __slots__ = ()

    def __init__(self, properties=14, commands=0):
        super(LootNewYearAlbumRendererModel, self).__init__(properties=properties, commands=commands)

    def _initialize(self):
        super(LootNewYearAlbumRendererModel, self)._initialize()