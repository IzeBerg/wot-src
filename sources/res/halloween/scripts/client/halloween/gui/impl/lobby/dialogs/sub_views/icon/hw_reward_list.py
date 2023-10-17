from gui.impl.dialogs.sub_views.icon.reward_list import RewardList
from gui.impl.gen import R
from halloween.gui.impl.lobby.tooltips.key_tooltip import KeyTooltipView

class HWRewardList(RewardList):

    def createToolTipContent(self, event, contentID):
        if contentID == R.views.halloween.lobby.tooltips.KeyTooltip():
            return KeyTooltipView(isPostBattle=False)
        return super(HWRewardList, self).createToolTipContent(event, contentID)