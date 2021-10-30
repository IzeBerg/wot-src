from gui.Scaleform.daapi.view.meta.BaseBattleQueueMeta import BaseBattleQueueMeta

class EventBattleQueueMeta(BaseBattleQueueMeta):

    def as_setDifficultyS(self, value, label):
        if self._isDAAPIInited():
            return self.flashObject.as_setDifficulty(value, label)