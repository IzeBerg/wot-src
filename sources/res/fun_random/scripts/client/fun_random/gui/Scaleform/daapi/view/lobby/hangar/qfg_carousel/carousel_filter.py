from gui.Scaleform.daapi.view.common.vehicle_carousel.carousel_filter import CarouselFilter

class FunRandomQuickFireGunsCarouselFilter(CarouselFilter):

    def __init__(self):
        super(FunRandomQuickFireGunsCarouselFilter, self).__init__()
        self._serverSections = ()
        self._clientSections = ()

    def _setCriteriaGroups(self):
        self._criteriesGroups = ()