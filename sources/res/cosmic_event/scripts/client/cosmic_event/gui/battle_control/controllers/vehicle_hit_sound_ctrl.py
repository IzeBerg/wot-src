from gui.battle_control.battle_constants import BATTLE_CTRL_ID
from gui.battle_control.controllers.interfaces import IBattleController
from skeletons.gui.sounds import IVehicleHitSound

class CosmicVehicleHitSound(IVehicleHitSound, IBattleController):

    def startControl(self, *args):
        pass

    def stopControl(self):
        pass

    def getControllerID(self):
        return BATTLE_CTRL_ID.VEHICLE_HIT_SOUND

    def getSoundStringFromHitFlags(self, enemyVehID, hitFlags, enemiesHitCount):
        return