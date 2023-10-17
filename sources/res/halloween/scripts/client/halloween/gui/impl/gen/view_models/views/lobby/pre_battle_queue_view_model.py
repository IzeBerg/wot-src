from gui.impl.gen.view_models.views.selectable_view_model import SelectableViewModel

class PreBattleQueueViewModel(SelectableViewModel):
    __slots__ = ('onExitBattle', 'onEscape')

    def __init__(self, properties=2, commands=4):
        super(PreBattleQueueViewModel, self).__init__(properties=properties, commands=commands)

    def getSelectedDifficultyLevel(self):
        return self._getNumber(0)

    def setSelectedDifficultyLevel(self, value):
        self._setNumber(0, value)

    def getIsExitButtonAvailable(self):
        return self._getBool(1)

    def setIsExitButtonAvailable(self, value):
        self._setBool(1, value)

    def _initialize(self):
        super(PreBattleQueueViewModel, self)._initialize()
        self._addNumberProperty('selectedDifficultyLevel', 0)
        self._addBoolProperty('isExitButtonAvailable', False)
        self.onExitBattle = self._addCommand('onExitBattle')
        self.onEscape = self._addCommand('onEscape')