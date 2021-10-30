from gui.impl.gen.view_models.views.lobby.post_progression.base_modification_model import BaseModificationModel

class CompareModificationModel(BaseModificationModel):
    __slots__ = ()
    UNDEFINED = -1

    def __init__(self, properties=5, commands=0):
        super(CompareModificationModel, self).__init__(properties=properties, commands=commands)

    def getParentStepId(self):
        return self._getNumber(4)

    def setParentStepId(self, value):
        self._setNumber(4, value)

    def _initialize(self):
        super(CompareModificationModel, self)._initialize()
        self._addNumberProperty('parentStepId', 0)