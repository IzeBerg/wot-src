from enum import Enum
from frameworks.wulf import ViewModel

class TaskSwitchType(Enum):
    SKILL = 'skill'
    DILIGENCE = 'diligence'


class ReplacementDialogModel(ViewModel):
    __slots__ = ('onAccept', 'onCancel')

    def __init__(self, properties=3, commands=2):
        super(ReplacementDialogModel, self).__init__(properties=properties, commands=commands)

    def getTaskSwitchType(self):
        return self._getString(0)

    def setTaskSwitchType(self, value):
        self._setString(0, value)

    def getErrorMessage(self):
        return self._getString(1)

    def setErrorMessage(self, value):
        self._setString(1, value)

    def getAvailableReplacements(self):
        return self._getNumber(2)

    def setAvailableReplacements(self, value):
        self._setNumber(2, value)

    def _initialize(self):
        super(ReplacementDialogModel, self)._initialize()
        self._addStringProperty('taskSwitchType', '')
        self._addStringProperty('errorMessage', '')
        self._addNumberProperty('availableReplacements', 0)
        self.onAccept = self._addCommand('onAccept')
        self.onCancel = self._addCommand('onCancel')