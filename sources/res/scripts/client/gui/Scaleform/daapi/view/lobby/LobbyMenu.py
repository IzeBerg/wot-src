import BigWorld, constants
from PlayerEvents import g_playerEvents as events
from account_helpers import AccountSettings
from account_helpers.counter_settings import getCountNewSettings
from adisp import process
from async import async, await
from gui import DialogsInterface
from gui.Scaleform.daapi.view.dialogs import DIALOG_BUTTON_ID
from gui.Scaleform.daapi.view.meta.LobbyMenuMeta import LobbyMenuMeta
from gui.Scaleform.genConsts.MENU_CONSTANTS import MENU_CONSTANTS
from gui.Scaleform.locale.BOOTCAMP import BOOTCAMP
from gui.Scaleform.locale.MENU import MENU
from gui.Scaleform.locale.RES_ICONS import RES_ICONS
from gui.impl.dialogs import dialogs
from gui.impl.lobby.account_completion.curtain.curtain_view import CurtainWindow
from gui.prb_control import prbEntityProperty
from gui.shared import event_dispatcher
from gui.shared.formatters import text_styles, icons
from gui.shared.tutorial_helper import getTutorialGlobalStorage
from gui.sounds.ambients import LobbySubViewEnv
from helpers import i18n, getShortClientVersion, dependency
from skeletons.gameplay import IGameplayLogic
from skeletons.gui.game_control import IBootcampController, IDemoAccCompletionController
from skeletons.gui.game_control import IManualController
from skeletons.gui.game_control import IPromoController
from skeletons.gui.impl import IGuiLoader
from skeletons.gui.lobby_context import ILobbyContext
from tutorial.control.context import GLOBAL_FLAG
from uilogging.account_completion.constants import LogActions
from uilogging.account_completion.loggers import AccountCompletionMenuLogger
from uilogging.manual.constants import ManualLogActions, ManualLogKeys
from uilogging.manual.loggers import ManualLogger

def _getVersionMessage():
    return (
     ('{0} {1}').format(text_styles.main(i18n.makeString(MENU.PROMO_PATCH_MESSAGE)), text_styles.stats(getShortClientVersion())),)


class LobbyMenu(LobbyMenuMeta):
    __sound_env__ = LobbySubViewEnv
    manualUILogger = ManualLogger(ManualLogKeys.LOBBY_MENU_BUTTON.value)
    promo = dependency.descriptor(IPromoController)
    bootcamp = dependency.descriptor(IBootcampController)
    lobbyContext = dependency.descriptor(ILobbyContext)
    gameplay = dependency.descriptor(IGameplayLogic)
    manualController = dependency.descriptor(IManualController)
    gui = dependency.descriptor(IGuiLoader)
    demoAccController = dependency.descriptor(IDemoAccCompletionController)
    _accountCompletionUILogger = AccountCompletionMenuLogger()

    @prbEntityProperty
    def prbEntity(self):
        pass

    def postClick(self):
        self.destroy()
        self.promo.showFieldPost()

    def settingsClick(self):
        self._accountCompletionUILogger.log(LogActions.SETTINGS_CLICKED)
        event_dispatcher.showSettingsWindow(redefinedKeyMode=False)

    def onWindowClose(self):
        self.destroy()

    def cancelClick(self):
        self._accountCompletionUILogger.log(LogActions.CONTINUE_CLICKED)
        self.destroy()

    def onEscapePress(self):
        self._accountCompletionUILogger.log(LogActions.ESCAPE_PRESSED)
        self.destroy()

    @process
    def refuseTraining(self):
        isOk = yield DialogsInterface.showI18nConfirmDialog('refuseTraining')
        if isOk:
            event_dispatcher.stopTutorial()
        self.destroy()

    @process
    def logoffClick(self):
        isOk = yield DialogsInterface.showI18nConfirmDialog('disconnect', focusedID=DIALOG_BUTTON_ID.CLOSE)
        if isOk:
            self.gameplay.goToLoginByDisconnectRQ()

    @async
    def quitClick(self):
        isOk = yield await(dialogs.quitGame(self.getParentWindow()))
        if isOk:
            self._accountCompletionUILogger.log(LogActions.QUIT_CLICKED)
            self.gameplay.quitFromGame()

    def onCounterNeedUpdate(self):
        self.__updateNewSettingsCount()

    def bootcampClick(self):
        self.bootcamp.runBootcamp()

    def manualClick(self):
        if self.manualController.isActivated():
            view = self.manualController.getView()
            if view is not None:
                self.destroy()
            else:
                self.manualUILogger.log(ManualLogActions.CLICK.value, with_trigger=not AccountSettings.isLobbyMenuTriggerShown())
                self.manualController.show()
        return

    def _populate(self):
        super(LobbyMenu, self)._populate()
        self.__addListeners()
        isDemoAccountWithOpenedCurtain = self.demoAccController.isDemoAccount and CurtainWindow.isOpened()
        state = MENU_CONSTANTS.STATE_SHOW_ALL
        if self.bootcamp.isInBootcamp() or isDemoAccountWithOpenedCurtain:
            state = MENU_CONSTANTS.STATE_HIDE_ALL
        elif constants.IS_CHINA:
            state = MENU_CONSTANTS.STATE_SHOW_SERVER_NAME
        elif not constants.IS_SHOW_SERVER_STATS:
            state = MENU_CONSTANTS.STATE_HIDE_SERVER_STATS_ITEM
        self.as_setMenuStateS(state)
        self.as_setVersionMessageS(('{0} {1}').format(text_styles.main(i18n.makeString(MENU.PROMO_PATCH_MESSAGE)), text_styles.stats(getShortClientVersion())))
        postIconClose = icons.makeImageTag(RES_ICONS.MAPS_ICONS_LIBRARY_POST_CLOSE, 26, 22, -5, 0)
        postIconOpen = icons.makeImageTag(RES_ICONS.MAPS_ICONS_LIBRARY_POST_OPEN, 26, 22, -5, 0)
        self.as_setPostButtonIconsS(postIconClose, postIconOpen)
        bootcampIcon = RES_ICONS.MAPS_ICONS_BOOTCAMP_MENU_MENUBOOTCAMPICON
        bootcampIconSource = icons.makeImageTag(bootcampIcon, 33, 27, -8, 0)
        if self.bootcamp.isInBootcamp():
            self.as_setBootcampButtonLabelS(BOOTCAMP.REQUEST_BOOTCAMP_FINISH, bootcampIconSource)
        elif self.lobbyContext.getServerSettings().isBootcampEnabled():
            if self.bootcamp.runCount() > 0:
                bootcampLabel = BOOTCAMP.REQUEST_BOOTCAMP_RETURN
            else:
                bootcampLabel = BOOTCAMP.REQUEST_BOOTCAMP_START
            self.as_setBootcampButtonLabelS(bootcampLabel, bootcampIconSource)
        else:
            self.as_showBootcampButtonS(False)
        isBootCampDisabled = BigWorld.player().spaFlags.getFlag(constants.SPA_ATTRS.BOOTCAMP_DISABLED)
        if isBootCampDisabled:
            self.as_showBootcampButtonS(False)
        if events.isPlayerEntityChanging:
            self.as_showBootcampButtonS(False)
        if not self.manualController.isActivated() or self.bootcamp.isInBootcamp() or self.__isInQueue():
            self.as_showManualButtonS(False)
        self.__setPostFieldButtonVisible(self.promo.isActive())
        if self.manualController.isActivated():
            self.as_setManualButtonIconS(icons.makeImageTag(RES_ICONS.MAPS_ICONS_LIBRARY_INFO, 24, 24, -6, 0))
            isShowLobbyMenuTrigger = not AccountSettings.isLobbyMenuTriggerShown() and not self.bootcamp.isInBootcamp()
            getTutorialGlobalStorage().setValue(GLOBAL_FLAG.LOBBY_MENU_ITEM_MANUAL, isShowLobbyMenuTrigger)
            getTutorialGlobalStorage().setValue(GLOBAL_FLAG.LOBBY_MENU_ITEM_BOOTCAMP, isShowLobbyMenuTrigger and not self.bootcamp.hasFinishedBootcampBefore())
        if isDemoAccountWithOpenedCurtain:
            self.as_showManualButtonS(False)
            self.as_showBootcampButtonS(False)
            self.as_setPostButtonVisibleS(False)

    def _dispose(self):
        if not self.bootcamp.isInBootcamp():
            AccountSettings.setLobbyMenuTriggerShown()
        self.__removeListeners()
        super(LobbyMenu, self)._dispose()

    def __isInQueue(self):
        return self.prbEntity and self.prbEntity.isInQueue()

    def __updateNewSettingsCount(self):
        userLogin = getattr(BigWorld.player(), 'name', '')
        if userLogin == '':
            return
        toShow, toHide = [], []
        counts = {'settingsBtn': getCountNewSettings(), 
           'postBtn': self.promo.getPromoCount()}
        if not self.bootcamp.isInBootcamp():
            counts['manualBtn'] = self.manualController.getNewContentCount()
        for componentID, count in counts.iteritems():
            if count > 0:
                toShow.append({'componentId': componentID, 'count': str(count)})
            else:
                toHide.append(componentID)

        if toShow:
            self.as_setCounterS(toShow)
        if toHide:
            self.as_removeCounterS(toHide)

    def __addListeners(self):
        self.lobbyContext.getServerSettings().onServerSettingsChange += self.__onServerSettingChanged
        self.promo.onPromoCountChanged += self.__updateNewSettingsCount

    def __removeListeners(self):
        self.promo.onPromoCountChanged -= self.__updateNewSettingsCount
        self.lobbyContext.getServerSettings().onServerSettingsChange -= self.__onServerSettingChanged

    def __onServerSettingChanged(self, diff):
        if 'isManualEnabled' in diff:
            manualButtonEnabled = diff['isManualEnabled']
            self.as_showManualButtonS(manualButtonEnabled)
        if 'isFieldPostEnabled' in diff:
            self.__setPostFieldButtonVisible(diff['isFieldPostEnabled'])

    def __setPostFieldButtonVisible(self, isVisible):
        self.as_setPostButtonVisibleS(isVisible and not self.__isInQueue())