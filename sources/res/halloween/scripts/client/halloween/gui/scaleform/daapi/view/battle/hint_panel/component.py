from halloween.gui.scaleform.daapi.view.battle.hint_panel import plugins
from gui.Scaleform.daapi.view.battle.shared.hint_panel.component import BattleHintPanel

class HWBattleHintPanel(BattleHintPanel):

    def _createPlugins(self):
        commonPlugins = super(HWBattleHintPanel, self)._createPlugins()
        return plugins.updatePlugins(commonPlugins)