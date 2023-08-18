import typing
from functools import partial
import adisp, BigWorld
from account_helpers.AccountSettings import AccountSettings, HAS_LEFT_VERSUS_AI
from constants import QUEUE_TYPE, PREBATTLE_TYPE, Configs
from gui.prb_control.dispatcher import g_prbLoader
from gui.prb_control.entities.base.ctx import PrbAction
from gui.prb_control.entities.listener import IGlobalListener
from gui.prb_control.settings import PREBATTLE_ACTION_NAME
from helpers import dependency, server_settings
from PlayerEvents import g_playerEvents
from skeletons.gui.lobby_context import ILobbyContext
from skeletons.gui.shared import IItemsCache
from versus_ai.skeletons.versus_ai_controller import IVersusAIController
from versus_ai.gui.versus_ai_gui_constants import NOOB_MIN_BATTLES_COUNT, NOOB_VEHICLE_LEVELS
if typing.TYPE_CHECKING:
    from helpers.server_settings import VersusAIConfig

class VersusAIController(IVersusAIController, IGlobalListener):
    __lobbyContext = dependency.descriptor(ILobbyContext)
    __itemsCache = dependency.descriptor(IItemsCache)

    def __init__(self):
        super(VersusAIController, self).__init__()
        self.__callbackID = None
        return

    def init(self):
        super(VersusAIController, self).init()
        g_playerEvents.onDossiersResync += self.__switchModeForNoob

    def fini(self):
        if self.__callbackID is not None:
            BigWorld.cancelCallback(self.__callbackID)
            self.__callbackID = None
        self.__lobbyContext.getServerSettings().onServerSettingsChange -= self.__onServerSettingsChanged
        g_playerEvents.onDossiersResync -= self.__switchModeForNoob
        super(VersusAIController, self).fini()
        return

    def onLobbyInited(self, _):
        self.startGlobalListening()
        self.__lobbyContext.getServerSettings().onServerSettingsChange += self.__onServerSettingsChanged
        self.__updateMode()

    def onAccountBecomeNonPlayer(self):
        super(VersusAIController, self).onAccountBecomeNonPlayer()
        self.stopGlobalListening()
        self.__lobbyContext.getServerSettings().onServerSettingsChange -= self.__onServerSettingsChanged

    def onPrbEntitySwitched(self):
        if not self.__isVersusAIMode():
            if not AccountSettings.getSettings(HAS_LEFT_VERSUS_AI):
                AccountSettings.setSettings(HAS_LEFT_VERSUS_AI, True)

    def isEnabled(self):
        return self.getConfig().isEnabled

    def getConfig(self):
        return self.__lobbyContext.getServerSettings().versusAIConfig

    def shouldBeDefaultMode(self):
        battlesCount = self.__itemsCache.items.getAccountDossier().getTotalStats().getBattlesCount()
        return self.isEnabled() and battlesCount < NOOB_MIN_BATTLES_COUNT and not AccountSettings.getSettings(HAS_LEFT_VERSUS_AI) and self.__hasLowLevelsInConfig()

    def __shouldSwitchModeForNoob(self):
        if AccountSettings.getSettings(HAS_LEFT_VERSUS_AI) or not self.__hasLowLevelsInConfig() or not self.isEnabled():
            return False
        battlesCount = self.__itemsCache.items.getAccountDossier().getTotalStats().getBattlesCount()
        return battlesCount >= NOOB_MIN_BATTLES_COUNT

    def __hasLowLevelsInConfig(self):
        configLevels = self.getConfig().levels
        return any(lvl in configLevels for lvl in NOOB_VEHICLE_LEVELS)

    def __selectRandomBattle(self):
        dispatcher = g_prbLoader.getDispatcher()
        if dispatcher is None:
            return
        else:
            self.__callbackID = BigWorld.callback(0, partial(self.__doSelectRandomPrb, dispatcher))
            return

    def __switchModeForNoob(self):
        if self.__shouldSwitchModeForNoob():
            self.__selectRandomBattle()

    @adisp.adisp_process
    def __doSelectRandomPrb(self, dispatcher):
        self.__callbackID = None
        yield dispatcher.doSelectAction(PrbAction(PREBATTLE_ACTION_NAME.RANDOM))
        return

    def __isVersusAIMode(self):
        if self.prbDispatcher is None:
            return False
        else:
            state = self.prbDispatcher.getFunctionalState()
            return state.isInPreQueue(queueType=QUEUE_TYPE.VERSUS_AI) or state.isInUnit(PREBATTLE_TYPE.VERSUS_AI)

    @server_settings.serverSettingsChangeListener(Configs.VERSUS_AI_CONFIG.value)
    def __onServerSettingsChanged(self, _):
        self.__updateMode()

    def __updateMode(self):
        if self.__isVersusAIMode():
            if not self.isEnabled() or self.__shouldSwitchModeForNoob():
                self.__selectRandomBattle()