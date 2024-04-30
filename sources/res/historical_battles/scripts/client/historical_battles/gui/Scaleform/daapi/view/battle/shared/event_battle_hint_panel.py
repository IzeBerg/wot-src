import CommandMapping
from gui.Scaleform.daapi.view.battle.shared.hint_panel.component import BattleHintPanel
from gui.Scaleform.daapi.view.battle.shared.hint_panel.hint_panel_plugin import HintData, HintPriority
from gui.Scaleform.daapi.view.battle.shared.hint_panel.plugins import PreBattleHintPlugin
from gui.impl import backport
from gui.impl.gen import R
from gui.shared.utils.key_mapping import getReadableKey, getVirtualKey

class EventBattleHintPanel(BattleHintPanel):

    def _createPlugins(self):
        return {'SE22HelpHintPlugin': SE22HelpHintPlugin}


class SE22HelpHintPlugin(PreBattleHintPlugin):

    @classmethod
    def isSuitable(cls):
        return True

    def _getHint(self):
        return HintData(getVirtualKey(CommandMapping.CMD_SHOW_HELP), getReadableKey(CommandMapping.CMD_SHOW_HELP), backport.text(R.strings.ingame_gui.helpScreen.hint.press()), backport.text(R.strings.hb_battle.helpScreen.hint.description()), offsetX=0, offsetY=0, priority=HintPriority.HELP, reducedPanning=False)

    def _canDisplayCustomHelpHint(self):
        return True