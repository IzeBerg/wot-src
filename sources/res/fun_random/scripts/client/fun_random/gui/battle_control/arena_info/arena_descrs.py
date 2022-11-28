import BattleReplay
from fun_random.gui.feature.util.fun_mixins import FunSubModesWatcher
from fun_random.gui.feature.util.fun_wrappers import hasBattleSubMode
from gui.battle_control.arena_info.arena_descrs import ArenaWithLabelDescription
from gui.impl import backport
from gui.impl.gen import R

class FunRandomArenaDescription(ArenaWithLabelDescription, FunSubModesWatcher):

    def isInvitationEnabled(self):
        replayCtrl = BattleReplay.g_replayCtrl
        return not replayCtrl.isPlaying or replayCtrl.isBattleSimulation

    def getDescriptionString(self, isInBattle=True):
        description = super(FunRandomArenaDescription, self).getDescriptionString(isInBattle)
        return self.__getDescriptionString() or description

    @hasBattleSubMode(defReturn='')
    def __getDescriptionString(self):
        subModeName = backport.text(self.getBattleSubMode(self._visitor).getLocalsResRoot().userName())
        return backport.text(R.strings.fun_random.battleLoading.title(), subModeName=subModeName)