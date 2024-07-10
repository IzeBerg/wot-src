from gui.Scaleform.daapi.view.battle.shared.battle_loading import BattleLoading

class RacesBattleLoadingMeta(BattleLoading):

    def as_setTipsS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_setTips(data)