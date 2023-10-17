from frameworks.wulf import ViewSettings
from gui.impl.gen import R
from gui.impl.pub import ViewImpl
from gui.server_events.awards_formatters import AWARDS_SIZES
from halloween.gui.impl.gen.view_models.views.lobby.bonus_item_view_model import BonusItemViewModel
from halloween.gui.impl.gen.view_models.views.lobby.tooltips.rewards_tooltip_view_model import RewardsTooltipViewModel
from halloween.gui.impl.lobby.hw_helpers.bonuses_formatters import HalloweenBonusesAwardsComposer, getHWMetaAwardFormatter, getImgName

class RewardsTooltipView(ViewImpl):
    __slots__ = ('__rewards', )
    _MAX_BONUSES_IN_VIEW = 5

    def __init__(self, rewards, layoutID=R.views.halloween.lobby.tooltips.RewardsTooltip()):
        settings = ViewSettings(layoutID)
        settings.model = RewardsTooltipViewModel()
        super(RewardsTooltipView, self).__init__(settings)
        self.__rewards = rewards

    @property
    def viewModel(self):
        return super(RewardsTooltipView, self).getViewModel()

    def _onLoading(self, *args, **kwargs):
        super(RewardsTooltipView, self)._onLoading()
        with self.viewModel.transaction() as (model):
            rewardsVM = model.getRewards()
            rewardsVM.clear()
            if not self.__rewards:
                return
            formatter = HalloweenBonusesAwardsComposer(self._MAX_BONUSES_IN_VIEW, getHWMetaAwardFormatter())
            bonusRewards = formatter.getFormattedBonuses(self.__rewards, AWARDS_SIZES.BIG)
            for bonus in bonusRewards:
                reward = BonusItemViewModel()
                reward.setUserName(str(bonus.userName))
                reward.setName(bonus.bonusName)
                reward.setValue(str(bonus.label))
                reward.setIcon(getImgName(bonus.getImage(AWARDS_SIZES.BIG)))
                reward.setOverlayType(bonus.getOverlayType(AWARDS_SIZES.SMALL))
                rewardsVM.addViewModel(reward)

            rewardsVM.invalidate()