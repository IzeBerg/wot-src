from gui.Scaleform.framework.entities.BaseDAAPIComponent import BaseDAAPIComponent

class EventHeaderMeta(BaseDAAPIComponent):

    def menuItemClick(self, alias):
        self._printOverrideError('menuItemClick')

    def as_setVisibleS(self, value):
        if self._isDAAPIInited():
            return self.flashObject.as_setVisible(value)

    def as_setCoinsS(self, value):
        if self._isDAAPIInited():
            return self.flashObject.as_setCoins(value)

    def as_setDifficultyS(self, value):
        if self._isDAAPIInited():
            return self.flashObject.as_setDifficulty(value)

    def as_setScreenS(self, alias):
        if self._isDAAPIInited():
            return self.flashObject.as_setScreen(alias)

    def as_setHangarMenuDataS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_setHangarMenuData(data)

    def as_setButtonCounterS(self, btnAlias, value):
        if self._isDAAPIInited():
            return self.flashObject.as_setButtonCounter(btnAlias, value)

    def as_removeButtonCounterS(self, btnAlias):
        if self._isDAAPIInited():
            return self.flashObject.as_removeButtonCounter(btnAlias)