import logging
from collections import namedtuple
import adisp, BigWorld, typing
from cosmic_event.gui.battle_results import CosmicBattleResultEvent
from frameworks.wulf import ViewStatus
from gui import SystemMessages
from gui.Scaleform.framework import ScopeTemplates
from gui.Scaleform.framework.managers.loaders import GuiImplViewLoadParams
from gui.app_loader import sf_lobby
from gui.battle_results import templates
from gui.battle_results.composer import StatsComposer
from gui.battle_results.settings import REQUEST_SOURCE
from gui.impl.gen import R
from gui.shared import g_eventBus, events, EVENT_BUS_SCOPE
from helpers import dependency
from skeletons.gui.impl import IGuiLoader
if typing.TYPE_CHECKING:
    from gui.battle_results.reusable import _ReusableInfo
    from typing import Dict
_logger = logging.getLogger(__name__)
BattleResult = namedtuple('BattleResult', ('results', 'reusable'))

def _showMessage():
    SystemMessages.pushI18nMessage('#system_messages:queue/isInQueue', type=SystemMessages.SM_TYPE.Error, priority='high')


class _LobbyInitSolver(object):
    _AWAIT_TIME = 10.0
    _uiLoader = dependency.descriptor(IGuiLoader)

    def __init__(self):
        super(_LobbyInitSolver, self).__init__()
        self.__bwCbId = None
        self.__callback = None
        return

    @sf_lobby
    def app(self):
        pass

    @adisp.adisp_async
    def canPBSbeShown(self, callback):
        lobbyContentID = R.views.cosmic_event.lobby.cosmic_lobby_view.CosmicLobbyView()
        if self.__bwCbId is not None:
            _logger.info('In process. Already waiting for Lobby view.')
            return
        else:
            lobbyView = self._uiLoader.windowsManager.getViewByLayoutID(lobbyContentID)
            if lobbyView:
                if lobbyView.viewStatus != ViewStatus.LOADED:
                    _logger.debug('Waiting until Lobby view is initialized.')
                    self.__callback = callback
                    lobbyView.onStatusChanged += self.__onLobbyViewCreated
                    self.__bwCbId = BigWorld.callback(self._AWAIT_TIME, self.__onTimeout)
                    return
            else:
                _logger.debug('Waiting until Lobby is created.')
                self.app.loaderManager.onViewLoaded += self.__onViewLoaded
                self.__callback = callback
                self.__bwCbId = BigWorld.callback(self._AWAIT_TIME, self.__onTimeout)
                return
            callback(True)
            return

    def clear(self):
        if self.__bwCbId is not None:
            lobbyContentID = R.views.cosmic_event.lobby.cosmic_lobby_view.CosmicLobbyView()
            lobbyView = self._uiLoader.windowsManager.getViewByLayoutID(lobbyContentID)
            if lobbyView:
                lobbyView.onStatusChanged -= self.__onLobbyViewCreated
            self.app.loaderManager.onViewLoaded -= self.__onViewLoaded
            BigWorld.cancelCallback(self.__bwCbId)
            self.__bwCbId = None
        self.__callback = None
        return

    def __onTimeout(self):
        cb = self.__callback
        _logger.warning('Timeout! Postbattle screen will not be invoked, Lobby view is not created!')
        self.clear()
        cb(False)

    def __onViewLoaded(self, pyView, *_, **__):
        if pyView.alias == R.views.cosmic_event.lobby.cosmic_lobby_view.CosmicLobbyView():
            cb = self.__callback
            self.clear()
            cb(True)

    def __onLobbyViewCreated(self, *_, **__):
        cb = self.__callback
        self.clear()
        cb(True)


class CosmicEventBattleStatsComposer(StatsComposer):
    _lobbySolver = _LobbyInitSolver()

    def __init__(self, reusable):
        super(CosmicEventBattleStatsComposer, self).__init__(reusable, templates.REGULAR_COMMON_STATS_BLOCK.clone(), templates.REGULAR_PERSONAL_STATS_BLOCK.clone(), templates.REGULAR_TEAMS_STATS_BLOCK.clone(), templates.REGULAR_TEXT_STATS_BLOCK.clone())
        self._block.addNextComponent(templates.PROGRESSIVE_REWARD_VO.clone())
        self.battleResults = None
        return

    def getVO(self):
        return self.battleResults

    def setResults(self, results, reusable):
        self.battleResults = BattleResult(results=results, reusable=reusable)

    def clear(self):
        super(CosmicEventBattleStatsComposer, self).clear()
        self._lobbySolver.clear()

    @staticmethod
    def onShowResults(arenaUniqueID, requestSource=REQUEST_SOURCE.OTHER):
        return

    @staticmethod
    @adisp.adisp_process
    def onResultsPosted(arenaUniqueID, requestSource=REQUEST_SOURCE.OTHER):
        if CosmicEventBattleStatsComposer._canNavigate():
            g_eventBus.handleEvent(CosmicBattleResultEvent(CosmicBattleResultEvent.POST_BATTLE_SCREEN_OPENING, ctx={}), scope=EVENT_BUS_SCOPE.LOBBY)
            if requestSource == REQUEST_SOURCE.NOTIFICATION:
                showCosmicResultsView(arenaUniqueID, requestSource)
                return
            result = yield CosmicEventBattleStatsComposer._lobbySolver.canPBSbeShown()
            if result:
                showCosmicResultsView(arenaUniqueID, requestSource)

    @staticmethod
    def _canNavigate():
        from gui.prb_control.dispatcher import g_prbLoader
        prbDispatcher = g_prbLoader.getDispatcher()
        if prbDispatcher is not None and prbDispatcher.getFunctionalState().isNavigationDisabled():
            BigWorld.callback(0.0, _showMessage)
            return False
        else:
            return True


@dependency.replace_none_kwargs(uiLoader=IGuiLoader)
def showCosmicResultsView(arenaUniqueID, requestSource, uiLoader=None):
    from cosmic_event.gui.impl.lobby.cosmic_post_battle_view.cosmic_post_battle_view import CosmicPostBattleView
    contentID = R.views.cosmic_event.lobby.cosmic_post_battle.CosmicPostBattleView()
    currentView = uiLoader.windowsManager.getViewByLayoutID(contentID)
    if currentView:
        currentView.destroy()
    g_eventBus.handleEvent(events.LoadGuiImplViewEvent(GuiImplViewLoadParams(layoutID=contentID, viewClass=CosmicPostBattleView, scope=ScopeTemplates.LOBBY_SUB_SCOPE), ctx={'arenaUniqueID': arenaUniqueID, 'requestSource': requestSource}), scope=EVENT_BUS_SCOPE.LOBBY)