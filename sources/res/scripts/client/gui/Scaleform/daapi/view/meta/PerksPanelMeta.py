from gui.Scaleform.framework.entities.BaseDAAPIComponent import BaseDAAPIComponent

class PerksPanelMeta(BaseDAAPIComponent):

    def as_setPerksS(self, items):
        if self._isDAAPIInited():
            return self.flashObject.as_setPerks(items)

    def as_updatePerkS(self, perkName, state, duration, lifeTime):
        if self._isDAAPIInited():
            return self.flashObject.as_updatePerk(perkName, state, duration, lifeTime)

    def as_clearPanelS(self):
        if self._isDAAPIInited():
            return self.flashObject.as_clearPanel()

    def as_replayPauseS(self, isPaused):
        if self._isDAAPIInited():
            return self.flashObject.as_replayPause(isPaused)