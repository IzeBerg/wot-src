from gui.impl.gen.view_models.views.lobby.post_progression.base_step_model import BaseStepModel
from gui.impl.gen.view_models.views.lobby.vehicle_compare.compare_modification_model import CompareModificationModel

class CompareStepModel(BaseStepModel):
    __slots__ = ()

    def __init__(self, properties=5, commands=0):
        super(CompareStepModel, self).__init__(properties=properties, commands=commands)

    @property
    def modification(self):
        return self._getViewModel(2)

    @staticmethod
    def getModificationType():
        return CompareModificationModel

    def getIsInstalled(self):
        return self._getBool(3)

    def setIsInstalled(self, value):
        self._setBool(3, value)

    def getLevel(self):
        return self._getNumber(4)

    def setLevel(self, value):
        self._setNumber(4, value)

    def _initialize(self):
        super(CompareStepModel, self)._initialize()
        self._addViewModelProperty('modification', CompareModificationModel())
        self._addBoolProperty('isInstalled', False)
        self._addNumberProperty('level', 0)