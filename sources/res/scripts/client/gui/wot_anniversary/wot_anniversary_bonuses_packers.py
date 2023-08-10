import logging, typing
from constants import PREMIUM_ENTITLEMENTS
from gui.impl.gen.view_models.common.missions.bonuses.bonus_model import BonusModel
from gui.impl.gen.view_models.views.lobby.wot_anniversary.vehicle_bonus_model import VehicleBonusModel
from gui.server_events.bonuses import mergeBonuses, getNonQuestBonuses, splitBonuses
from gui.shared.missions.packers.bonus import BonusUIPacker, getDefaultBonusPackersMap, VehiclesBonusUIPacker, SimpleBonusUIPacker
from gui.shared.money import Currency
from gui.shared.gui_items.Vehicle import getNationLessName, getIconResourceName
if typing.TYPE_CHECKING:
    from gui.shared.gui_items.Vehicle import Vehicle
    from gui.server_events.bonuses import VehiclesBonus
_logger = logging.getLogger(__name__)
_MAIN_BONUS = 'vehicles'
_MAIN_BONUSES_AM = 3
_DEF_BNS_PRIORITY = 0
_BNS_PRIORITY_ORDER = (
 'goodies',
 'items',
 Currency.EVENT_COIN,
 PREMIUM_ENTITLEMENTS.BASIC,
 PREMIUM_ENTITLEMENTS.PLUS,
 'customizations',
 'vehicles')

def getWotAnniversaryBonusPacker():
    mapping = getDefaultBonusPackersMap()
    mapping.update({'vehicles': WotAnniversaryVehiclesBonusUIPacker(), 
       Currency.EVENT_COIN: SimpleBonusUIPacker()})
    return BonusUIPacker(mapping)


class WotAnniversaryVehiclesBonusUIPacker(VehiclesBonusUIPacker):

    @classmethod
    def _packVehicles(cls, bonus, vehicles):
        packedVehicles = []
        for vehicle, vehInfo in vehicles:
            packedVehicles.append(cls._packVehicle(bonus, vehInfo, vehicle))

        return packedVehicles

    @classmethod
    def _packVehicleBonusModel(cls, bonus, vehInfo, isRent, vehicle):
        model = VehicleBonusModel()
        cls.__fillVehicle(model, vehicle)
        model.setName(bonus.getName())
        return model

    @classmethod
    def __fillVehicle(cls, model, vehicle):
        model.setIsElite(not vehicle.getEliteStatusProgress().toUnlock or vehicle.isElite)
        model.setVehicleLvl(vehicle.level)
        model.setVehicleName(vehicle.userName)
        model.setVehicleType(vehicle.type)
        model.setBigIcon(getIconResourceName(getNationLessName(vehicle.name)))


def packBonusModelAndTooltipData(bonuses, bonusModelsList, tooltipData=None):
    bonusIndexTotal = 0
    if tooltipData is not None:
        bonusIndexTotal = len(tooltipData)
    packer = getWotAnniversaryBonusPacker()
    for bonus in bonuses:
        if bonus.isShowInGUI():
            bonusList = packer.pack(bonus)
            bonusTooltipList = []
            bonusContentIdList = []
            if bonusList and tooltipData is not None:
                bonusTooltipList = packer.getToolTip(bonus)
                bonusContentIdList = packer.getContentId(bonus)
            for bonusIndex, item in enumerate(bonusList):
                item.setIndex(bonusIndex)
                bonusModelsList.addViewModel(item)
                if tooltipData is not None:
                    tooltipIdx = str(bonusIndexTotal)
                    item.setTooltipId(tooltipIdx)
                    if bonusTooltipList:
                        tooltipData[tooltipIdx] = bonusTooltipList[bonusIndex]
                    if bonusContentIdList:
                        item.setTooltipContentId(str(bonusContentIdList[bonusIndex]))
                    bonusIndexTotal += 1

    return


def composeBonuses(bonuses):
    bonusesItems = []
    for k, v in bonuses.items():
        bonusesItems.extend(getNonQuestBonuses(k, v))

    bonusesItems = splitBonuses(bonusesItems)
    bonusesItems.sort(key=getPriority, reverse=True)
    mainBonusesAm = 1 if _MAIN_BONUS == bonusesItems[0].getName() else _MAIN_BONUSES_AM
    mainBonusesCnt = min(len(bonusesItems), mainBonusesAm)
    mainBonuses = bonusesItems[:mainBonusesCnt]
    otherBonuses = bonusesItems[mainBonusesCnt:]
    return (
     mergeBonuses(mainBonuses), mergeBonuses(otherBonuses))


def getPriority(bonus):
    if not bonus:
        return _DEF_BNS_PRIORITY
    bonusType = bonus.getName()
    if bonusType in _BNS_PRIORITY_ORDER:
        return _BNS_PRIORITY_ORDER.index(bonusType)
    return _DEF_BNS_PRIORITY