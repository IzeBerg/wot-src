from gui.impl.gen.view_models.views.loot_box_view.loot_def_renderer_model import LootDefRendererModel

class LootNewYearFragmentsRendererModel(LootDefRendererModel):
    __slots__ = ()

    def __init__(self, properties=15, commands=0):
        super(LootNewYearFragmentsRendererModel, self).__init__(properties=properties, commands=commands)

    def getCount(self):
        return self._getNumber(14)

    def setCount(self, value):
        self._setNumber(14, value)

    def _initialize(self):
        super(LootNewYearFragmentsRendererModel, self)._initialize()
        self._addNumberProperty('count', 0)