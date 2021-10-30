from frameworks.wulf import ViewSettings
from gui.battle_pass.battle_pass_helpers import getNotChosen3DStylesCount
from gui.impl.gen import R
from gui.impl.gen.view_models.views.lobby.battle_pass.tooltips.battle_pass_completed_tooltip_view_model import BattlePassCompletedTooltipViewModel
from gui.impl.pub import ViewImpl
from helpers import dependency
from skeletons.gui.game_control import IBattlePassController

class BattlePassCompletedTooltipView(ViewImpl):
    __battlePassController = dependency.descriptor(IBattlePassController)
    __slots__ = ()

    def __init__(self):
        settings = ViewSettings(R.views.lobby.battle_pass.tooltips.BattlePassCompletedTooltipView())
        settings.model = BattlePassCompletedTooltipViewModel()
        super(BattlePassCompletedTooltipView, self).__init__(settings)

    @property
    def viewModel(self):
        return super(BattlePassCompletedTooltipView, self).getViewModel()

    def _onLoading(self, *args, **kwargs):
        super(BattlePassCompletedTooltipView, self)._onLoading(*args, **kwargs)
        with self.getViewModel().transaction() as (model):
            model.setLevel(self.__battlePassController.getMaxLevel())
            model.setIsBattlePassPurchased(self.__battlePassController.isBought())
            model.setIsStyleChosen(not bool(getNotChosen3DStylesCount(battlePass=self.__battlePassController)))
            model.setNotChosenRewardCount(self.__battlePassController.getNotChosenRewardCount())