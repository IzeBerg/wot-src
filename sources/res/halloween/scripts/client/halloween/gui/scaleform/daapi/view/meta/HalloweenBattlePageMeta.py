from gui.Scaleform.daapi.view.battle.classic.page import ClassicPage

class HalloweenBattlePageMeta(ClassicPage):

    def as_updateDamageScreenS(self, isVisible):
        if self._isDAAPIInited():
            return self.flashObject.as_updateDamageScreen(isVisible)