from enum import Enum

class Features(str, Enum):
    METRICS = 'battle_metrics'


class Groups(str, Enum):
    SESSION = 'session'
    SYSTEM = 'system'


class LogActions(str, Enum):
    SPACE_DONE = 'space_done'