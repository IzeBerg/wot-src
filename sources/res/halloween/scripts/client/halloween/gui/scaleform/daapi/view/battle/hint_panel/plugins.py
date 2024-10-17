import CommandMapping
from gui.impl import backport
from helpers import dependency
from skeletons.gui.battle_session import IBattleSessionProvider
from gui.Scaleform.daapi.view.battle.shared.hint_panel.hint_panel_plugin import HintPriority, HintData
from gui.Scaleform.daapi.view.battle.shared.hint_panel.plugins import PreBattleHintPlugin
from gui.impl.gen import R
from gui.shared.utils.key_mapping import getReadableKey, getVirtualKey
from halloween_common.halloween_constants import ARENA_GUI_TYPE

def updatePlugins(plugins):
    plugins.pop('prebattleHints')
    if HWHelpPlugin.isSuitable():
        plugins['halloweenHelpHint'] = HWHelpPlugin
    return plugins


class HWHelpPlugin(PreBattleHintPlugin):
    __sessionProvider = dependency.descriptor(IBattleSessionProvider)

    @classmethod
    def isSuitable(cls):
        return cls.__sessionProvider.arenaVisitor.getArenaGuiType() in (
         ARENA_GUI_TYPE.HALLOWEEN, ARENA_GUI_TYPE.HALLOWEEN_DEFENCE)

    def _getHint(self):
        keyName = getReadableKey(CommandMapping.CMD_SHOW_HELP)
        key = getVirtualKey(CommandMapping.CMD_SHOW_HELP)
        pressText = backport.text(R.strings.ingame_gui.hwHelpScreen.hint.press())
        hintText = backport.text(R.strings.ingame_gui.hwHelpScreen.hint.description())
        return HintData(key, keyName, pressText, hintText, 0, 0, HintPriority.HELP, False)

    def _canDisplayCustomHelpHint(self):
        return True