from fun_random.gui.feature.util.fun_mixins import FunProgressionWatcher
from fun_random.gui.feature.util.fun_wrappers import hasActiveProgression
from gui.shared.tooltips.quests import AdditionalAwardTooltipData
from fun_random.gui.Scaleform.daapi.view.lobby.server_events.awards_formatters import FunCurtailingAwardsComposer, getFunAwardsPacker
_MAX_BONUS_COUNT = 8

class FunRandomRewardsTooltip(AdditionalAwardTooltipData, FunProgressionWatcher):

    @hasActiveProgression(defReturn=[])
    def _packBlocks(self, *args, **kwargs):
        formatter = FunCurtailingAwardsComposer(_MAX_BONUS_COUNT, getFunAwardsPacker())
        formattedBonuses = formatter.getShortBonusesData(self.getActiveProgression().getAllBonuses())
        return super(FunRandomRewardsTooltip, self)._packBlocks(*formattedBonuses)