import BattleReplay
from gui.battle_control.controllers.msgs_ctrl import BattleMessagesController, BattleMessagesPlayer

class StoryModeBattleMessagesController(BattleMessagesController):

    def showDestructibleEntityDestroyedMessage(self, avatar, destructibleID, attackerID):
        self.onShowDestructibleEntityMessageByCode('BUNKER_DESTROYED', destructibleID, attackerID)


class StoryModeBattleMessagesPlayer(BattleMessagesPlayer):

    def showDestructibleEntityDestroyedMessage(self, avatar, destructibleID, attackerID):
        if BattleReplay.g_replayCtrl.isTimeWarpInProgress:
            return
        self.onShowDestructibleEntityMessageByCode('BUNKER_DESTROYED', destructibleID, attackerID)