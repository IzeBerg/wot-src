import BigWorld
from gui.battle_control.battle_constants import VEHICLE_VIEW_STATE
from constants import LootAction
from debug_utils import LOG_DEBUG_DEV

class CosmicVehicleLoot(BigWorld.DynamicScriptComponent):

    def __invalidateState(self, action, time):
        LOG_DEBUG_DEV('__invalidateState', self.lootID, self.lootTypeID, action, time)
        self.entity.guiSessionProvider.invalidateVehicleState(VEHICLE_VIEW_STATE.LOOT, (self.lootID, self.lootTypeID, action, time))

    def __init__(self):
        super(CosmicVehicleLoot, self).__init__()
        if self.pickupTotalTime:
            totalTime = self.pickupTotalTime
        else:
            totalTime = max(self.pickupEndTime - BigWorld.serverTime(), 0)
        self.__invalidateState(LootAction.PICKUP_STARTED, totalTime)

    def onDestroy(self):
        if self.pickupEndTime > 0:
            self.__invalidateState(LootAction.PICKUP_FAILED, 0)
        else:
            self.__invalidateState(LootAction.PICKUP_SUCCEEDED, 0)