from frameworks.wulf import ViewModel
from gui.impl.gen.view_models.views.lobby.prestige.prestige_emblem_model import PrestigeEmblemModel

class PrestigeProfileTechniqueEmblemModel(ViewModel):
    __slots__ = ()

    def __init__(self, properties=1, commands=0):
        super(PrestigeProfileTechniqueEmblemModel, self).__init__(properties=properties, commands=commands)

    @property
    def emblem(self):
        return self._getViewModel(0)

    @staticmethod
    def getEmblemType():
        return PrestigeEmblemModel

    def _initialize(self):
        super(PrestigeProfileTechniqueEmblemModel, self)._initialize()
        self._addViewModelProperty('emblem', PrestigeEmblemModel())