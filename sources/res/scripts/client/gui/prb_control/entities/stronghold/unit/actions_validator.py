from constants import BATTLE_MODE_VEH_TAGS_EXCEPT_CLAN
from gui.prb_control import prb_getters
from gui.prb_control.entities.base.squad.actions_validator import UnitActionsValidator
from gui.prb_control.entities.base.unit.actions_validator import UnitVehiclesValidator, CommanderValidator, UnitStateValidator, UnitPlayerValidator
from gui.prb_control.items import ValidationResult
from gui.prb_control.settings import UNIT_RESTRICTION

class StrongholdVehiclesValidator(UnitVehiclesValidator):
    _BATTLE_MODE_VEHICLE_TAGS = BATTLE_MODE_VEH_TAGS_EXCEPT_CLAN


class StrongholdUnitSlotsValidator(CommanderValidator):

    def _validate(self):
        rosterSettings = self._entity.getRosterSettings()
        stats = self._entity.getStats()
        isPlayersMatchingAvailable = self._entity.isPlayersMatchingAvailable()
        hasEventFrozenVehicles = self._entity.hasEventFrozenVehicles()
        allMembersReady = stats.readyCount == stats.occupiedSlotsCount
        if isPlayersMatchingAvailable:
            isClanMembersEnough = stats.clanMembersInRoster >= rosterSettings.getMinClanMembersCount()
            if not isClanMembersEnough:
                return ValidationResult(False, UNIT_RESTRICTION.UNIT_MIN_CLAN_MEMBERS)
            if not allMembersReady:
                return ValidationResult(False, UNIT_RESTRICTION.NOT_READY_IN_SLOTS)
            if stats.occupiedSlotsCount < rosterSettings.getMaxSlots() + 1:
                return ValidationResult(True, UNIT_RESTRICTION.UNIT_WILL_SEARCH_PLAYERS)
        else:
            if rosterSettings.getMinSlots() > stats.occupiedSlotsCount:
                return ValidationResult(False, UNIT_RESTRICTION.MIN_SLOTS)
            if not allMembersReady:
                return ValidationResult(False, UNIT_RESTRICTION.NOT_READY_IN_SLOTS)
        if hasEventFrozenVehicles:
            return ValidationResult(True, UNIT_RESTRICTION.HAS_FROZEN_VEHICLES)
        return super(StrongholdUnitSlotsValidator, self)._validate()


class StrongholdUnitStateValidator(UnitStateValidator):

    def _validate(self):
        if self._entity.inPlayersMatchingMode():
            return ValidationResult(False, UNIT_RESTRICTION.UNIT_IS_IN_PLAYERS_MATCHING)
        return super(StrongholdUnitStateValidator, self)._validate()


class StrongholdUnitPlayerValidator(UnitPlayerValidator):

    def _validate(self):
        if self._entity.inPlayersMatchingMode():
            return ValidationResult(False, UNIT_RESTRICTION.UNIT_IS_IN_PLAYERS_MATCHING)
        if prb_getters.isParentControlActivated():
            return ValidationResult(False, UNIT_RESTRICTION.PLAY_LIMITS_IS_ACTIVE)
        return super(StrongholdUnitPlayerValidator, self)._validate()


class StrongholdActionsValidator(UnitActionsValidator):

    def _createVehiclesValidator(self, entity):
        return StrongholdVehiclesValidator(entity)

    def _createSlotsValidator(self, entity):
        return StrongholdUnitSlotsValidator(entity)

    def _createStateValidator(self, entity):
        return StrongholdUnitStateValidator(entity)

    def _createPlayerValidator(self, entity):
        return StrongholdUnitPlayerValidator(entity)