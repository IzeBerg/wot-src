from helpers import dependency
from gui.Scaleform.daapi.view.lobby.hangar.BrowserView import BrowserView
from skeletons.gui.game_control import IRTSBattlesController

class RTSLandingView(BrowserView):
    __rtsController = dependency.descriptor(IRTSBattlesController)

    def onEscapePress(self):
        self.onCloseBtnClick()

    def _populate(self):
        super(RTSLandingView, self)._populate()
        self._populateSoundEnv(self.__rtsController.getSoundManager())

    def _dispose(self):
        self._disposeSoundEnv(self.__rtsController.getSoundManager())
        super(RTSLandingView, self)._dispose()

    def _populateSoundEnv(self, soundManager):
        pass

    def _disposeSoundEnv(self, soundManager):
        pass


class RTSInfoPageView(RTSLandingView):

    def _populateSoundEnv(self, soundManager):
        super(RTSInfoPageView, self)._populateSoundEnv(soundManager)
        soundManager.onOpenPage()

    def _disposeSoundEnv(self, soundManager):
        soundManager.onClosePage()
        super(RTSInfoPageView, self)._disposeSoundEnv(soundManager)