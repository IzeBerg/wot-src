import logging
from cosmic_event.skeletons.battle_controller import ICosmicEventBattleController
from cosmic_event.skeletons.progression_controller import ICosmicEventProgressionController
from helpers import dependency
from notification.actions_handlers import NavigationDisabledActionHandler
from notification.settings import NOTIFICATION_TYPE
from cosmic_event.gui.impl.gen.view_models.views.lobby.cosmic_lobby_view.cosmic_lobby_view_model import LobbyRouteEnum
_logger = logging.getLogger(__name__)

@dependency.replace_none_kwargs(ctrl=ICosmicEventBattleController)
def _switchCosmic(ctrl=None):
    ctrl.switchPrb()
    ctrl.closeRewardScreen()
    ctrl.closePostBattleScreen()


class ProgressionDetailsActionHandler(NavigationDisabledActionHandler):
    _cosmicProgression = dependency.descriptor(ICosmicEventProgressionController)

    def doAction(self, model, entityID, action):
        self._cosmicProgression.setProgressionLobbyRoute()
        _switchCosmic()

    @classmethod
    def getNotType(cls):
        return NOTIFICATION_TYPE.MESSAGE

    @classmethod
    def getActions(cls):
        return ('cosmicProgressionDetailsAction', )


class ArtifactResearchActionHandler(NavigationDisabledActionHandler):
    _cosmicController = dependency.descriptor(ICosmicEventBattleController)

    def doAction(self, model, entityID, action):
        self._cosmicController.setLobbyRoute(LobbyRouteEnum.RESEARCH, True)
        _switchCosmic()

    @classmethod
    def getNotType(cls):
        return NOTIFICATION_TYPE.MESSAGE

    @classmethod
    def getActions(cls):
        return ('cosmicOpenArtifactResearchScreenAction', )


class CosmicEventOpenHandler(NavigationDisabledActionHandler):

    def doAction(self, model, entityID, action):
        _switchCosmic()

    @classmethod
    def getNotType(cls):
        return NOTIFICATION_TYPE.MESSAGE

    @classmethod
    def getActions(cls):
        return ('cosmicEventOpenAction', )