from frameworks.wulf import Array
from gui.impl.gen import R
from frameworks.wulf import ViewModel

class DedicationTooltipModel(ViewModel):
    __slots__ = ()

    def __init__(self, properties=4, commands=0):
        super(DedicationTooltipModel, self).__init__(properties=properties, commands=commands)

    def getCurrentGrade(self):
        return self._getNumber(0)

    def setCurrentGrade(self, value):
        self._setNumber(0, value)

    def getGradeValues(self):
        return self._getArray(1)

    def setGradeValues(self, value):
        self._setArray(1, value)

    def getComponentTitle(self):
        return self._getResource(2)

    def setComponentTitle(self, value):
        self._setResource(2, value)

    def getProgressNumberType(self):
        return self._getString(3)

    def setProgressNumberType(self, value):
        self._setString(3, value)

    def _initialize(self):
        super(DedicationTooltipModel, self)._initialize()
        self._addNumberProperty('currentGrade', 0)
        self._addArrayProperty('gradeValues', Array())
        self._addResourceProperty('componentTitle', R.invalid())
        self._addStringProperty('progressNumberType', '')