from constants import QUEUE_TYPE
from gui.prb_control.entities.base.pre_queue.ctx import QueueCtx
from gui.shared.utils.decorators import ReprInjector

@ReprInjector.withParent(('getVehicleInventoryID', 'vInvID'))
class EventBattleQueueCtx(QueueCtx):

    def __init__(self, vehInvID, waitingID=''):
        super(EventBattleQueueCtx, self).__init__(entityType=QUEUE_TYPE.EVENT_BATTLES, waitingID=waitingID)
        self.__vehInvID = vehInvID

    def getVehicleInventoryID(self):
        return self.__vehInvID