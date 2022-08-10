import typing
from constants import PREMIUM_ENTITLEMENTS
from gui import GUI_NATIONS_ORDER_INDEX
from gui.Scaleform.genConsts.TOOLTIPS_CONSTANTS import TOOLTIPS_CONSTANTS
from gui.impl.auxiliary.rewards_helper import BlueprintBonusTypes
from gui.impl import backport
from gui.impl.gen import R
from gui.impl.gen.view_models.common.missions.bonuses.icon_bonus_model import IconBonusModel
from gui.impl.gen.view_models.views.lobby.battle_matters.battle_matters_vehicle_model import BattleMattersVehicleModel
from gui.impl.gen.view_models.views.lobby.battle_matters.battle_matters_main_view_model import BattleMattersMainViewModel
from gui.selectable_reward.constants import SELECTABLE_BONUS_NAME
from gui.selectable_reward.bonus_packers import SelectableBonusPacker
from gui.shared.missions.packers.bonus import VehiclesBonusUIPacker, getDefaultBonusPackersMap, BonusUIPacker, BlueprintBonusUIPacker
from gui.shared.gui_items.Vehicle import getIconResourceName
from gui.shared.gui_items.Vehicle import getNationLessName
from gui.shared.money import Currency
from gui.server_events.bonuses import VehiclesBonus, BlueprintsBonusSubtypes
from nations import NONE_INDEX
from helpers import dependency
from skeletons.gui.battle_matters import IBattleMattersController
from shared_utils import first
if typing.TYPE_CHECKING:
    from gui.shared.gui_items.Vehicle import Vehicle
_REWARDS_ORDER = ('vehicles', 'battleToken', 'tokens', 'crewBooks', 'customizations', 'items',
 PREMIUM_ENTITLEMENTS.PLUS, PREMIUM_ENTITLEMENTS.BASIC, Currency.CRYSTAL, Currency.GOLD, 'freeXP',
 Currency.CREDITS, 'blueprintsAny', BlueprintBonusTypes.BLUEPRINTS, 'goodies', 'slots')

def bonusesSort(firstBonus, secondBonus):
    firstBonusName = firstBonus.getName()
    secondBonusName = secondBonus.getName()
    if firstBonusName == secondBonusName == BlueprintBonusTypes.BLUEPRINTS:
        result = blueprintsCmp(firstBonus, secondBonus)
    else:
        result = indexesCmp(_REWARDS_ORDER, firstBonusName, secondBonusName)
    return result


def indexesCmp(sequence, firstBonusName, secondBonusName):
    firstOrder = secondOrder = len(sequence)
    if firstBonusName in sequence:
        firstOrder = sequence.index(firstBonusName)
    if secondBonusName in sequence:
        secondOrder = sequence.index(secondBonusName)
    return cmp(firstOrder, secondOrder)


def blueprintsCmp(firstBonus, secondBonus):
    firstBlueprintName = firstBonus.getBlueprintName()
    secondBlueprintName = secondBonus.getBlueprintName()
    result = 0
    if firstBlueprintName == BlueprintsBonusSubtypes.UNIVERSAL_FRAGMENT:
        result = -1
    elif firstBlueprintName == secondBlueprintName == BlueprintsBonusSubtypes.NATION_FRAGMENT:
        result = _blueprintsNationCmp(firstBonus, secondBonus)
    return result


def _blueprintsNationCmp(firstBonus, secondBonus):
    return cmp(GUI_NATIONS_ORDER_INDEX.get(firstBonus.getImageCategory(), NONE_INDEX), GUI_NATIONS_ORDER_INDEX.get(secondBonus.getImageCategory(), NONE_INDEX))


def getBattleMattersBonusPacker():
    mapping = getDefaultBonusPackersMap()
    mapping.update({VehiclesBonus.VEHICLES_BONUS: BattleMattersVehiclesBonusUIPacker(), 
       BlueprintBonusTypes.BLUEPRINTS: BattleMattersBlueprintBonusUIPacker(), 
       SELECTABLE_BONUS_NAME: BattleMattersTokenBonusUIPacker()})
    return BonusUIPacker(mapping)


class BattleMattersBlueprintBonusUIPacker(BlueprintBonusUIPacker):

    @classmethod
    def _pack(cls, bonus):
        models = super(BattleMattersBlueprintBonusUIPacker, cls)._pack(bonus)
        model = first(models)
        if model:
            fragmentName = bonus.getBlueprintName()
            if fragmentName == BlueprintsBonusSubtypes.NATION_FRAGMENT:
                lbl = cls._getNationalLbl(bonus)
            else:
                lbl = bonus.getBlueprintTooltipName()
            model.setLabel(lbl)
        return models

    @classmethod
    def _getNationalLbl(cls, bonus):
        nation = bonus.getImageCategory()
        nationName = backport.text(R.strings.blueprints.nations.dyn(nation)())
        return backport.text(R.strings.quests.bonusName.blueprints.nation(), nationName=nationName)


class BattleMattersTokenBonusUIPacker(SelectableBonusPacker):
    __battleMattersController = dependency.descriptor(IBattleMattersController)

    @classmethod
    def _packSingleBonus(cls, bonus):
        model = IconBonusModel()
        if cls.__isVehicleReceived():
            vehicle = cls.__battleMattersController.getSelectedVehicle()
            if vehicle:
                model.setIcon(getIconResourceName(vehicle.name))
                model.setName(BattleMattersMainViewModel.NAME_VEHICLE_REWARD)
        else:
            model.setName(BattleMattersMainViewModel.NAME_TOKEN_REWARD)
            model.setValue(str(bonus.getCount()))
        return model

    @classmethod
    def _getToolTip(cls, bonus):
        if cls.__isVehicleReceived():
            vehicle = cls.__battleMattersController.getSelectedVehicle()
            return [
             backport.createTooltipData(isSpecial=True, specialArgs=(vehicle.intCD,), specialAlias=TOOLTIPS_CONSTANTS.CAROUSEL_VEHICLE)]

    @classmethod
    def __isVehicleReceived(cls):
        quest = first(cls.__battleMattersController.getQuestsWithDelayedReward())
        return quest and quest.isCompleted() and not cls.__battleMattersController.hasDelayedRewards()

    @classmethod
    def _makeRewardItemModel(cls):
        pass

    @classmethod
    def _getTooltipSpecialAlias(cls):
        pass


class BattleMattersVehiclesBonusUIPacker(VehiclesBonusUIPacker):

    @classmethod
    def _packVehicleBonusModel(cls, bonus, vehInfo, isRent, vehicle):
        currentVehicle = BattleMattersVehicleModel()
        rentLength = bonus.getRentDays(vehInfo)
        if rentLength:
            currentVehicle.setRentLength(rentLength)
        currentVehicle.setIsInHangar(vehicle.isInInventory)
        currentVehicle.setVehCD(vehicle.intCD)
        currentVehicle.setVehType(vehicle.type)
        currentVehicle.setLevel(vehicle.level)
        currentVehicle.setNation(vehicle.nationName)
        currentVehicle.setVehName(getNationLessName(vehicle.name))
        currentVehicle.setUserName(vehicle.userName)
        currentVehicle.setIsElite(vehicle.isElite)
        return currentVehicle