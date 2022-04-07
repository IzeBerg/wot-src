from gui.Scaleform.daapi.view.battle.classic.page import ClassicPage

class CommanderBattlePageMeta(ClassicPage):

    def as_spawnPointWindowClosedS(self):
        if self._isDAAPIInited():
            return self.flashObject.as_spawnPointWindowClosed()