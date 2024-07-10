from gui.impl.gen.view_models.views.lobby.battle_results.battle_info_model import BattleInfoModel

class FunRandomBattleInfoModel(BattleInfoModel):
    __slots__ = ()

    def __init__(self, properties=7, commands=0):
        super(FunRandomBattleInfoModel, self).__init__(properties=properties, commands=commands)

    def getAssetsPointer(self):
        return self._getString(6)

    def setAssetsPointer(self, value):
        self._setString(6, value)

    def _initialize(self):
        super(FunRandomBattleInfoModel, self)._initialize()
        self._addStringProperty('assetsPointer', 'undefined')