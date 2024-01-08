from gui.impl.gen.view_models.views.lobby.comp7.comp7_bonus_model import Comp7BonusModel

class Comp7StyleBonusModel(Comp7BonusModel):
    __slots__ = ()

    def __init__(self, properties=15, commands=0):
        super(Comp7StyleBonusModel, self).__init__(properties=properties, commands=commands)

    def getStyleID(self):
        return self._getNumber(12)

    def setStyleID(self, value):
        self._setNumber(12, value)

    def getBranchID(self):
        return self._getNumber(13)

    def setBranchID(self, value):
        self._setNumber(13, value)

    def getProgressLevel(self):
        return self._getNumber(14)

    def setProgressLevel(self, value):
        self._setNumber(14, value)

    def _initialize(self):
        super(Comp7StyleBonusModel, self)._initialize()
        self._addNumberProperty('styleID', 0)
        self._addNumberProperty('branchID', 0)
        self._addNumberProperty('progressLevel', 0)