import BattleReplay
from gui.battle_control.arena_info.arena_descrs import ArenaWithLabelDescription

class VersusAIArenaDescription(ArenaWithLabelDescription):

    def isInvitationEnabled(self):
        replayCtrl = BattleReplay.g_replayCtrl
        return not replayCtrl.isPlaying