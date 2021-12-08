from gui.Scaleform.daapi.view.meta.EventPointCounterMeta import EventPointCounterMeta

class EventPointCounter(EventPointCounterMeta):

    def setPointsCount(self, count):
        self.as_updateCountS(count)