import typing
from helpers import dependency, time_utils
from skeletons.gui.lobby_context import ILobbyContext
from skeletons.new_year import INewYearController
if typing.TYPE_CHECKING:
    from typing import Dict
    from ny_common.NYToyPricesConfig import NYToyPricesConfig

@dependency.replace_none_kwargs(lobbyCtx=ILobbyContext)
def getToyPricesConfig(lobbyCtx=None):
    return lobbyCtx.getServerSettings().getNewYearToyPricesConfig()


def getToyPrice(toyID):
    config = getToyPricesConfig()
    return config.getToyPrice(toyID, {})


@dependency.replace_none_kwargs(nyController=INewYearController)
def isToyPurchased(toyID, slotID, nyController=None):
    config = getToyPricesConfig()
    toyPrice = config.getToyPrice(toyID)
    if toyPrice is None:
        return True
    else:
        inventoryToys = nyController.getToysBySlot(slotID)
        if toyID in inventoryToys:
            return True
        return False


@dependency.replace_none_kwargs(lobbyCtx=ILobbyContext)
def isBuyingEnabled(toyID, lobbyCtx=None):
    serverSettings = lobbyCtx.getServerSettings()
    eventEndTime = serverSettings.getNewYearGeneralConfig().getEventEndTime()
    toyPricesConfig = serverSettings.getNewYearToyPricesConfig()
    return toyPricesConfig.isPurchaseAvailable(toyID, time_utils.getServerUTCTime(), eventEndTime)