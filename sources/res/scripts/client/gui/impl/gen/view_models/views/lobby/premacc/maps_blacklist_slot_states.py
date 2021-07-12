from frameworks.wulf import ViewModel

class MapsBlacklistSlotStates(ViewModel):
    __slots__ = ()
    MAPS_BLACKLIST_SLOT_STATE_ACTIVE = 'active'
    MAPS_BLACKLIST_SLOT_STATE_CHANGE = 'change'
    MAPS_BLACKLIST_SLOT_STATE_DISABLED = 'disabled'
    MAPS_BLACKLIST_SLOT_STATE_COOLDOWN = 'cooldown'
    MAPS_BLACKLIST_SLOT_STATE_SELECTED = 'selected'
    MAPS_BLACKLIST_SLOT_STATE_ACTIVE_NO_HOVER = 'active_no_hover'

    def __init__(self, properties=0, commands=0):
        super(MapsBlacklistSlotStates, self).__init__(properties=properties, commands=commands)

    def _initialize(self):
        super(MapsBlacklistSlotStates, self)._initialize()