from account_helpers.AccountSettings import ROYALE_CAROUSEL_FILTER_1, ROYALE_CAROUSEL_FILTER_2, ROYALE_CAROUSEL_FILTER_CLIENT_1
from gui.Scaleform.daapi.view.common.vehicle_carousel import carousel_filter

class RoyaleCarouselFilter(carousel_filter.CarouselFilter):

    def __init__(self):
        super(RoyaleCarouselFilter, self).__init__()
        self._serverSections = (ROYALE_CAROUSEL_FILTER_1, ROYALE_CAROUSEL_FILTER_2)
        self._clientSections = (ROYALE_CAROUSEL_FILTER_CLIENT_1,)

    def _setCriteriaGroups(self):
        self._criteriesGroups = (
         carousel_filter.EventCriteriesGroup(),
         carousel_filter.BasicCriteriesGroup())

    def _getFromServerStorage(self, defaultFilters):
        return defaultFilters