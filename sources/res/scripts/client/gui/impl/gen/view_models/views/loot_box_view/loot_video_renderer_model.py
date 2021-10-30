from gui.impl.gen.view_models.views.loot_box_view.loot_def_renderer_model import LootDefRendererModel

class LootVideoRendererModel(LootDefRendererModel):
    __slots__ = ()

    def __init__(self, properties=12, commands=0):
        super(LootVideoRendererModel, self).__init__(properties=properties, commands=commands)

    def getVideoSrc(self):
        return self._getString(11)

    def setVideoSrc(self, value):
        self._setString(11, value)

    def _initialize(self):
        super(LootVideoRendererModel, self)._initialize()
        self._addStringProperty('videoSrc', '')