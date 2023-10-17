from gui.impl.gen.view_models.views.lobby.prestige.prestige_base_model import PrestigeBaseModel

class PrestigeHangarEntryPointModel(PrestigeBaseModel):
    __slots__ = ('onShowInfo', )

    def __init__(self, properties=3, commands=1):
        super(PrestigeHangarEntryPointModel, self).__init__(properties=properties, commands=commands)

    def _initialize(self):
        super(PrestigeHangarEntryPointModel, self)._initialize()
        self.onShowInfo = self._addCommand('onShowInfo')