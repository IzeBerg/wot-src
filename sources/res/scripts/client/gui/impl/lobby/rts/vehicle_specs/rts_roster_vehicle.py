

class _RtsRosterVehicle(object):
    __slots__ = ('__vehicle', )

    def __init__(self):
        super(_RtsRosterVehicle, self).__init__()
        self.__vehicle = None
        return

    def setVehicle(self, value):
        self.__vehicle = value

    @property
    def item(self):
        return self.__vehicle

    @property
    def defaultItem(self):
        return

    def isPresent(self):
        return self.__vehicle is not None

    def dispose(self):
        self.__vehicle = None
        return


g_rtsRosterVehicle = _RtsRosterVehicle()