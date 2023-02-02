import typing, AccountCommands
from BaseAccountExtensionComponent import BaseAccountExtensionComponent
from constants import QUEUE_TYPE
from PlayerEvents import g_playerEvents as events
if typing.TYPE_CHECKING:
    from fun_random.gui.prb_control.entities.pre_queue.ctx import FunRandomQueueCtx

class AccountFunRandomComponent(BaseAccountExtensionComponent):

    def enqueueFunRandom(self, ctx):
        self.base.doCmdIntArr(AccountCommands.REQUEST_ID_NO_RESPONSE, AccountCommands.CMD_ENQUEUE_IN_BATTLE_QUEUE, [
         QUEUE_TYPE.FUN_RANDOM, ctx.getVehicleInventoryID(), ctx.getDesiredSubModeID()])

    def dequeueFunRandom(self):
        if not events.isPlayerEntityChanging:
            self.base.doCmdInt(AccountCommands.REQUEST_ID_NO_RESPONSE, AccountCommands.CMD_DEQUEUE_FROM_BATTLE_QUEUE, QUEUE_TYPE.FUN_RANDOM)