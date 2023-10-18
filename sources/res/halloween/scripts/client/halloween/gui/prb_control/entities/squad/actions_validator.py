from CurrentVehicle import g_currentPreviewVehicle, g_currentVehicle
from gui.prb_control.entities.base.squad.actions_validator import SquadActionsValidator, SquadVehiclesValidator
from gui.prb_control.settings import UNIT_RESTRICTION
from gui.shared.gui_items.Vehicle import Vehicle
from halloween_common.halloween_constants import UNIT_HALLOWEEN_EXTRA_DATA_KEY, UNIT_DIFFICULTY_LEVELS_KEY, CURRENT_QUEUE_TYPE_KEY
from helpers import dependency
from gui.prb_control.items import ValidationResult
from halloween.skeletons.halloween_controller import IHalloweenController
from shared_utils import findFirst
from skeletons.gui.game_control import IPlatoonController

class HalloweenStateValidator(SquadVehiclesValidator):
    __halloweenBattleCtrl = dependency.descriptor(IHalloweenController)
    __platoonCtrl = dependency.descriptor(IPlatoonController)

    def _validate(self):
        if not self.__halloweenBattleCtrl.isBattlesEnabled():
            return ValidationResult(False, UNIT_RESTRICTION.MODE_NOT_AVAILABLE)
        else:
            if g_currentPreviewVehicle.isPresent() or g_currentPreviewVehicle.isHalloweenStylePreviewActive():
                return ValidationResult(False, UNIT_RESTRICTION.PREVIEW_VEHICLE_IS_PRESENT)
            _, unit = self._entity.getUnit()
            playerInfo = self.__platoonCtrl.getPlayerInfo()
            if unit and playerInfo:
                queueType = unit._extras.get(CURRENT_QUEUE_TYPE_KEY)
                queueTypes = playerInfo.extraData.get(UNIT_HALLOWEEN_EXTRA_DATA_KEY, {}).get(UNIT_DIFFICULTY_LEVELS_KEY, [])
                if queueType not in queueTypes:
                    return ValidationResult(False, UNIT_RESTRICTION.UNIT_WRONG_DATA)
            vehicle = g_currentVehicle.item
            if vehicle and not self.__halloweenBattleCtrl.hasAccessToVehicle(vehicle.intCD):
                return ValidationResult(False, UNIT_RESTRICTION.VEHICLE_NOT_VALID)
            vInfos = self._getVehiclesInfo()
            if not findFirst(lambda v: not v.isEmpty(), vInfos, False):
                return ValidationResult(False, UNIT_RESTRICTION.VEHICLE_NOT_SELECTED)
            for vInfo in vInfos:
                vehicle = vInfo.getVehicle()
                if vehicle is not None:
                    if not vehicle.isReadyToPrebattle(checkForRent=self._isCheckForRent()):
                        if not vehicle.isCrewFull:
                            return ValidationResult(False, UNIT_RESTRICTION.VEHICLE_CREW_NOT_FULL)
                        if vehicle.isInBattle:
                            return ValidationResult(False, UNIT_RESTRICTION.VEHICLE_IS_IN_BATTLE)
                        return ValidationResult(False, UNIT_RESTRICTION.VEHICLE_NOT_VALID)
                    state, _ = vehicle.getState()
                    if state == Vehicle.VEHICLE_STATE.UNSUITABLE_TO_QUEUE:
                        return ValidationResult(False, UNIT_RESTRICTION.VEHICLE_WRONG_MODE)

            return


class HalloweenSquadActionsValidator(SquadActionsValidator):

    def _createVehiclesValidator(self, entity):
        return HalloweenStateValidator(entity)