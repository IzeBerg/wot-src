from gui.impl.gen import R
from gui.impl.lobby.tooltips.additional_rewards_tooltip import AdditionalRewardsTooltip

class NearestAdditionalRewardsTooltip(AdditionalRewardsTooltip):
    __slots__ = ()

    @classmethod
    def _getHeader(cls):
        return R.strings.tooltips.quests.awards.nearest.header()