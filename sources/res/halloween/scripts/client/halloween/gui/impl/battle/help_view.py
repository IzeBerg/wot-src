import logging
from frameworks.wulf import ViewSettings, WindowFlags, WindowLayer, ViewModel
from gui.app_loader.settings import APP_NAME_SPACE
from gui.impl.gen import R
from gui.impl.pub import ViewImpl, WindowImpl
from helpers import dependency
from skeletons.gui.app_loader import IAppLoader
_logger = logging.getLogger(__name__)

class HelpView(ViewImpl):
    appLoader = dependency.descriptor(IAppLoader)

    def __init__(self, layoutID=R.views.halloween.battle.HelpView()):
        settings = ViewSettings(layoutID=layoutID, model=ViewModel())
        super(HelpView, self).__init__(settings)

    @property
    def _battleApp(self):
        return self.appLoader.getApp(APP_NAME_SPACE.SF_BATTLE)

    def _initialize(self):
        super(HelpView, self)._initialize()
        self._battleApp.enterGuiControlMode(R.views.halloween.battle.HelpView(), cursorVisible=True, enableAiming=False)

    def _finalize(self):
        self._battleApp.leaveGuiControlMode(R.views.halloween.battle.HelpView())
        super(HelpView, self)._finalize()


class HelpWindow(WindowImpl):
    __slots__ = ()

    def __init__(self, parent=None):
        super(HelpWindow, self).__init__(wndFlags=WindowFlags.WINDOW_FULLSCREEN | WindowFlags.WINDOW | WindowFlags.WINDOW_MODALITY_MASK, content=HelpView(), layer=WindowLayer.OVERLAY, parent=parent)