from frameworks.wulf import Array
from gui.impl.gen import R
from frameworks.wulf import ViewModel
from gui.impl.gen.view_models.views.lobby.new_year.components.ny_popover_decoration_slot_model import NyPopoverDecorationSlotModel

class NyDecorationsPopoverModel(ViewModel):
    __slots__ = ('onApplySelection', 'onBreakSelection', 'onIsNewStateChanged', 'onBreakBtnClick',
                 'onNeedMoreClick', 'onBreakAnimationComplete')
    EMPTY_STATE = 0
    BREAK_INFO_STATE = 1
    RECEIVE_INFO_STATE = 2
    BREAK_STATE = 3

    def __init__(self, properties=10, commands=6):
        super(NyDecorationsPopoverModel, self).__init__(properties=properties, commands=commands)

    def getTitle(self):
        return self._getResource(0)

    def setTitle(self, value):
        self._setResource(0, value)

    def getSetting(self):
        return self._getResource(1)

    def setSetting(self, value):
        self._setResource(1, value)

    def getDecorationTypeIcon(self):
        return self._getResource(2)

    def setDecorationTypeIcon(self, value):
        self._setResource(2, value)

    def getDecorationType(self):
        return self._getString(3)

    def setDecorationType(self, value):
        self._setString(3, value)

    def getExpectedShardsCount(self):
        return self._getNumber(4)

    def setExpectedShardsCount(self, value):
        self._setNumber(4, value)

    def getIsBreakAnimationEnabled(self):
        return self._getBool(5)

    def setIsBreakAnimationEnabled(self, value):
        self._setBool(5, value)

    def getState(self):
        return self._getNumber(6)

    def setState(self, value):
        self._setNumber(6, value)

    def getSlots(self):
        return self._getArray(7)

    def setSlots(self, value):
        self._setArray(7, value)

    def getAppliedSelections(self):
        return self._getArray(8)

    def setAppliedSelections(self, value):
        self._setArray(8, value)

    def getBreakSelections(self):
        return self._getArray(9)

    def setBreakSelections(self, value):
        self._setArray(9, value)

    def _initialize(self):
        super(NyDecorationsPopoverModel, self)._initialize()
        self._addResourceProperty('title', R.invalid())
        self._addResourceProperty('setting', R.invalid())
        self._addResourceProperty('decorationTypeIcon', R.invalid())
        self._addStringProperty('decorationType', '')
        self._addNumberProperty('expectedShardsCount', 0)
        self._addBoolProperty('isBreakAnimationEnabled', False)
        self._addNumberProperty('state', -1)
        self._addArrayProperty('slots', Array())
        self._addArrayProperty('appliedSelections', Array())
        self._addArrayProperty('breakSelections', Array())
        self.onApplySelection = self._addCommand('onApplySelection')
        self.onBreakSelection = self._addCommand('onBreakSelection')
        self.onIsNewStateChanged = self._addCommand('onIsNewStateChanged')
        self.onBreakBtnClick = self._addCommand('onBreakBtnClick')
        self.onNeedMoreClick = self._addCommand('onNeedMoreClick')
        self.onBreakAnimationComplete = self._addCommand('onBreakAnimationComplete')