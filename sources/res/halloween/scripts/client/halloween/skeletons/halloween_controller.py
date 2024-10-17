import typing
from skeletons.gui.game_control import IGameController
if typing.TYPE_CHECKING:
    from halloween.gui.game_control.halloween_controller import _HalloweenConfig, _DefenceVehiclesConfig
    from Event import Event

class IHalloweenController(IGameController):
    onSettingsUpdate = None
    onEventDisabled = None

    def isEnabled(self):
        raise NotImplementedError

    def isBattlesEnabled(self):
        raise NotImplementedError

    def isPromoScreenEnabled(self):
        raise NotImplementedError

    def isAvailable(self):
        raise NotImplementedError

    def getModeSettings(self):
        raise NotImplementedError

    def getConfig(self):
        raise NotImplementedError

    def selectBattle(self, *args, **kwargs):
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

    def getDefenceVehiclesConfig(self):
        raise NotImplementedError