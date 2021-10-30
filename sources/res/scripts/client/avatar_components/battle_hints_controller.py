from helpers import dependency
from skeletons.gui.battle_session import IBattleSessionProvider

class BattleHintsController(object):
    guiSessionProvider = dependency.descriptor(IBattleSessionProvider)

    def onBecomePlayer(self):
        pass

    def onBecomeNonPlayer(self):
        pass

    def handleKey(self, isDown, key, mods):
        pass

    def showHint(self, hintName, hintParams):
        battleHints = self.guiSessionProvider.dynamic.battleHints
        if battleHints:
            battleHints.showHint(hintName, hintParams)

    def hideHint(self, hintName):
        battleHints = self.guiSessionProvider.dynamic.battleHints
        if battleHints:
            battleHints.hideHint(hintName)