from enum import Enum
COSMIC_BANNER_ENTRY_POINT = 'CosmicBannerEntryPoint'

class EVENT_STATES(Enum):
    START = 0
    FINISH = 1
    SUSPEND = 2
    RESUME = 3