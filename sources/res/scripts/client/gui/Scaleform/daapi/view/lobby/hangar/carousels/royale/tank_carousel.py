from gui.Scaleform.daapi.settings.views import VIEW_ALIAS
from gui.Scaleform.daapi.view.lobby.hangar.carousels.basic.tank_carousel import TankCarousel
from gui.Scaleform.daapi.view.lobby.hangar.carousels.royale.carousel_data_provider import RoyaleCarouselDataProvider
from gui.Scaleform.daapi.view.lobby.hangar.carousels.royale.carousel_filter import RoyaleCarouselFilter

class RoyaleTankCarousel(TankCarousel):

    def __init__(self):
        super(RoyaleTankCarousel, self).__init__()
        self._carouselDPCls = RoyaleCarouselDataProvider
        self._carouselFilterCls = RoyaleCarouselFilter

    def _populate(self):
        super(RoyaleTankCarousel, self)._populate()
        self.app.loaderManager.onViewLoaded += self.__onViewLoaded

    def _dispose(self):
        self.app.loaderManager.onViewLoaded -= self.__onViewLoaded
        super(RoyaleTankCarousel, self)._dispose()

    def _getInitialFilterVO(self, contexts):
        filtersVO = super(RoyaleTankCarousel, self)._getInitialFilterVO(contexts)
        filtersVO.update({'popoverAlias': VIEW_ALIAS.BATTLEROYALE_CAROUSEL_FILTER_POPOVER})
        return filtersVO

    def _getFilters(self):
        isBattleRoyaleEnabled = self.battleRoyaleController.isEnabled()
        parentFilters = super(RoyaleTankCarousel, self)._getFilters()
        if isBattleRoyaleEnabled:
            return parentFilters + ('battleRoyale', )
        return parentFilters

    def __onViewLoaded(self, view, *args, **kwargs):
        if view.alias == VIEW_ALIAS.BATTLEROYALE_CAROUSEL_FILTER_POPOVER:
            view.setTankCarousel(self)