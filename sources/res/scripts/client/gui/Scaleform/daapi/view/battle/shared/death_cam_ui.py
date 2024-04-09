import logging
from gui.Scaleform.framework.entities.inject_component_adaptor import InjectComponentAdaptor
from gui.impl.battle.death_cam.death_cam_hud_view import DeathCamHudView
from helpers import dependency
from skeletons.account_helpers.settings_core import ISettingsCore
from skeletons.gui.lobby_context import ILobbyContext
_logger = logging.getLogger(__name__)

class DeathCamUI(InjectComponentAdaptor):
    __slots__ = ('__isArenaLoaded', '__isEnabledByServer')
    lobbyContext = dependency.descriptor(ILobbyContext)
    settingsCore = dependency.descriptor(ISettingsCore)

    def _onPopulate(self):
        self._updateInjectedViewState()

    def _makeInjectView(self):
        return DeathCamHudView()

    def __onSettingsChanged(self, diff):
        self._updateInjectedViewState()

    def _updateInjectedViewState(self):
        self._createInjectView()