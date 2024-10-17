from helpers import dependency
from skeletons.gui.battle_session import IBattleSessionProvider

class VehicleHealthBroadcastListenerComponent(object):
    guiSessionProvider = dependency.descriptor(IBattleSessionProvider)

    def onEnterWorld(self, prereqs=None):
        pass

    def onLeaveWorld(self):
        pass

    def handleKey(self, isDown, key, mods):
        pass

    def onBecomePlayer(self):
        pass

    def onBecomeNonPlayer(self):
        pass

    def onVehicleHealthChanged(self, vehicleID, newHealth, attackerID, attackReasonID, attackReasonExtID):
        self.guiSessionProvider.setVehicleHealth(False, vehicleID, newHealth, attackerID, attackReasonID)