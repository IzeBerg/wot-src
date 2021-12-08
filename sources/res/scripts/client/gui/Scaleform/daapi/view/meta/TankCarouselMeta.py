from gui.Scaleform.daapi.view.common.vehicle_carousel.carousel_environment import CarouselEnvironment

class TankCarouselMeta(CarouselEnvironment):

    def restoreTank(self):
        self._printOverrideError('restoreTank')

    def buyTank(self):
        self._printOverrideError('buyTank')

    def buySlot(self):
        self._printOverrideError('buySlot')

    def buyRentPromotion(self, intCD):
        self._printOverrideError('buyRentPromotion')

    def selectWotPlusVehicle(self, intCD):
        self._printOverrideError('selectWotPlusVehicle')

    def newYearVehicles(self):
        self._printOverrideError('newYearVehicles')

    def setFilter(self, id):
        self._printOverrideError('setFilter')

    def updateHotFilters(self):
        self._printOverrideError('updateHotFilters')

    def getCarouselAlias(self):
        self._printOverrideError('getCarouselAlias')

    def as_setCarouselFilterS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_setCarouselFilter(data)

    def as_initCarouselFilterS(self, data):
        if self._isDAAPIInited():
            return self.flashObject.as_initCarouselFilter(data)

    def as_rowCountS(self, value):
        if self._isDAAPIInited():
            return self.flashObject.as_rowCount(value)

    def as_setSmallDoubleCarouselS(self, value):
        if self._isDAAPIInited():
            return self.flashObject.as_setSmallDoubleCarousel(value)

    def as_useExtendedCarouselS(self, value):
        if self._isDAAPIInited():
            return self.flashObject.as_useExtendedCarousel(value)

    def as_scrollToSlotS(self, slotIdx):
        if self._isDAAPIInited():
            return self.flashObject.as_scrollToSlot(slotIdx)