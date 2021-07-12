from constants import PREBATTLE_ACCOUNT_STATE, PREBATTLE_TYPE
from gui.prb_control.entities.base.limits import AbstractTeamIsValid, LimitsCollection, VehicleIsValid, TeamNoPlayersInBattle, TeamIsValid
from gui.prb_control.settings import PREBATTLE_RESTRICTION
from skeletons.gui.shared import IItemsCache
from helpers import dependency
from items import vehicles

class ObserverInTeamIsValid(AbstractTeamIsValid):
    itemsCache = dependency.descriptor(IItemsCache)

    def check(self, rosters, team, teamLimits):
        accountsInfo = self._getAccountsInfo(rosters, team)
        if len(accountsInfo) < teamLimits['minCount']:
            return (False, 'limit/minCount')
        if self.__isAllObservers(accountsInfo):
            return (False, 'observers')
        return (
         True, '')

    @classmethod
    def __isAllObservers(cls, accountsInfo):
        if not accountsInfo:
            return False
        for accInfo in accountsInfo.itervalues():
            if not accInfo['state'] & PREBATTLE_ACCOUNT_STATE.READY:
                continue
            if 'vehTypeCompDescr' not in accInfo or 'vehLevel' not in accInfo:
                vehDescr = vehicles.VehicleDescr(compactDescr=accInfo['vehCompDescr'])
                vehTypeCompDescr = vehDescr.type.compactDescr
            else:
                vehTypeCompDescr = accInfo['vehTypeCompDescr']
            if not cls.itemsCache.items.getItemByCD(vehTypeCompDescr).isObserver:
                return False

        return True


class EpicVehicleIsValid(VehicleIsValid):

    def check(self, teamLimits):
        isValid, restriction = super(EpicVehicleIsValid, self).check(teamLimits)
        if restriction == PREBATTLE_RESTRICTION.VEHICLE_EPIC_ONLY:
            return (True, '')
        return (isValid, restriction)


class EpicBattleTrainingLimits(LimitsCollection):

    def __init__(self, entity):
        super(EpicBattleTrainingLimits, self).__init__(entity, (
         EpicVehicleIsValid(),), (
         TeamNoPlayersInBattle(PREBATTLE_TYPE.EPIC_TRAINING),
         TeamIsValid(),
         ObserverInTeamIsValid()))