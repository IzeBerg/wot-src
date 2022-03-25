import typing
from gui.Scaleform.genConsts.FITTING_TYPES import FITTING_TYPES
from helpers import dependency
from shared_utils import findFirst
from skeletons.gui.shared import IItemsCache
from soft_exception import SoftException
if typing.TYPE_CHECKING:
    from gui.shared.gui_items import Vehicle

def _isCommanderTeam(currentPlayerTeam, isCommander, player):
    if isCommander:
        return player['team'] == currentPlayerTeam
    return player['team'] != currentPlayerTeam


def getCommanderInfo(playerAvatar, players):
    isCommander = playerAvatar['isCommander']
    playerTeam = playerAvatar['team']
    commanderInfo = findFirst(lambda player: _isCommanderTeam(playerTeam, isCommander, player), players.values())
    return commanderInfo


def getCommanderID(players, commanderTeam):
    for playerID, player in players.iteritems():
        if player['team'] == commanderTeam:
            return playerID

    raise SoftException('Team for the commander is undefined')


def getVehicleType(vehicle):
    if vehicle.isSupply:
        return FITTING_TYPES.SUPPLY
    return FITTING_TYPES.VEHICLE


@dependency.replace_none_kwargs(itemsCache=IItemsCache)
def getSupplyName(killerID, reusable, itemsCache=None):
    supplyIntCD = reusable.common.getSupplyCD(killerID)
    supply = itemsCache.items.getItemByCD(supplyIntCD)
    return supply.shortUserName


def getTeamSuppliesByType(intCD, team, reusable):
    return [ item for item in reusable.common.getTeamSupplies(team) if item.intCD == intCD ]


def filterTechnique(result):
    vehicles = []
    supplies = []
    for item in result:
        vehicle = item.vehicle
        if vehicle is None or vehicle.isObserver:
            continue
        elif vehicle.isSupply:
            supplies.append(item)
        else:
            vehicles.append(item)

    return (
     vehicles, supplies)