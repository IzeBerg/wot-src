import logging
from account_helpers.AccountSettings import RANKED_CAROUSEL_FILTER_1, RANKED_CAROUSEL_FILTER_2, RANKED_CAROUSEL_FILTER_CLIENT_1, BATTLEPASS_CAROUSEL_FILTER_1, BATTLEPASS_CAROUSEL_FILTER_CLIENT_1
from gui.Scaleform.daapi.view.common.vehicle_carousel.carousel_filter import EventCriteriesGroup
from gui.Scaleform.daapi.view.lobby.hangar.carousels.battle_pass.carousel_filter import BattlePassCarouselFilter, BattlePassCriteriesGroup
_logger = logging.getLogger(__name__)

class RankedCarouselFilter(BattlePassCarouselFilter):

    def __init__(self):
        super(RankedCarouselFilter, self).__init__()
        self._serverSections = (RANKED_CAROUSEL_FILTER_1, RANKED_CAROUSEL_FILTER_2, BATTLEPASS_CAROUSEL_FILTER_1)
        self._clientSections = (RANKED_CAROUSEL_FILTER_CLIENT_1, BATTLEPASS_CAROUSEL_FILTER_CLIENT_1)
        self._criteriesGroups = (EventCriteriesGroup(), BattlePassCriteriesGroup())