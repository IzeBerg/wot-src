from typing import TYPE_CHECKING
from skeletons.gui.game_control import IGameController, ISeasonProvider
if TYPE_CHECKING:
    from cosmic_event.gui.prebattle_hints.random_prb_hints import PrbRandomHintManager
    from Event import Event
    from cosmic_event_common.configs.CosmicBattleConfig import CosmicBattleConfigModel
    from cosmic_event.gui.impl.gen.view_models.views.lobby.cosmic_lobby_view.cosmic_lobby_view_model import LobbyRouteEnum
    from typing import Optional

class ICosmicEventBattleController(IGameController, ISeasonProvider):
    onPrimeTimeStatusUpdated = None
    onCosmicConfigChanged = None
    onStatusTick = None
    onLobbyRouteChange = None

    @property
    def prbHintManager(self):
        return

    @property
    def isEnabled(self):
        raise NotImplementedError

    def getEventVehicle(self):
        raise NotImplementedError

    def isPrbActive(self):
        raise NotImplementedError

    def isAvailable(self):
        raise NotImplementedError

    def isBattleAvailable(self):
        raise NotImplementedError

    def isFrozen(self):
        raise NotImplementedError

    def switchPrb(self, cameraData=False):
        raise NotImplementedError

    def onPrbEnter(self):
        raise NotImplementedError

    def onPrbLeave(self):
        raise NotImplementedError

    def getModeSettings(self):
        raise NotImplementedError

    def showQueueUI(self):
        raise NotImplementedError

    def showMainRoute(self):
        raise NotImplementedError

    def leaveQueue(self):
        raise NotImplementedError

    def openEventLobby(self):
        raise NotImplementedError

    def getTokenProgressionID(self):
        raise NotImplementedError

    def getProgressionQuestPrefix(self):
        raise NotImplementedError

    def getVehicleRentQuestID(self):
        raise NotImplementedError

    def getProgressionChapterTokens(self):
        raise NotImplementedError

    def getLobbyRoute(self):
        raise NotImplementedError

    def setLobbyRoute(self, route, notify=False):
        raise NotImplementedError

    def isVehicleRentQuest(self, questID):
        raise NotImplementedError

    def closeRewardScreen(self):
        raise NotImplementedError

    def closePostBattleScreen(self):
        raise NotImplementedError

    def getProgressionQuestGroupId(self):
        raise NotImplementedError

    def getArtifactToken(self):
        raise NotImplementedError