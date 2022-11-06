from helpers import dependency
from skeletons.gui.app_loader import IAppLoader
from gui.Scaleform.daapi.view.bootcamp.BCVideoPage import BCVideoPage
from uilogging.deprecated.bootcamp.constants import BC_LOG_KEYS, BC_LOG_ACTIONS
from uilogging.deprecated.bootcamp.loggers import BootcampLogger

class BCInterludeVideoPage(BCVideoPage):
    appLoader = dependency.descriptor(IAppLoader)
    uiBootcampLogger = BootcampLogger(BC_LOG_KEYS.BC_INTERLUDE_VIDEO)

    def __init__(self, settings):
        super(BCInterludeVideoPage, self).__init__(settings)
        self._content = settings

    @property
    def content(self):
        return self._content

    def _populate(self):
        self.uiBootcampLogger.startAction(BC_LOG_ACTIONS.VIDEO_FINISHED)
        super(BCInterludeVideoPage, self)._populate()
        self.appLoader.onGUISpaceLeft += self._onGUISpaceLeft

    def _dispose(self):
        self.appLoader.onGUISpaceLeft -= self._onGUISpaceLeft
        super(BCInterludeVideoPage, self)._dispose()

    def _onFinish(self):
        if self.content.get('exitEvent', False):
            self.content['exitEvent']()
        super(BCInterludeVideoPage, self)._onFinish()

    def _onGUISpaceLeft(self, _):
        super(BCInterludeVideoPage, self)._onFinish()

    def videoFinished(self, skipped=False):
        self.uiBootcampLogger.stopAction(BC_LOG_ACTIONS.VIDEO_FINISHED, skipped=skipped)
        super(BCInterludeVideoPage, self).videoFinished()