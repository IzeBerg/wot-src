from adisp import process
from gui.shared.utils import functions
from helpers import dependency
from skeletons.gui.lobby_context import ILobbyContext

def vehicleAmmoCheck(func):
    from CurrentVehicle import g_currentVehicle

    @process
    def wrapper(*args, **kwargs):
        res = yield functions.checkAmmoLevel((g_currentVehicle.item,))
        if res:
            func(*args, **kwargs)
        elif kwargs.get('callback') is not None:
            kwargs.get('callback')(False)
        return

    return wrapper


def lobbyHeaderNavigationPossibleCheck(func):

    @process
    def wrapper(*args, **kwargs):
        lobbyContext = dependency.instance(ILobbyContext)
        res = yield lobbyContext.isHeaderNavigationPossible()
        if res:
            func(*args, **kwargs)
        elif kwargs.get('callback') is not None:
            kwargs.get('callback')(False)
        return

    return wrapper