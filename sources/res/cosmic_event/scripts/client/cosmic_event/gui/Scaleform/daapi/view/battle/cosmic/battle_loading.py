from gui import makeHtmlString
from gui.Scaleform.daapi.view.battle.shared.battle_loading import BattleLoading
from gui.impl import backport
from gui.impl.gen import R

class CosmicBattleLoading(BattleLoading):

    def _populate(self):
        super(CosmicBattleLoading, self)._populate()
        s = makeHtmlString('html_templates:battle/loadingScreenSimple', 'mainTip', ctx={'text1': backport.text(R.strings.cosmicEvent.battle.loadingScreen.text1()), 
           'text2': backport.text(R.strings.cosmicEvent.battle.loadingScreen.text2()), 
           'text3': backport.text(R.strings.cosmicEvent.battle.loadingScreen.text3())})
        self.as_setTipS(s)

    def invalidateArenaInfo(self):
        pass

    def _setTipsInfo(self):
        pass

    def _addArenaTypeData(self):
        pass