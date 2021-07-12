from frameworks.wulf import Array
from frameworks.wulf import ViewModel
from gui.impl.gen.view_models.views.lobby.tank_setup.common.specialization_model import SpecializationModel

class SpecializationsModel(ViewModel):
    __slots__ = ()

    def __init__(self, properties=1, commands=0):
        super(SpecializationsModel, self).__init__(properties=properties, commands=commands)

    def getSpecializations(self):
        return self._getArray(0)

    def setSpecializations(self, value):
        self._setArray(0, value)

    def _initialize(self):
        super(SpecializationsModel, self)._initialize()
        self._addArrayProperty('specializations', Array())