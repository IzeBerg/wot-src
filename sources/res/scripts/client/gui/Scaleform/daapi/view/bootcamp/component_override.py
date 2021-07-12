from helpers import dependency
from skeletons.gui.game_control import IBootcampController

class BootcampComponentOverride(object):
    __slots__ = ('__usualObject', '__bootcampObject')
    bootcampController = dependency.descriptor(IBootcampController)

    def __init__(self, usualObject, bootcampObject):
        super(BootcampComponentOverride, self).__init__()
        self.__usualObject = usualObject
        self.__bootcampObject = bootcampObject

    def __call__(self):
        isBootcamp = self.bootcampController.isInBootcamp()
        if isBootcamp:
            return self.__bootcampObject
        return self.__usualObject