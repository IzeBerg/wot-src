from gui.battle_results.reusable.shared import VehicleSummarizeInfo, VehicleDetailedInfo, no_key_error

class HalloweenVehicleDetailedInfo(VehicleDetailedInfo):
    __slots__ = ('_hwPhase', '_hwPhasesCount', '_effectivenessKeys', '_bossKeys', '_totalKeys',
                 '_hwTeamFightPlace', '_hwVehiclesRespawnCount', '_hwDefBestTime')

    @classmethod
    @no_key_error
    def makeForVehicle(cls, vehicleID, vehicle, player, vehicleRecords, critsRecords=None):
        info = super(HalloweenVehicleDetailedInfo, cls).makeForVehicle(vehicleID, vehicle, player, vehicleRecords, critsRecords=critsRecords)
        info._hwPhase = vehicleRecords['halloween_phase']
        info._hwPhasesCount = vehicleRecords['halloween_phases_count']
        effectivenessKeys, bossKeys = vehicleRecords['artefactKeys']
        info._effectivenessKeys = effectivenessKeys
        info._bossKeys = bossKeys
        info._totalKeys = sum(vehicleRecords['artefactKeys'])
        info._hwTeamFightPlace = vehicleRecords['hwTeamFightPlace']
        info._hwVehiclesRespawnCount = vehicleRecords['hwVehiclesRespawnCount']
        info._hwDefBestTime = vehicleRecords.get('hwDefBestTime', 0)
        return info

    @property
    def hwDefBestTime(self):
        return self._hwDefBestTime

    @property
    def hwPhase(self):
        return self._hwPhase

    @property
    def hwPhasesCount(self):
        return self._hwPhasesCount

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
        return max(1, self._damageDealt)

    @property
    def hwTeamFightPlace(self):
        return self._hwTeamFightPlace

    @property
    def hwVehiclesRespawnCount(self):
        return self._hwVehiclesRespawnCount


class HalloweenVehicleSummarizeInfo(VehicleSummarizeInfo):

    @property
    def hwDefBestTime(self):
        return min(self._getAtrributeGenerator('hwDefBestTime'))

    @property
    def hwPhase(self):
        return self._accumulate('hwPhase')

    @property
    def hwPhasesCount(self):
        return self._accumulate('hwPhasesCount')

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

    @property
    def hwVehiclesRespawnCount(self):
        return self._accumulate('hwVehiclesRespawnCount')