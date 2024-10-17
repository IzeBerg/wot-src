import logging
from frameworks.wulf import ViewSettings, WindowFlags, WindowLayer
from gui.battle_control.arena_info.interfaces import IArenaLoadController
from gui.impl.wrappers.function_helpers import replaceNoneKwargsModel
from halloween.gui.impl.gen.view_models.views.battle.event_loading_view_model import EventLoadingViewModel
from halloween_common.halloween_constants import ARENA_BONUS_TYPE
from helpers import dependency
from gui.impl.pub import ViewImpl, WindowImpl
from gui.impl.gen import R
from skeletons.gui.battle_session import IBattleSessionProvider
_logger = logging.getLogger(__name__)

class HalloweenBattleLoadingView(ViewImpl, IArenaLoadController):
    sessionProvider = dependency.descriptor(IBattleSessionProvider)

    def __init__(self, layoutID):
        settings = ViewSettings(layoutID=layoutID, model=EventLoadingViewModel())
        super(HalloweenBattleLoadingView, self).__init__(settings)

    def updateSpaceLoadProgress(self, progress):
        self.__updateProgress(progress)

    def _subscribe(self):
        super(HalloweenBattleLoadingView, self)._subscribe()
        self.sessionProvider.addArenaCtrl(self)

    def _unsubscribe(self):
        super(HalloweenBattleLoadingView, self)._unsubscribe()
        self.sessionProvider.removeArenaCtrl(self)

    def _onLoading(self, *args, **kwargs):
        super(HalloweenBattleLoadingView, self)._onLoading(*args, **kwargs)
        self.__updateProgress(0)

    @replaceNoneKwargsModel
    def __updateProgress(self, progress, model=None):
        model.setCurrentProgress(int(progress * 100))


class HalloweenBattleLoadingWindow(WindowImpl):
    __slots__ = ()
    sessionProvider = dependency.descriptor(IBattleSessionProvider)

    def __init__(self, parent=None):
        super(HalloweenBattleLoadingWindow, self).__init__(wndFlags=WindowFlags.WINDOW_FULLSCREEN | WindowFlags.WINDOW, content=HalloweenBattleLoadingView(self.getLayout()), layer=WindowLayer.OVERLAY, parent=parent)

    @classmethod
    def getLayout(cls):
        if cls.sessionProvider.arenaVisitor.getArenaBonusType() == ARENA_BONUS_TYPE.HALLOWEEN_DEFENCE:
            return R.views.halloween.battle.EventBattleLoadingDefence()
        return R.views.halloween.battle.EventBattleLoading()