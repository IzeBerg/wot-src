import BigWorld, TriggersManager
from cgf_obsolete_script.py_component import Component
from cgf_obsolete_script.auto_properties import LinkDescriptor
from helpers.CallbackDelayer import CallbackDelayer
from constants import GROUND_TYPE_NAME_BY_INDEX
_PERIODIC_TIME = 0.25

class TutorialMatKindsController(Component, CallbackDelayer):
    terrainGroundTypesLink = LinkDescriptor()

    def __init__(self):
        CallbackDelayer.__init__(self)
        self.__wasOnSoftTerrain = False

    def destroy(self):
        self.deactivate()
        CallbackDelayer.destroy(self)

    def activate(self):
        self.delayCallback(_PERIODIC_TIME, self.__onPeriodicTimer)

    def deactivate(self):
        self.stopCallback(self.__onPeriodicTimer)

    def __onPeriodicTimer(self):
        isOnSoftTerrain = False
        groundTypes = self.terrainGroundTypesLink()
        for groundType in groundTypes:
            isOnSoftTerrain = isOnSoftTerrain or GROUND_TYPE_NAME_BY_INDEX[groundType] == 'soft'

        if self.__wasOnSoftTerrain != isOnSoftTerrain:
            self.__wasOnSoftTerrain = isOnSoftTerrain
            if isOnSoftTerrain:
                TriggersManager.g_manager.activateTrigger(TriggersManager.TRIGGER_TYPE.PLAYER_VEHICLE_ON_SOFT_TERRAIN)
            else:
                TriggersManager.g_manager.deactivateTrigger(TriggersManager.TRIGGER_TYPE.PLAYER_VEHICLE_ON_SOFT_TERRAIN)
        return _PERIODIC_TIME