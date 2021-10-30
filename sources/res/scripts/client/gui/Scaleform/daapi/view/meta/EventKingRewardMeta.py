from gui.Scaleform.framework.entities.BaseDAAPIComponent import BaseDAAPIComponent

class EventKingRewardMeta(BaseDAAPIComponent):

    def onExitToRewardsClick(self):
        self._printOverrideError('onExitToRewardsClick')

    def as_setDataS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_setData(data)