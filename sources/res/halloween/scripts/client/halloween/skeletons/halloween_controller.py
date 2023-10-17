from skeletons.gui.game_control import IGameController

class IHalloweenController(IGameController):
    onSettingsUpdate = None
    onEventDisabled = None

    def isEnabled(self):
        raise NotImplementedError

    def isBattlesEnabled(self):
        raise NotImplementedError

    def isAvailable(self):
        raise NotImplementedError

    def getModeSettings(self):
        raise NotImplementedError

    def getConfig(self):
        raise NotImplementedError

    def selectBattle(self):
        raise NotImplementedError

    def openHangar(self):
        raise NotImplementedError

    def isEventHangar(self):
        raise NotImplementedError

    def selectRandomMode(self):
        raise NotImplementedError

    def selectVehicle(self, invID):
        raise NotImplementedError

    def hasAccessToVehicle(self, vehTypeCD):
        raise NotImplementedError