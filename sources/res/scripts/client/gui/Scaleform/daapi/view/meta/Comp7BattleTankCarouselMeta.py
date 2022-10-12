from gui.Scaleform.daapi.view.common.vehicle_carousel.carousel_environment import CarouselEnvironment

class Comp7BattleTankCarouselMeta(CarouselEnvironment):

    def setFilter(self, id):
        self._printOverrideError('setFilter')

    def onViewIsHidden(self):
        self._printOverrideError('onViewIsHidden')

    def as_rowCountS(self, value):
        if self._isDAAPIInited():
            return self.flashObject.as_rowCount(value)

    def as_hideS(self, useAnim):
        if self._isDAAPIInited():
            return self.flashObject.as_hide(useAnim)