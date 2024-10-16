import logging
from frameworks.wulf import ViewSettings, WindowFlags, WindowLayer, ViewModel
from gui.app_loader.settings import APP_NAME_SPACE
from gui.impl.gen import R
from gui.impl.pub import ViewImpl, WindowImpl
from helpers import dependency
from skeletons.gui.app_loader import IAppLoader
from skeletons.gui.battle_session import IBattleSessionProvider
from halloween_common.halloween_constants import ARENA_BONUS_TYPE
_logger = logging.getLogger(__name__)

class HelpView(ViewImpl):
    _appLoader = dependency.descriptor(IAppLoader)
    _sessionProvider = dependency.descriptor(IBattleSessionProvider)

    def __init__(self):
        settings = ViewSettings(layoutID=self.getLayoutId(), model=ViewModel())
        super(HelpView, self).__init__(settings)

    @classmethod
    def getLayoutId(cls):
        if cls._sessionProvider.arenaVisitor.getArenaBonusType() == ARENA_BONUS_TYPE.HALLOWEEN_DEFENCE:
            return R.views.halloween.battle.HelpViewDefence()
        return R.views.halloween.battle.HelpView()

    @property
    def _battleApp(self):
        return self._appLoader.getApp(APP_NAME_SPACE.SF_BATTLE)

    def _initialize(self):
        super(HelpView, self)._initialize()
        self._battleApp.enterGuiControlMode(self.getLayoutId(), cursorVisible=True, enableAiming=False)

    def _finalize(self):
        self._battleApp.leaveGuiControlMode(self.getLayoutId())
        super(HelpView, self)._finalize()


class HelpWindow(WindowImpl):
    __slots__ = ()

    def __init__(self, parent=None):
        super(HelpWindow, self).__init__(wndFlags=WindowFlags.WINDOW_FULLSCREEN | WindowFlags.WINDOW | WindowFlags.WINDOW_MODALITY_MASK, content=HelpView(), layer=WindowLayer.OVERLAY, parent=parent)