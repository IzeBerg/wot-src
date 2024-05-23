import logging
from enum import IntEnum, Enum
_logger = logging.getLogger(__name__)
RESOURCE_WELL_PDATA_KEY = 'resourceWell'
UNAVAILABLE_REWARD_ERROR = 'UNAVAILABLE_REWARD_ERROR'
CHANNEL_NAME_PREFIX = 'suv_'

class ProgressionState(IntEnum):
    ACTIVE = 1
    NO_PROGRESS = 2
    NO_VEHICLES = 3
    FORBIDDEN = 4


class ResourceType(Enum):
    BLUEPRINTS = 'blueprints'
    CURRENCY = 'currency'
    PREMIUMS = 'premiums'

    @classmethod
    def getMember(cls, value):
        if value in cls._value2member_map_:
            return cls(value)
        else:
            _logger.error('%s does not exist in ResourceType values', value)
            return


class ServerResourceType(Enum):
    BLUEPRINTS = 'blueprints'
    CURRENCY = 'currency'
    ENTITLEMENTS = 'entitlement'