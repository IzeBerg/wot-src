from UnitRoster import BaseUnitRoster, BaseUnitRosterLimits
from unit_roster_config import RosterSlot10

class HalloweenRoster(BaseUnitRoster):
    MAX_SLOTS = 5
    MAX_EMPTY_SLOTS = 4
    SLOT_TYPE = RosterSlot10
    DEFAULT_SLOT_PACK = RosterSlot10().pack()
    LIMITS_TYPE = BaseUnitRosterLimits