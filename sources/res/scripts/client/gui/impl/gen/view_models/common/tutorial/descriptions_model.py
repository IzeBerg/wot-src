from frameworks.wulf import Array
from frameworks.wulf import ViewModel
from gui.impl.gen.view_models.common.tutorial.view_description_model import ViewDescriptionModel

class DescriptionsModel(ViewModel):
    __slots__ = ()

    def __init__(self, properties=1, commands=0):
        super(DescriptionsModel, self).__init__(properties=properties, commands=commands)

    def getViews(self):
        return self._getArray(0)

    def setViews(self, value):
        self._setArray(0, value)

    def _initialize(self):
        super(DescriptionsModel, self)._initialize()
        self._addArrayProperty('views', Array())