from gui.impl.backport import BackportTooltipWindow, createTooltipData
from gui.impl.gen import R
from gui.impl.gen.view_models.views.lobby.common.reward_item_model import RewardItemModel
from gui.impl.pub import ViewImpl
from frameworks.wulf import ViewSettings
from gui.impl.gen.view_models.views.dialogs.sub_views.reward_list_view_model import RewardListViewModel
from ids_generators import SequenceIDGenerator

class RewardList(ViewImpl):

    def __init__(self, bonuses, layoutID=R.views.dialogs.sub_views.icon.RewardList()):
        settings = ViewSettings(layoutID)
        settings.model = RewardListViewModel()
        super(RewardList, self).__init__(settings)
        self.__bonuses = bonuses
        self.__bonusCache = {}
        self.__idGen = SequenceIDGenerator()

    def createToolTip(self, event):
        if event.contentID == R.views.common.tooltip_window.backport_tooltip_content.BackportTooltipContent():
            tooltipId = event.getArgument('tooltipId')
            bonus = self.__bonusCache.get(tooltipId)
            if bonus:
                window = BackportTooltipWindow(createTooltipData(tooltip=bonus.tooltip, isSpecial=bonus.isSpecial, specialAlias=bonus.specialAlias, specialArgs=bonus.specialArgs), self.getParentWindow())
                window.load()
                return window
        super(RewardList, self).createToolTip(event)

    @property
    def viewModel(self):
        return self.getViewModel()

    def _onLoading(self, *args, **kwargs):
        super(RewardList, self)._onLoading()
        with self.viewModel.transaction() as (tx):
            rewards = tx.getRewards()
            rewards.clear()
            for bonus in self.__bonuses:
                tooltipId = ('{}').format(self.__idGen.next())
                self.__bonusCache[tooltipId] = bonus
                reward = RewardItemModel()
                reward.setIcon(bonus.images.get('big', ''))
                reward.setTooltipId(tooltipId)
                if bonus.tooltip is not None and isinstance(bonus.tooltip, int):
                    reward.setTooltipContentId(bonus.tooltip)
                rewards.addViewModel(reward)
                rewards.invalidate()

        return