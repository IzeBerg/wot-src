from constants import QUEUE_TYPE
from gui.prb_control.entities.base.pre_queue.ctx import QueueCtx
from gui.shared.utils.decorators import ReprInjector

@ReprInjector.withParent(('getWaitingID', 'waitingID'))
class RTSBootcampBattleQueueCtx(QueueCtx):

    def __init__(self, waitingID=''):
        super(RTSBootcampBattleQueueCtx, self).__init__(entityType=QUEUE_TYPE.RTS_BOOTCAMP, waitingID=waitingID)