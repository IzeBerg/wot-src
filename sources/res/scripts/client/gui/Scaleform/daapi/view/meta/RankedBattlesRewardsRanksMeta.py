from gui.Scaleform.framework.entities.BaseDAAPIComponent import BaseDAAPIComponent

class RankedBattlesRewardsRanksMeta(BaseDAAPIComponent):

    def onRequestData(self, index, iconSizeID, rewardsCount):
        self._printOverrideError('onRequestData')

    def as_setDivisionsDataS(self, divisions, immediately):
        if self._isDAAPIInited():
            return self.flashObject.as_setDivisionsData(divisions, immediately)

    def as_setRewardsS(self, rewards, isQualification):
        if self._isDAAPIInited():
            return self.flashObject.as_setRewards(rewards, isQualification)