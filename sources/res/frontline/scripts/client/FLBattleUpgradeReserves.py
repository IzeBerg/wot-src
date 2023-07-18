import BigWorld
from ReservesEvents import randomReservesEvents

class FLBattleUpgradeReserves(BigWorld.DynamicScriptComponent):

    def onEnterWorld(self, *args):
        pass

    def onLeaveWorld(self, *args):
        pass

    def set_upgradeReadinessTime(self, _):
        vehicle = self.entity
        if vehicle.id == BigWorld.player().playerVehicleID:
            randomReservesEvents.onUpdate(self.upgradeReadinessTime.totalTime, self.upgradeReadinessTime.reason)