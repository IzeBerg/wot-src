from gui.battle_results.reusable.shared import VehicleSummarizeInfo, VehicleDetailedInfo, no_key_error

class HalloweenVehicleDetailedInfo(VehicleDetailedInfo):
    __slots__ = ('_hwPhase', '_hwPhasesCount', '_soulsDelivered', '_effectivenessKeys',
                 '_bossKeys', '_totalKeys', '_hwTeamFightPlace')

    @classmethod
    @no_key_error
    def makeForVehicle(cls, vehicleID, vehicle, player, vehicleRecords, critsRecords=None):
        info = super(HalloweenVehicleDetailedInfo, cls).makeForVehicle(vehicleID, vehicle, player, vehicleRecords, critsRecords=critsRecords)
        info._hwPhase = vehicleRecords['halloween_phase']
        info._hwPhasesCount = vehicleRecords['halloween_phases_count']
        info._soulsDelivered = vehicleRecords['souls_delivered']
        effectivenessKeys, bossKeys = vehicleRecords['artefactKeys']
        info._effectivenessKeys = effectivenessKeys
        info._bossKeys = bossKeys
        info._totalKeys = sum(vehicleRecords['artefactKeys'])
        info._hwTeamFightPlace = vehicleRecords['hwTeamFightPlace']
        return info

    @property
    def hwPhase(self):
        return self._hwPhase

    @property
    def hwPhasesCount(self):
        return self._hwPhasesCount

    @property
    def soulsDelivered(self):
        return self._soulsDelivered

    @property
    def effectivenessKeys(self):
        return self._effectivenessKeys

    @property
    def bossKeys(self):
        return self._bossKeys

    @property
    def totalKeys(self):
        return self._totalKeys

    @property
    def hwTeamContribution(self):
        return max(1, self._damageDealt) * max(1, self._soulsDelivered)

    @property
    def hwTeamFightPlace(self):
        return self._hwTeamFightPlace


class HalloweenVehicleSummarizeInfo(VehicleSummarizeInfo):

    @property
    def hwPhase(self):
        return self._accumulate('hwPhase')

    @property
    def hwPhasesCount(self):
        return self._accumulate('hwPhasesCount')

    @property
    def soulsDelivered(self):
        return self._accumulate('soulsDelivered')

    @property
    def effectivenessKeys(self):
        return self._accumulate('effectivenessKeys')

    @property
    def bossKeys(self):
        return self._accumulate('bossKeys')

    @property
    def totalKeys(self):
        return self._accumulate('totalKeys')

    @property
    def hwTeamContribution(self):
        return self._accumulate('hwTeamContribution')

    @property
    def hwTeamFightPlace(self):
        return self._accumulate('hwTeamFightPlace')