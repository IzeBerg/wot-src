import random
from cgf_components.marker_component import IBattleSessionProvider
from fun_random.gui.feature.util.fun_mixins import FunSubModesWatcher
from fun_random.gui.feature.util.fun_wrappers import hasBattleSubMode
from gui.impl.gen import R
from helpers import dependency
from helpers.tips import TipsCriteria, TipData

class FunRandomTipsCriteria(TipsCriteria, FunSubModesWatcher):
    __sessionProvider = dependency.descriptor(IBattleSessionProvider)

    @hasBattleSubMode(defReturn=TipData(R.invalid(), R.invalid(), R.invalid()))
    def find(self):
        battleSubMode = self.getBattleSubMode(self.__sessionProvider.arenaVisitor)
        iconsRoot = battleSubMode.getIconsResRoot()
        tips = [ TipData(tipRes.title(), tipRes.description(), iconsRoot.tips.dyn(tipID)()) for tipID, tipRes in battleSubMode.getLocalsResRoot().tips.items()
               ]
        if tips:
            return random.choice(tips)
        return TipData(R.invalid(), R.invalid(), R.invalid())

    def _getTipsValidator(self):
        return