from Event import Event, EventManager
from gui.Scaleform.daapi.view.meta.CalendarMeta import CalendarMeta
from gui.impl import backport

class CalendarComponent(CalendarMeta):

    def __init__(self):
        super(CalendarComponent, self).__init__()
        self.__em = EventManager()
        self.onMonthChangedEvent = Event(self.__em)
        self.onDateSelectedEvent = Event(self.__em)

    def onMonthChanged(self, timestamp):
        self.onMonthChangedEvent(timestamp)

    def onDateSelected(self, timestamp):
        self.onDateSelectedEvent(timestamp)

    def formatYMHeader(self, rawDate):
        return backport.getYearMonthFormat(rawDate)

    def _dispose(self):
        self.__em.clear()
        super(CalendarComponent, self)._dispose()