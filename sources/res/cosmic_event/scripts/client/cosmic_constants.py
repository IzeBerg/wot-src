from enum import Enum
from gui.impl import backport
from gui.impl.gen import R
COSMIC_BANNER_ENTRY_POINT = 'CosmicBannerEntryPoint'
PROGRESSION_STAGES_IN_PHASE = 3
PHASE_TO_ASSET = {1: R.images.cosmic_event.gui.maps.icons.progress_route.commander.kirk(), 
   2: R.images.cosmic_event.gui.maps.icons.progress_route.commander.spock(), 
   3: R.images.cosmic_event.gui.maps.icons.progress_route.commander.uhura()}
COSMIC_FADE_IN_DURATION = 0.3
COSMIC_FADE_OUT_DURATION = 0.3

class EVENT_STATES(Enum):
    START = 0
    FINISH = 1
    SUSPEND = 2
    RESUME = 3


class CosmicModeSelectorRewardID(Enum):
    COSMIC_CREW = 'cosmic_crew'
    STYLE_2D = 'style2D'
    EVENT_BONDS = 'eventBonds'


def getPrebattleConditionIcon():
    return backport.image(R.images.cosmic_event.gui.maps.icons.battleTypes.c_32x32.cosmicEvent())