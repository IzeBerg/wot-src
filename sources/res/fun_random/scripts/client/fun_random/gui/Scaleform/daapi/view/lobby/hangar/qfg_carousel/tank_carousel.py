from fun_random.gui.Scaleform.daapi.view.lobby.hangar.carousel.tank_carousel import FunRandomTankCarousel
from fun_random.gui.Scaleform.daapi.view.lobby.hangar.qfg_carousel.carousel_data_provider import FunRandomQuickFireGunsCarouselDataProvider
from fun_random.gui.Scaleform.daapi.view.lobby.hangar.qfg_carousel.carousel_filter import FunRandomQuickFireGunsCarouselFilter

class FunRandomQuickFireGunsCarousel(FunRandomTankCarousel):

    def __init__(self):
        super(FunRandomQuickFireGunsCarousel, self).__init__()
        self._carouselDPCls = FunRandomQuickFireGunsCarouselDataProvider
        self._carouselFilterCls = FunRandomQuickFireGunsCarouselFilter

    def updateParams(self):
        pass

    def _getFiltersVisible(self):
        return False

    def _getFilters(self):
        return ()

    def _updateDynamicFilters(self):
        pass

    def _updateFilter(self):
        pass