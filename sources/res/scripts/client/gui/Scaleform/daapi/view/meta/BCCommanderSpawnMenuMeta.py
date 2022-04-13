from gui.Scaleform.daapi.view.battle.commander.spawn_menu import SpawnMenu

class BCCommanderSpawnMenuMeta(SpawnMenu):

    def as_showFooterHintTextS(self, isVisible, textValue):
        if self._isDAAPIInited():
            return self.flashObject.as_showFooterHintText(isVisible, textValue)

    def as_showButtonArrowHintS(self, isVisible, textValue):
        if self._isDAAPIInited():
            return self.flashObject.as_showButtonArrowHint(isVisible, textValue)

    def as_setEnemyNameVisibilityS(self, isVisible):
        if self._isDAAPIInited():
            return self.flashObject.as_setEnemyNameVisibility(isVisible)