from helpers import dependency
from skeletons.gui.lobby_context import ILobbyContext
from skeletons.gui.shared import IItemsCache
from skeletons.account_helpers.settings_core import ISettingsCore
from ny_common.settings import NYVehBranchConsts
from items.components.ny_constants import NY_BRANCH_MIN_LEVEL
from gui.shared.money import Money
from account_helpers.settings_core.settings_constants import NewYearStorageKeys

@dependency.replace_none_kwargs(lobbyCtx=ILobbyContext)
def getVehicleChangePrice(lobbyCtx=None):
    priceDict = lobbyCtx.getServerSettings().getNewYearVehBranchConfig().get(NYVehBranchConsts.VEH_CHANGE_PRICE, {})
    return Money(**priceDict)


@dependency.replace_none_kwargs(itemsCache=IItemsCache)
def getAvailableVehicleLevels(itemsCache=None):
    return (
     NY_BRANCH_MIN_LEVEL, max(itemsCache.items.festivity.getMaxLevel(), NY_BRANCH_MIN_LEVEL))


def getAvailableVehicleRange():
    levelMin, levelMax = getAvailableVehicleLevels()
    return range(levelMin, levelMax + 1)


@dependency.replace_none_kwargs(itemsCache=IItemsCache, settingsCore=ISettingsCore)
def hasNewVehicleLevel(itemsCache=None, settingsCore=None):
    nyStorage = settingsCore.serverSettings.getNewYearStorage()
    currentLevel = itemsCache.items.festivity.getMaxLevel()
    savedLevel = nyStorage.get(NewYearStorageKeys.NY_VEHICLES_LEVEL_UP_ENTRY, None)
    return currentLevel > savedLevel