from gui.Scaleform.framework.entities.BaseDAAPIComponent import BaseDAAPIComponent

class RankedBattlesRewardsLeaguesMeta(BaseDAAPIComponent):

    def onStyleClick(self, styleCD):
        self._printOverrideError('onStyleClick')

    def as_setRewardsS(self, rewards):
        if self._isDAAPIInited():
            return self.flashObject.as_setRewards(rewards)