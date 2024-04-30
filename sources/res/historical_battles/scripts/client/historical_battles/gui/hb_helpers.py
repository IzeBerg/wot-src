import typing
from historical_battles.gui.gui_constants import HB_DISCOUNT_ENTITLEMENT_PREFIX
from gui.server_events.bonuses import VehiclesBonus
from shared_utils import findFirst
import logging
_logger = logging.getLogger(__name__)
if typing.TYPE_CHECKING:
    from gui.server_events.bonuses import SimpleBonus

def isDiscountBonus(bonus):
    return bonus.getName() == 'entitlements' and bonus.getValue().id.startswith(HB_DISCOUNT_ENTITLEMENT_PREFIX)


def getDiscountFromEntitlementBonus(bonus):
    discount = bonus.getValue().id.split('_')[(-1)]
    if discount.isdigit():
        return int(discount)
    return 0


def isVehicleTokenBonus(bonus):
    if bonus.getName() == 'battleToken':
        return bool(findFirst(lambda x: x.startswith('vehicle:'), bonus.getValue(), ()))
    return False


def repackTokenToVehicle(bonus):
    tokens = bonus.getValue()
    firstVehicle = tokens.keys()[0] if tokens else None
    if firstVehicle:
        _, vehCD, crewLvl = firstVehicle.split(':')
        return VehiclesBonus(VehiclesBonus.VEHICLES_BONUS, {int(vehCD): {'crewLvl': int(crewLvl)}})
    else:
        _logger.error("Can't repack token %s", bonus.getValue())
        return bonus