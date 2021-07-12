from CurrentVehicle import g_currentVehicle
from helpers import dependency
from skeletons.gui.shared import IItemsCache

class _TankSetupVehicle(object):
    __slots__ = ('__vehicle', )
    _itemsCache = dependency.descriptor(IItemsCache)

    def __init__(self):
        super(_TankSetupVehicle, self).__init__()
        self.__vehicle = None
        return

    def setVehicle(self, value):
        self.__vehicle = value

    @property
    def item(self):
        return self.__vehicle or g_currentVehicle.item

    @property
    def defaultItem(self):
        if g_currentVehicle.isPresent():
            return g_currentVehicle.item
        else:
            return

    def isPresent(self):
        return self.__vehicle is not None

    def dispose(self):
        self.__vehicle = None
        return


g_tankSetupVehicle = _TankSetupVehicle()