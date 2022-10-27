from gui.Scaleform.daapi.view.meta.BattleHintMeta import BattleHintMeta
from gui.battle_control.controllers.battle_hints_ctrl import BattleHintComponent

class BattleBuffHint(BattleHintComponent, BattleHintMeta):

    def _makeVO(self, hint, data):
        vo = hint.makeVO(data)
        param = data.get('param1', None)
        if param:
            vo['timer'] = float(param)
        return vo

    def _showHint(self, data):
        self.as_showHintS(data)

    def _hideHint(self):
        self.as_hideHintS()