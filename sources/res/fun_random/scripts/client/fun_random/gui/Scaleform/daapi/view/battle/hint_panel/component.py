from fun_random.gui.Scaleform.daapi.view.battle.hint_panel import plugins
from gui.Scaleform.daapi.view.battle.shared.hint_panel.component import BattleHintPanel

class FunRandomBattleHintPanel(BattleHintPanel):

    def _createPlugins(self):
        commonPlugins = super(FunRandomBattleHintPanel, self)._createPlugins()
        return plugins.updatePlugins(commonPlugins)