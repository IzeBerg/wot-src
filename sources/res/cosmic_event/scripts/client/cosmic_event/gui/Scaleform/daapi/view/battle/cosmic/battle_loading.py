from gui.Scaleform.daapi.view.meta.CosmicBattleLoadingMeta import CosmicBattleLoadingMeta
from gui.impl import backport
from gui.impl.gen import R

class CosmicBattleLoading(CosmicBattleLoadingMeta):

    def _populate(self):
        super(CosmicBattleLoading, self)._populate()
        self.as_setTipsS([
         backport.text(R.strings.cosmicEvent.battle.loadingScreen.tip1()),
         backport.text(R.strings.cosmicEvent.battle.loadingScreen.tip2()),
         backport.text(R.strings.cosmicEvent.battle.loadingScreen.tip3()),
         backport.text(R.strings.cosmicEvent.battle.loadingScreen.tip4()),
         backport.text(R.strings.cosmicEvent.battle.loadingScreen.tip5())])

    def invalidateArenaInfo(self):
        pass

    def _setTipsInfo(self):
        pass

    def _addArenaTypeData(self):
        pass