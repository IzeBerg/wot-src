from frameworks.wulf import ViewSettings, ViewFlags
from gui.impl.gen import R
from gui.impl.pub import ViewImpl
from gui.prb_control import prbEntityProperty
from gui.prb_control.entities.listener import IGlobalListener
from halloween.gui.halloween_gui_constants import DifficultyLevel
from halloween.gui.impl.gen.view_models.views.lobby.widgets.difficulty_item_model import DifficultyItemModel, StateEnum
from halloween.gui.impl.gen.view_models.views.lobby.widgets.difficulty_view_model import DifficultyViewModel
from halloween.gui.impl.lobby.tooltips.difficulty_tooltip import DifficultyTooltipView
from halloween.gui.prb_control.entities.squad.entity import HalloweenSquadEntity
from halloween.skeletons.difficulty_level_controller import IDifficultyLevelController
from helpers import dependency

class DifficultyView(ViewImpl, IGlobalListener):
    _difficultyCtrl = dependency.descriptor(IDifficultyLevelController)

    def __init__(self, layoutID=R.views.halloween.lobby.widgets.DifficultyView()):
        settings = ViewSettings(layoutID)
        settings.flags = ViewFlags.LOBBY_SUB_VIEW
        settings.model = DifficultyViewModel()
        super(DifficultyView, self).__init__(settings)

    def createToolTipContent(self, event, contentID):
        if contentID == R.views.halloween.lobby.tooltips.DifficultyTooltip():
            level = int(event.getArgument('level'))
            state = StateEnum(event.getArgument('state'))
            return DifficultyTooltipView(level=level, state=state)
        return super(DifficultyView, self).createToolTipContent(event, contentID)

    @property
    def viewModel(self):
        return super(DifficultyView, self).getViewModel()

    @prbEntityProperty
    def prbEntity(self):
        return

    def onPrbEntitySwitched(self):
        super(DifficultyView, self).onPrbEntitySwitched()
        self.__onUpdateDifficultyLevelsViewState()

    def _onLoading(self, *args, **kwargs):
        super(DifficultyView, self)._onLoading()
        self.__fillViewModel()
        self.__onUpdateDifficultyLevelsViewState()

    def _subscribe(self):
        super(DifficultyView, self)._subscribe()
        self.viewModel.onSwichLevel += self.__onSwitchLevel
        self._difficultyCtrl.onChangeDifficultyLevel += self.__selectLevel
        self._difficultyCtrl.onChangeDifficultyLevelStatus += self.__updateLevelStatus
        self.startGlobalListening()

    def _unsubscribe(self):
        self.viewModel.onSwichLevel -= self.__onSwitchLevel
        self._difficultyCtrl.onChangeDifficultyLevel -= self.__selectLevel
        self._difficultyCtrl.onChangeDifficultyLevelStatus -= self.__updateLevelStatus
        self.stopGlobalListening()
        super(DifficultyView, self)._unsubscribe()

    def onUnitPlayerRolesChanged(self, pInfo, pPermissions):
        self.__onUpdateDifficultyLevelsViewState()

    def onUnitPlayerAdded(self, pInfo):
        self.__onUpdateDifficultyLevelsViewState()

    def onUnitPlayerRemoved(self, pInfo):
        self.__onUpdateDifficultyLevelsViewState()

    def __fillViewModel(self):
        with self.viewModel.transaction() as (model):
            difficulties = model.getDifficulties()
            for level in self._difficultyCtrl.getLevelsInfo():
                levelModel = DifficultyItemModel()
                levelModel.setLevel(level.level.value)
                if level.level == self._difficultyCtrl.getSelectedLevel() and level.isUnlock:
                    levelModel.setState(StateEnum.SELECTED)
                else:
                    levelModel.setState(StateEnum.DEFAULT if level.isUnlock else StateEnum.LOCKED)
                difficulties.addViewModel(levelModel)

            difficulties.invalidate()

    def __selectLevel(self, level):
        with self.viewModel.transaction() as (model):
            levels = model.getDifficulties()
            for item in levels:
                if level.value == item.getLevel():
                    item.setState(StateEnum.SELECTED)
                else:
                    item.setState(StateEnum.DEFAULT if item.getState() != StateEnum.LOCKED else StateEnum.LOCKED)

            levels.invalidate()

    def __updateLevelStatus(self, level):
        with self.viewModel.transaction() as (model):
            levels = model.getDifficulties()
            for item in levels:
                if level.level.value != item.getLevel():
                    continue
                item.setState(StateEnum.DEFAULT if level.isUnlock else StateEnum.LOCKED)

            levels.invalidate()

    def __onUpdateDifficultyLevelsViewState(self, *args, **kwargs):
        with self.viewModel.transaction() as (model):
            isDisabled = isinstance(self.prbEntity, HalloweenSquadEntity) and not self.prbEntity.isCommander()
            model.setIsDisabled(isDisabled)

    def __onSwitchLevel(self, args):
        selectedID = int(args.get('level', 1))
        self._difficultyCtrl.selectLevel(DifficultyLevel(selectedID))