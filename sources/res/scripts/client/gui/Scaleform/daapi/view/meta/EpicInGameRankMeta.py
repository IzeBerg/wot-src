from gui.Scaleform.framework.entities.BaseDAAPIComponent import BaseDAAPIComponent

class EpicInGameRankMeta(BaseDAAPIComponent):

    def levelUpAnimationComplete(self):
        self._printOverrideError('levelUpAnimationComplete')

    def as_triggerLevelUpS(self, previousProgress):
        if self._isDAAPIInited():
            return self.flashObject.as_triggerLevelUp(previousProgress)

    def as_updateProgressS(self, previousProgress, currentProgress):
        if self._isDAAPIInited():
            return self.flashObject.as_updateProgress(previousProgress, currentProgress)

    def as_setRankS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_setRank(data)