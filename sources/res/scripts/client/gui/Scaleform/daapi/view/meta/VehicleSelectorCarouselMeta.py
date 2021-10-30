from gui.Scaleform.daapi.view.common.vehicle_carousel.carousel_environment import CarouselEnvironment

class VehicleSelectorCarouselMeta(CarouselEnvironment):

    def setFilter(self, id, selected):
        self._printOverrideError('setFilter')

    def as_initCarouselFilterS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_initCarouselFilter(data)