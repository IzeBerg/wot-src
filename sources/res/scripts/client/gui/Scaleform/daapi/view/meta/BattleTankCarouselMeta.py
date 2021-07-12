from gui.Scaleform.daapi.view.common.vehicle_carousel.carousel_environment import CarouselEnvironment

class BattleTankCarouselMeta(CarouselEnvironment):

    def setFilter(self, id):
        self._printOverrideError('setFilter')

    def updateHotFilters(self):
        self._printOverrideError('updateHotFilters')

    def as_setCarouselFilterS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_setCarouselFilter(data)

    def as_initCarouselFilterS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_initCarouselFilter(data)