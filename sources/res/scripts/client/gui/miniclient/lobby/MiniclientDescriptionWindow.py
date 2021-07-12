from gui import GUI_SETTINGS
from gui.shared import g_eventBus, events
from helpers import dependency
from helpers.i18n import makeString as _ms
from skeletons.gui.game_control import IBrowserController, IBootcampController

class MiniclientDescriptionWindow(object):
    browserCtrl = dependency.descriptor(IBrowserController)
    bootcampCtrl = dependency.descriptor(IBootcampController)

    def __init__(self):
        g_eventBus.addListener(events.GUICommonEvent.LOBBY_VIEW_LOADED, self.__openDescriptionInBrowser)

    def __openDescriptionInBrowser(self, event):
        if not self.bootcampCtrl.isInBootcamp():
            self.browserCtrl.load(url=('{0}/$LANGUAGE_CODE/greeting/mini_wot/').format(GUI_SETTINGS.miniclient['webBridgeRootURL']), title=_ms('#miniclient:hangar/miniclient_description_window/title'), browserSize=(780,
                                                                                                                                                                                                                       450), showCloseBtn=True, showActionBtn=False, isAsync=True, showWaiting=False)(lambda success: True)
            g_eventBus.removeListener(events.GUICommonEvent.LOBBY_VIEW_LOADED, self.__openDescriptionInBrowser)