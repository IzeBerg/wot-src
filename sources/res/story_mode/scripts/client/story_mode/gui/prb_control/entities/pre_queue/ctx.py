from story_mode_common.story_mode_constants import QUEUE_TYPE
from gui.prb_control.entities.base.pre_queue.ctx import QueueCtx
from gui.shared.utils.decorators import ReprInjector

@ReprInjector.withParent(('getVehicleInventoryID', 'vInvID'))
class StoryModeQueueCtx(QueueCtx):

    def __init__(self, waitingID=''):
        super(StoryModeQueueCtx, self).__init__(entityType=QUEUE_TYPE.STORY_MODE, waitingID=waitingID)