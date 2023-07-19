from enum import Enum

class Features(str, Enum):
    MEMORY_CRITICAL = 'memory_critical'


class Groups(str, Enum):
    EVENT = 'event'


class LogActions(str, Enum):
    MEMORY_CRITICAL_EVENT = 'memory_critical_event'