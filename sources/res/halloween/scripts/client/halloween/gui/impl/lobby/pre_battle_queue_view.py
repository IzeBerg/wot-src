from gui.Scaleform.daapi.settings.views import VIEW_ALIAS
from gui.Scaleform.framework.managers.containers import POP_UP_CRITERIA
from gui.Scaleform.framework.managers.loaders import SFViewLoadParams
from gui.app_loader import sf_lobby
from halloween.gui.halloween_gui_constants import QUEUE_TYPE_TO_DIFFICULTY_LEVEL
from halloween.gui.impl.lobby import updateHeaderMenu
from halloween.gui.prb_control.entities.squad.entity import HalloweenSquadEntity
from halloween_common.halloween_constants import CURRENT_QUEUE_TYPE_KEY
from helpers import dependency
from gui.impl.gen import R
from frameworks.wulf import ViewFlags, ViewSettings, WindowLayer
from gui.prb_control import prbEntityProperty
from gui.impl.pub.selectable_view_impl import SelectableViewImpl, notifyCursorOver3DScene
from gui.Scaleform.daapi.view.lobby.header.LobbyHeader import HeaderMenuVisibilityState
from gui.shared import g_eventBus, events, EVENT_BUS_SCOPE
from halloween.gui.impl.gen.view_models.views.lobby.pre_battle_queue_view_model import PreBattleQueueViewModel
from halloween.skeletons.difficulty_level_controller import IDifficultyLevelController
from skeletons.gui.app_loader import IAppLoader
_BACKGROUND_ALPHA = 0.0

class PreBattleQueueView(SelectableViewImpl):
    _difficultyLevelCtrl = dependency.descriptor(IDifficultyLevelController)
    _appLoader = dependency.descriptor(IAppLoader)

    def __init__(self, layoutID=R.views.halloween.lobby.PreBattleQueueView()):
        settings = ViewSettings(layoutID)
        settings.flags = ViewFlags.LOBBY_SUB_VIEW
        settings.model = PreBattleQueueViewModel()
        super(PreBattleQueueView, self).__init__(settings)
        self._headerMenuVisibilityRestore = False

    @prbEntityProperty
    def prbEntity(self):
        return

    @property
    def viewModel(self):
        return super(PreBattleQueueView, self).getViewModel()

    def _onLoading(self, *args, **kwargs):
        super(PreBattleQueueView, self)._onLoading(*args, **kwargs)
        self._loadModel()
        app = self._appLoader.getApp()
        app.setBackgroundAlpha(_BACKGROUND_ALPHA)

    def _onLoaded(self, *args, **kwargs):
        super(PreBattleQueueView, self)._onLoaded(*args, **kwargs)
        updateHeaderMenu(HeaderMenuVisibilityState.NOTHING)
        self._headerMenuVisibilityRestore = True
        notifyCursorOver3DScene(False)

    def _finalize(self):
        if self._headerMenuVisibilityRestore:
            updateHeaderMenu(HeaderMenuVisibilityState.ALL)
        self._headerMenuVisibilityRestore = False
        super(PreBattleQueueView, self)._finalize()

    def _loadModel(self):
        with self.getViewModel().transaction() as (model):
            model.setSelectedDifficultyLevel(self.__getSelectedDifficultyLevel())
            permissions = self.prbEntity.getPermissions()
            model.setIsExitButtonAvailable(permissions.canExitFromQueue())

    def _getEvents(self):
        return [
         (
          self.viewModel.onExitBattle, self.__onExitBattleButtonClick),
         (
          self.viewModel.onEscape, self.__onEscape)]

    def __onExitBattleButtonClick(self):
        self.prbEntity.exitFromQueue()

    @sf_lobby
    def __app(self):
        return

    def __onEscape(self):
        dialogsContainer = self.__app.containerManager.getContainer(WindowLayer.TOP_WINDOW)
        if not dialogsContainer.getView(criteria={POP_UP_CRITERIA.VIEW_ALIAS: VIEW_ALIAS.LOBBY_MENU}):
            g_eventBus.handleEvent(events.LoadViewEvent(SFViewLoadParams(VIEW_ALIAS.LOBBY_MENU)), scope=EVENT_BUS_SCOPE.LOBBY)

    def __getSelectedDifficultyLevel(self):
        if isinstance(self.prbEntity, HalloweenSquadEntity):
            _, unit = self.prbEntity.getUnit()
            if unit:
                queueType = unit._extras.get(CURRENT_QUEUE_TYPE_KEY)
                return QUEUE_TYPE_TO_DIFFICULTY_LEVEL[queueType].value
        return self._difficultyLevelCtrl.getSelectedLevel().value