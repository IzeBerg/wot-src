from frameworks.wulf import ViewModel
from gui.impl.gen.view_models.views.lobby.nation_change.nation_change_tank_slot_model import NationChangeTankSlotModel

class NationChangeScreenModel(ViewModel):
    __slots__ = ('onCloseBtnClick', 'onSwitchBtnClick', 'onCancelBtnClick', 'onHangarBtnClick',
                 'onDogClick')

    def __init__(self, properties=13, commands=5):
        super(NationChangeScreenModel, self).__init__(properties=properties, commands=commands)

    @property
    def currentNation(self):
        return self._getViewModel(0)

    @property
    def targetNation(self):
        return self._getViewModel(1)

    def getCurrentTankLvl(self):
        return self._getString(2)

    def setCurrentTankLvl(self, value):
        self._setString(2, value)

    def getTargetTankLvl(self):
        return self._getString(3)

    def setTargetTankLvl(self, value):
        self._setString(3, value)

    def getCurrentTankType(self):
        return self._getString(4)

    def setCurrentTankType(self, value):
        self._setString(4, value)

    def getTargetTankType(self):
        return self._getString(5)

    def setTargetTankType(self, value):
        self._setString(5, value)

    def getCurrenTankName(self):
        return self._getString(6)

    def setCurrenTankName(self, value):
        self._setString(6, value)

    def getTargetTankName(self):
        return self._getString(7)

    def setTargetTankName(self, value):
        self._setString(7, value)

    def getCurrentNation(self):
        return self._getString(8)

    def setCurrentNation(self, value):
        self._setString(8, value)

    def getTargetNation(self):
        return self._getString(9)

    def setTargetNation(self, value):
        self._setString(9, value)

    def getCurrentTankTooltipHeader(self):
        return self._getString(10)

    def setCurrentTankTooltipHeader(self, value):
        self._setString(10, value)

    def getCurrentTankTooltipBody(self):
        return self._getString(11)

    def setCurrentTankTooltipBody(self, value):
        self._setString(11, value)

    def getIsSlotAnimPlaying(self):
        return self._getBool(12)

    def setIsSlotAnimPlaying(self, value):
        self._setBool(12, value)

    def _initialize(self):
        super(NationChangeScreenModel, self)._initialize()
        self._addViewModelProperty('currentNation', NationChangeTankSlotModel())
        self._addViewModelProperty('targetNation', NationChangeTankSlotModel())
        self._addStringProperty('currentTankLvl', '')
        self._addStringProperty('targetTankLvl', '')
        self._addStringProperty('currentTankType', '')
        self._addStringProperty('targetTankType', '')
        self._addStringProperty('currenTankName', '')
        self._addStringProperty('targetTankName', '')
        self._addStringProperty('currentNation', '')
        self._addStringProperty('targetNation', '')
        self._addStringProperty('currentTankTooltipHeader', '')
        self._addStringProperty('currentTankTooltipBody', '')
        self._addBoolProperty('isSlotAnimPlaying', False)
        self.onCloseBtnClick = self._addCommand('onCloseBtnClick')
        self.onSwitchBtnClick = self._addCommand('onSwitchBtnClick')
        self.onCancelBtnClick = self._addCommand('onCancelBtnClick')
        self.onHangarBtnClick = self._addCommand('onHangarBtnClick')
        self.onDogClick = self._addCommand('onDogClick')