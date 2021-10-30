from gui.impl.gen import R
from gui.impl.gen.view_models.views.loot_box_view.loot_animated_renderer_model import LootAnimatedRendererModel

class LootConversionRendererModel(LootAnimatedRendererModel):
    __slots__ = ()

    def __init__(self, properties=15, commands=0):
        super(LootConversionRendererModel, self).__init__(properties=properties, commands=commands)

    def getIconFrom(self):
        return self._getResource(14)

    def setIconFrom(self, value):
        self._setResource(14, value)

    def _initialize(self):
        super(LootConversionRendererModel, self)._initialize()
        self._addResourceProperty('iconFrom', R.invalid())