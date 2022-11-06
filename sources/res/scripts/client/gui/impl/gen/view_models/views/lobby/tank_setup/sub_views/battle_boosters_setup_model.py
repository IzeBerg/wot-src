from frameworks.wulf import Array
from gui.impl.gen.view_models.views.lobby.tank_setup.sub_views.base_setup_model import BaseSetupModel
from gui.impl.gen.view_models.views.lobby.tank_setup.sub_views.battle_booster_slot_model import BattleBoosterSlotModel

class BattleBoostersSetupModel(BaseSetupModel):
    __slots__ = ()

    def __init__(self, properties=6, commands=7):
        super(BattleBoostersSetupModel, self).__init__(properties=properties, commands=commands)

    def getSlots(self):
        return self._getArray(5)

    def setSlots(self, value):
        self._setArray(5, value)

    @staticmethod
    def getSlotsType():
        return BattleBoosterSlotModel

    def _initialize(self):
        super(BattleBoostersSetupModel, self)._initialize()
        self._addArrayProperty('slots', Array())