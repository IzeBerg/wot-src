from gui.shared.tooltips.contexts import CarouselContext

class EventVehicleContext(CarouselContext):

    def __init__(self, fieldsToExclude=None):
        super(EventVehicleContext, self).__init__(fieldsToExclude)
        self.__isShort = False

    def buildItem(self, intCD, isShort=False):
        self.__isShort = isShort
        return self.itemsCache.items.getItemByCD(int(intCD))

    def getParams(self):
        return {'isShort': self.__isShort}