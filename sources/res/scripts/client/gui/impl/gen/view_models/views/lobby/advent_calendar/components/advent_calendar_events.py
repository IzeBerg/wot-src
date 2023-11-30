from enum import Enum
from frameworks.wulf import ViewModel

class EventType(Enum):
    OPEN_DOOR = 'openDoor'


class AdventCalendarEvents(ViewModel):
    __slots__ = ()

    def __init__(self, properties=2, commands=0):
        super(AdventCalendarEvents, self).__init__(properties=properties, commands=commands)

    def getEventType(self):
        return EventType(self._getString(0))

    def setEventType(self, value):
        self._setString(0, value.value)

    def getPayload(self):
        return self._getString(1)

    def setPayload(self, value):
        self._setString(1, value)

    def _initialize(self):
        super(AdventCalendarEvents, self)._initialize()
        self._addStringProperty('eventType', EventType.OPEN_DOOR.value)
        self._addStringProperty('payload', '')