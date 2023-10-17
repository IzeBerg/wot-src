from gui.Scaleform.daapi.view.meta.BattleHintMeta import BattleHintMeta
from gui.battle_control.controllers.battle_hints_ctrl import BattleHintComponent

class BattleHint(BattleHintComponent, BattleHintMeta):

    def _showHint(self, hint, data):
        self.as_showHintS(hint.makeVO(data))

    def _hideHint(self):
        self.as_hideHintS()