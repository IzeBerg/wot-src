from enum import Enum

class RentEventTypes(Enum):
    START_RENT = 1
    END_RENT = 2


class RentLogInfo(Enum):
    ADD = 'excl_veh:add'
    START = 'excl_veh:on'
    END = 'excl_veh:off'