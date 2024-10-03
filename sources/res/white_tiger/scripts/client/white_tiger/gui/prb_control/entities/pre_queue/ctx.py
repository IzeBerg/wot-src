from gui.prb_control.entities.base.pre_queue.ctx import QueueCtx
from gui.shared.utils.decorators import ReprInjector
from white_tiger_common.wt_constants import QUEUE_TYPE

@ReprInjector.withParent(('getVehicleInventoryID', 'vInvID'))
class WhiteTigerBattleQueueCtx(QueueCtx):

    def __init__(self, vehInvID, waitingID=''):
        super(WhiteTigerBattleQueueCtx, self).__init__(entityType=QUEUE_TYPE.WHITE_TIGER, waitingID=waitingID)
        self.__vehInvID = vehInvID

    def getVehicleInventoryID(self):
        return self.__vehInvID