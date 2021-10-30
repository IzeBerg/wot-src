import typing, BigWorld
from PlayerEvents import g_playerEvents
from constants import QUEUE_TYPE
from debug_utils import LOG_DEBUG
from gui.prb_control import prb_getters
from gui.prb_control.entities.base.pre_queue.entity import PreQueueEntity, PreQueueSubscriber, PreQueueEntryPoint
from gui.prb_control.entities.maps_training.pre_queue.actions_validator import MapsTrainingActionsValidator
from gui.prb_control.entities.maps_training.pre_queue.ctx import MapsTrainingQueueCtx
from gui.prb_control.entities.maps_training.pre_queue.permissions import MapsTrainingPermissions
from gui.prb_control.events_dispatcher import g_eventDispatcher
from gui.prb_control.items import SelectResult
from gui.prb_control.settings import FUNCTIONAL_FLAG, PREBATTLE_ACTION_NAME
from gui.prb_control.storages import prequeue_storage_getter
from helpers import dependency
from skeletons.gui.game_control import IMapsTrainingController
if typing.TYPE_CHECKING:
    from gui.prb_control.storages.local_storage import LocalStorage

class _MapsTrainingSubscriber(PreQueueSubscriber):

    def subscribe(self, entity):
        g_playerEvents.onEnqueuedMapsTraining += entity.onEnqueued
        g_playerEvents.onDequeuedMapsTraining += entity.onDequeued
        g_playerEvents.onEnqueuedMapsTrainingFailure += entity.onEnqueueError
        g_playerEvents.onKickedFromMapsTrainingQueue += entity.onKickedFromQueue
        g_playerEvents.onKickedFromArena += entity.onKickedFromArena
        g_playerEvents.onArenaJoinFailure += entity.onArenaJoinFailure

    def unsubscribe(self, entity):
        g_playerEvents.onEnqueuedMapsTraining -= entity.onEnqueued
        g_playerEvents.onDequeuedMapsTraining -= entity.onDequeued
        g_playerEvents.onEnqueuedMapsTrainingFailure -= entity.onEnqueueError
        g_playerEvents.onKickedFromMapsTrainingQueue -= entity.onKickedFromQueue
        g_playerEvents.onKickedFromArena -= entity.onKickedFromArena
        g_playerEvents.onArenaJoinFailure -= entity.onArenaJoinFailure


class MapsTrainingEntryPoint(PreQueueEntryPoint):

    def __init__(self):
        super(MapsTrainingEntryPoint, self).__init__(FUNCTIONAL_FLAG.MAPS_TRAINING, QUEUE_TYPE.MAPS_TRAINING)


class MapsTrainingEntity(PreQueueEntity):
    _QUEUE_TIMEOUT_MSG_KEY = '#maps_training:arena_start_errors/prb/kick/timeout'
    mapsTrainingController = dependency.descriptor(IMapsTrainingController)

    def __init__(self):
        super(MapsTrainingEntity, self).__init__(FUNCTIONAL_FLAG.MAPS_TRAINING, QUEUE_TYPE.MAPS_TRAINING, _MapsTrainingSubscriber())

    @prequeue_storage_getter(QUEUE_TYPE.MAPS_TRAINING)
    def storage(self):
        return

    def init(self, ctx=None):
        self.storage.release()
        self.mapsTrainingController.onEnter()
        if ctx is not None:
            ctx.addFlags(FUNCTIONAL_FLAG.LOAD_PAGE)
        return super(MapsTrainingEntity, self).init(ctx) | FUNCTIONAL_FLAG.LOAD_PAGE

    def leave(self, ctx, callback=None):
        self.storage.suspend()
        self.mapsTrainingController.onExit()
        if ctx:
            isExit = ctx.hasFlags(FUNCTIONAL_FLAG.EXIT)
            isSwitch = ctx.hasFlags(FUNCTIONAL_FLAG.SWITCH)
            isLoadPage = ctx.hasFlags(FUNCTIONAL_FLAG.LOAD_PAGE)
            if isExit or isSwitch and not isLoadPage:
                g_eventDispatcher.loadHangar()
        super(MapsTrainingEntity, self).leave(ctx, callback)

    def isInQueue(self):
        return prb_getters.isInMapsTrainingQueue()

    def doSelectAction(self, action):
        if action.actionName == PREBATTLE_ACTION_NAME.MAPS_TRAINING:
            return SelectResult(True)
        return super(MapsTrainingEntity, self).doSelectAction(action)

    def getPermissions(self, pID=None, **kwargs):
        return MapsTrainingPermissions(self.isInQueue())

    def _doQueue(self, ctx):
        BigWorld.player().enqueueMapsTraininig(ctx.getSelectedMap(), ctx.getSelectedVehicle(), ctx.getSelectedTeam())
        LOG_DEBUG('Sends request on queuing to the maps training', ctx)

    def _doDequeue(self, ctx):
        BigWorld.player().dequeueMapsTraininig()
        LOG_DEBUG('Sends request on dequeuing from the maps training')

    def _makeQueueCtxByAction(self, action=None):
        mapGeometryID = self.mapsTrainingController.getSelectedMap()
        vehCompDescr = self.mapsTrainingController.getSelectedVehicle()
        team = self.mapsTrainingController.getSelectedTeam()
        return MapsTrainingQueueCtx(mapGeometryID, vehCompDescr, team, waitingID='prebattle/join')

    def _goToQueueUI(self):
        self.mapsTrainingController.showMapsTrainingQueue()
        return FUNCTIONAL_FLAG.LOAD_PAGE

    def _exitFromQueueUI(self):
        if self.mapsTrainingController.isMapsTrainingEnabled:
            self.mapsTrainingController.showMapsTrainingPage()
        else:
            self.mapsTrainingController.selectRandomMode()

    def _createActionsValidator(self):
        return MapsTrainingActionsValidator(self)

    def _isNeedToShowSystemMessage(self):
        return self.mapsTrainingController.isMapsTrainingEnabled