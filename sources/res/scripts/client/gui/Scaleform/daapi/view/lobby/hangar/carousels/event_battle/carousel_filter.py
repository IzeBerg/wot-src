from gui.Scaleform.daapi.view.common.vehicle_carousel.carousel_filter import CarouselFilter
from account_helpers.AccountSettings import EVENTBATTLE_CAROUSEL_FILTER_1, EVENTBATTLE_CAROUSEL_FILTER_2, EVENTBATTLE_CAROUSEL_FILTER_CLIENT_1

class EventBattleCarouselFilter(CarouselFilter):

    def __init__(self):
        super(EventBattleCarouselFilter, self).__init__()
        self._serverSections = (EVENTBATTLE_CAROUSEL_FILTER_1, EVENTBATTLE_CAROUSEL_FILTER_2)
        self._clientSections = (EVENTBATTLE_CAROUSEL_FILTER_CLIENT_1,)