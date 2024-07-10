from races_common.races_constants import QUEUE_TYPE
from gui.prb_control.entities.base.pre_queue.ctx import QueueCtx
from gui.shared.utils.decorators import ReprInjector

@ReprInjector.withParent(('getVehicleInventoryID', 'vInvID'))
class RacesQueueCtx(QueueCtx):

    def __init__(self, vehInvID, waitingID=''):
        super(RacesQueueCtx, self).__init__(entityType=QUEUE_TYPE.RACES, waitingID=waitingID)
        self.__vehInvID = vehInvID

    def getVehicleInventoryID(self):
        return self.__vehInvID