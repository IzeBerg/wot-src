import SoundGroups, nations
from constants import ARENA_PERIOD
from gui.impl import backport
from gui.impl.gen import R
from gui.shared.formatters import text_styles
from helpers import dependency
from items import vehicles
from items.artefacts import ImprovedConfiguration, StillVehicleOptionalDevice
from items.vehicles import VEHICLE_DEVICE_INDICES
from skeletons.gui.battle_session import IBattleSessionProvider
OPT_DEVICE_USED = 'OPT_DEVICE_USED'

def _getDescriptor(deviceID):
    return vehicles.g_cache.optionalDevices()[deviceID]


def createOptDeviceInBattle(deviceID, status):
    descriptor = _getDescriptor(deviceID)
    if isinstance(descriptor, ImprovedConfiguration):
        return ResurrectionOptDeviceInBattle(deviceID, status)
    if isinstance(descriptor, StillVehicleOptionalDevice):
        return StillStillOptDeviceInBattle(deviceID, status)
    return OptDeviceInBattle(deviceID, status)


class DevicesSound(object):
    __eventsMap = {'camouflageNet': ('camo_net_start', 'camo_net_stop'), 
       'stereoscope': ('stereo_trumpet_start', 'stereo_trumpet_stop')}
    __resurrectionEventsMap = {'ammoBay': 'cons_wet_ammo', 
       'fuelTank': 'cons_co2', 
       'engine': 'cons_cyclone_filter'}
    __enabled = False

    @classmethod
    def arenaPeriodChange(cls, period):
        cls.__enabled = period == ARENA_PERIOD.BATTLE

    @classmethod
    def playSound(cls, deviceID, isOn):
        if cls.__enabled:
            events = cls.__eventsMap.get(deviceID, None)
            if events is not None:
                SoundGroups.g_instance.playSound2D(events[(0 if isOn else 1)])
        return

    @classmethod
    def playResurrectionSound(cls, resurrectionName):
        if cls.__enabled:
            event = cls.__resurrectionEventsMap.get(resurrectionName, None)
            if event:
                SoundGroups.g_instance.playSound2D(event)
        return


class OptDeviceInBattle(object):
    sessionProvider = dependency.descriptor(IBattleSessionProvider)

    def __init__(self, deviceID, status):
        self._deviceID = deviceID
        self._status = status
        self._lastStatus = status

    def __repr__(self):
        return ('OptDeviceInBattle({0!r:s})').format(self._status)

    @property
    def deviceID(self):
        return self._deviceID

    def isNeedGlow(self):
        return False

    def getStatus(self):
        return self._status

    def getDescriptor(self):
        return vehicles.g_cache.optionalDevices()[self._deviceID]

    def getIntCD(self):
        return vehicles.makeIntCompactDescrByID('optionalDevice', nations.NONE_INDEX, self._deviceID)

    def isUsed(self):
        return False

    def updateStatus(self, status):
        self._lastStatus = self._status
        self._status = status

    def getBattleStatus(self):
        return []

    def apply(self):
        pass


class StillStillOptDeviceInBattle(OptDeviceInBattle):

    def apply(self):
        if self._lastStatus != self._status:
            DevicesSound.playSound(self.getDescriptor().tierlessName, self._status)


class ResurrectionOptDeviceInBattle(OptDeviceInBattle):

    def getStatus(self):
        return self._status

    def isResurrectionDeviceEnable(self, deviceName):
        return 1 << VEHICLE_DEVICE_INDICES.get(deviceName) & self._status

    def isNeedGlow(self):
        return self._lastStatus != self._status and self._lastStatus

    def isUsed(self):
        return self._status == 0

    def getBattleStatus(self):
        result = []
        battleStatus = R.strings.artefacts.dyn(self.getDescriptor().groupName).dyn('battleStatus')
        for deviceName in self._getModules():
            if 1 << VEHICLE_DEVICE_INDICES.get(deviceName) & self._status:
                strFormatter, status = text_styles.statInfo, 'ready'
            else:
                strFormatter, status = text_styles.statusAlert, 'used'
            result.append(strFormatter(backport.text(battleStatus.dyn(deviceName).dyn(status)())))

        return result

    def apply(self):
        applyStatus = self._lastStatus ^ self._status
        if not applyStatus:
            return
        for deviceName in self._getModules():
            deviceMask = 1 << VEHICLE_DEVICE_INDICES.get(deviceName)
            if deviceMask & applyStatus and deviceMask & self._lastStatus:
                DevicesSound.playResurrectionSound(deviceName)
                SoundGroups.g_instance.playSound2D('cons_ui_activation')
                text = backport.text(R.strings.ingame_gui.optDeviceResurrection.dyn(deviceName)(), device=self.getDescriptor().userString)
                self.sessionProvider.shared.messages.onShowVehicleMessageByKey(OPT_DEVICE_USED, {'message': text})

    def _getModules(self):
        return ('engine', 'fuelTank', 'ammoBay')