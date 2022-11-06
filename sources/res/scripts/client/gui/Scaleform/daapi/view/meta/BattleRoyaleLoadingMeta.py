from gui.Scaleform.daapi.view.battle.shared.battle_loading import BattleLoading

class BattleRoyaleLoadingMeta(BattleLoading):

    def as_setHeaderDataS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_setHeaderData(data)