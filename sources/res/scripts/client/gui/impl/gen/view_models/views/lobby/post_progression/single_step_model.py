from frameworks.wulf import Array
from gui.impl.gen.view_models.views.lobby.post_progression.modification_model import ModificationModel
from gui.impl.gen.view_models.views.lobby.post_progression.step_model import StepModel

class SingleStepModel(StepModel):
    __slots__ = ()

    def __init__(self, properties=8, commands=0):
        super(SingleStepModel, self).__init__(properties=properties, commands=commands)

    @property
    def modification(self):
        return self._getViewModel(6)

    def getChildrenIds(self):
        return self._getArray(7)

    def setChildrenIds(self, value):
        self._setArray(7, value)

    def _initialize(self):
        super(SingleStepModel, self)._initialize()
        self._addViewModelProperty('modification', ModificationModel())
        self._addArrayProperty('childrenIds', Array())