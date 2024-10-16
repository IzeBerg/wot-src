from gui.server_events.awards_formatters import AWARDS_SIZES
from halloween.gui.game_control.halloween_artefacts_controller import compareBonusesByPriority
from halloween.gui.impl.gen.view_models.views.common.bonus_item_view_model import BonusItemViewModel
from halloween.gui.impl.gen.view_models.views.lobby.widgets.meta_view_model import ArtefactStates
from halloween.gui.impl.lobby.hw_helpers.bonuses_formatters import getHWMetaAwardFormatter, getImgName, HalloweenBonusesAwardsComposer
from halloween.gui.impl.gen.view_models.views.lobby.widgets.hangar_carousel_def_view_model import VehicleStates
from halloween.skeletons.halloween_artefacts_controller import IHalloweenArtefactsController
from halloween.skeletons.halloween_controller import IHalloweenController
from helpers import dependency
from items.tankmen import MAX_SKILLS_EFFICIENCY

@dependency.replace_none_kwargs(ctrl=IHalloweenController)
def getVehicleState(vehicle, ctrl=None):
    if not ctrl.hasAccessToVehicle(vehicle.intCD):
        return VehicleStates.LOCKED
    if vehicle.isInBattle:
        return VehicleStates.INBATTLE
    if vehicle.isInUnit:
        return VehicleStates.INPLATOON
    return VehicleStates.DEFAULT


def getDefVehicalState(vehicle):
    state = VehicleStates.DEFAULT.value
    if vehicle.isInBattle:
        return VehicleStates.INBATTLE.value
    else:
        if vehicle.isInUnit:
            return VehicleStates.INPLATOON.value
        if vehicle.rentalIsOver:
            if vehicle.isWotPlus:
                return VehicleStates.SUSPENDED.value
            return VehicleStates.RENTED.value
        if vehicle.isBroken:
            return VehicleStates.REPAIR.value
        if not vehicle.isCrewFull:
            return VehicleStates.CREWINCOMPLETE.value
        for _, tankman in vehicle.crew:
            if tankman is not None:
                if not tankman.canUseSkillsInCurrentVehicle or not tankman.isMaxRoleLevel:
                    state = VehicleStates.UNTRAINEDCREW.value
                    break
                if tankman.currentVehicleSkillsEfficiency < MAX_SKILLS_EFFICIENCY:
                    state = VehicleStates.LOWEFFICIENCY.value

        return state


@dependency.replace_none_kwargs(ctrl=IHalloweenArtefactsController)
def getArtefactState(artefactID, ctrl=None):
    state = ArtefactStates.INPROGRESS
    if ctrl.isArtefactReceived(artefactID):
        state = ArtefactStates.RECIVE
    elif ctrl.isArtefactOpened(artefactID):
        state = ArtefactStates.OPEN
    return state


@dependency.replace_none_kwargs(ctrl=IHalloweenArtefactsController)
def fillRewards(artefact, bonusModels, maxBonuseInView, idGen, ctrl=None, skipBonuses=None):
    bonusCache = {}
    bonusRewards = artefact.bonusRewards
    formatter = HalloweenBonusesAwardsComposer(maxBonuseInView, getHWMetaAwardFormatter())
    sortedBonuses = sorted(bonusRewards, cmp=compareBonusesByPriority)
    bonusRewards = formatter.getFormattedBonuses(sortedBonuses, AWARDS_SIZES.BIG)
    for bonus in bonusRewards:
        tooltipId = ('{}').format(idGen.next())
        bonusCache[tooltipId] = bonus
        if ctrl.getIsHiddenBonusStyle(bonus) or skipBonuses is not None and bonus.bonusName in skipBonuses:
            continue
        reward = BonusItemViewModel()
        reward.setUserName(str(bonus.userName))
        reward.setName(bonus.bonusName)
        reward.setValue(str(bonus.label))
        reward.setLabel(str(bonus.label))
        reward.setIcon(getImgName(bonus.getImage(AWARDS_SIZES.BIG)))
        reward.setOverlayType(bonus.getOverlayType(AWARDS_SIZES.SMALL))
        reward.setTooltipId(tooltipId)
        bonusModels.addViewModel(reward)

    return bonusCache