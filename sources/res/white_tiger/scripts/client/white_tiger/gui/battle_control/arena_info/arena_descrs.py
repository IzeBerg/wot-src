import BattleReplay
from gui.impl import backport
from gui.impl.gen import R
from gui.battle_control.arena_info.arena_descrs import ArenaWithLabelDescription
from gui.wt_event.wt_event_helpers import isBossTeam

class WhiteTigerArenaDescription(ArenaWithLabelDescription):

    def getDescriptionString(self, isInBattle=True):
        return backport.text(R.strings.event.loading.battleTypes.wt())

    def getWinString(self, isInBattle=True):
        if isBossTeam(self._team):
            return backport.text(R.strings.event.loading.winText.boss())
        return backport.text(R.strings.event.loading.winText.hunters())

    def getTeamName(self, team):
        if isBossTeam(team):
            return backport.text(R.strings.event.stats.team.boss())
        return backport.text(R.strings.event.stats.team.hunters())

    def isInvitationEnabled(self):
        replayCtrl = BattleReplay.g_replayCtrl
        return not replayCtrl.isPlaying