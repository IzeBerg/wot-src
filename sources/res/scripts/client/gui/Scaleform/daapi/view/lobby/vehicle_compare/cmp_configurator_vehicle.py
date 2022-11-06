

class _CompareConfiguratorVehicle(object):
    __slots__ = ('__vehicle', )

    def __init__(self):
        super(_CompareConfiguratorVehicle, self).__init__()
        self.__vehicle = None
        return

    def setVehicle(self, value):
        self.__vehicle = value

    @property
    def item(self):
        return self.__vehicle

    def isPresent(self):
        return self.__vehicle is not None

    def clear(self):
        self.__vehicle = None
        return


g_cmpConfiguratorVehicle = _CompareConfiguratorVehicle()