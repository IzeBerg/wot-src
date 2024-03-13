from gui.Scaleform.daapi.view.battle.classic.page import ClassicPage

class BattleRoyalePageMeta(ClassicPage):

    def as_updateDamageScreenS(self, isVisible):
        if self._isDAAPIInited():
            return self.flashObject.as_updateDamageScreen(isVisible)

    def as_setCrosshairModeS(self, value):
        if self._isDAAPIInited():
            return self.flashObject.as_setCrosshairMode(value)