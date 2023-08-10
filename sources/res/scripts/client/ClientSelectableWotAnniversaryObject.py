from ClientSelectableObject import ClientSelectableObject
from gui.wot_anniversary.wot_anniversary_helpers import showMainView, showWotAnniversaryIntroWindow, isAnniversaryIntroShowed
from helpers import dependency
from skeletons.account_helpers.settings_core import ISettingsCore
from skeletons.gui.game_control import IWotAnniversaryController

class ClientSelectableWotAnniversaryObject(ClientSelectableObject):
    __wotAnniversaryCtrl = dependency.descriptor(IWotAnniversaryController)
    __settingsCore = dependency.descriptor(ISettingsCore)

    def onEnterWorld(self, prereqs):
        super(ClientSelectableWotAnniversaryObject, self).onEnterWorld(prereqs)
        self.__wotAnniversaryCtrl.onSettingsChanged += self.__onSettingsChanged
        self.__wotAnniversaryCtrl.onEventActivePhaseEnded += self.__onEventActivePhaseEnded
        self.__onSettingsChanged()

    def onLeaveWorld(self):
        self.__wotAnniversaryCtrl.onEventActivePhaseEnded -= self.__onEventActivePhaseEnded
        self.__wotAnniversaryCtrl.onSettingsChanged -= self.__onSettingsChanged
        super(ClientSelectableWotAnniversaryObject, self).onLeaveWorld()

    def onMouseClick(self):
        super(ClientSelectableWotAnniversaryObject, self).onMouseClick()
        if not isAnniversaryIntroShowed():
            showWotAnniversaryIntroWindow(closeCallback=showMainView)
            return
        showMainView()

    def __onSettingsChanged(self, *_):
        if self.__wotAnniversaryCtrl.isAvailableAndActivePhase():
            self.setEnable(True)
        else:
            self.setEnable(False)

    def __onEventActivePhaseEnded(self, *_):
        self.setEnable(False)