from gui.prb_control.entities.base.listener import IPrbListener

class IPreQueueListener(IPrbListener):

    def onEnqueued(self, queueType, *args):
        pass

    def onDequeued(self, queueType, *args):
        pass

    def onEnqueueError(self, queueType, *args):
        pass

    def onKickedFromQueue(self, queueType, *args):
        pass

    def onKickedFromArena(self, queueType, *args):
        pass

    def onArenaJoinFailure(self, queueType, *args):
        pass

    def onPreQueueSettingsChanged(self, diff):
        pass