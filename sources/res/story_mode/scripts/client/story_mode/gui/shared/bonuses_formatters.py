import typing
from gui.impl import backport
from gui.impl.gen import R
from gui.Scaleform.daapi.view.lobby.missions.awards_formatters import CurtailingAwardsComposer
from gui.Scaleform.genConsts.TOOLTIPS_CONSTANTS import TOOLTIPS_CONSTANTS
from gui.Scaleform.locale.RES_ICONS import RES_ICONS
from gui.server_events.awards_formatters import AWARDS_SIZES, PreformattedBonus
from story_mode.gui.story_mode_gui_constants import BONUS_ORDER
if typing.TYPE_CHECKING:
    from gui.server_events.awards_formatters import _PreformattedBonus
_IMAGE_FORMAT = '.png'

def getImgName(path):
    if path is None:
        return ''
    else:
        return path.split('/')[(-1)].replace(_IMAGE_FORMAT, '').replace('-', '_')


class StoryModeBonusesAwardsComposer(CurtailingAwardsComposer):

    def _packBonus(self, bonus, size=AWARDS_SIZES.SMALL):
        return bonus

    def _packBonuses(self, preformattedBonuses, size):
        sortedRewards = sorted(preformattedBonuses, key=self._bonusesSortFunction)
        return super(StoryModeBonusesAwardsComposer, self)._packBonuses(sortedRewards, size)

    def _packMergedBonuses(self, mergedBonuses, size=AWARDS_SIZES.SMALL):
        mergedBonusCount = len(mergedBonuses)
        imgs = {AWARDS_SIZES.SMALL: RES_ICONS.getBonusIcon(AWARDS_SIZES.SMALL, 'default'), 
           AWARDS_SIZES.BIG: RES_ICONS.getBonusIcon(AWARDS_SIZES.BIG, 'default')}
        return PreformattedBonus(bonusName='default', label=backport.text(R.strings.marathon.reward.rest(), count=mergedBonusCount), isSpecial=True, images=imgs, specialAlias=TOOLTIPS_CONSTANTS.ADDITIONAL_AWARDS, specialArgs=self._getShortBonusesData(mergedBonuses, size), userName='')

    @staticmethod
    def _bonusesSortFunction(bonus):
        name = bonus.bonusName
        if name in BONUS_ORDER:
            return BONUS_ORDER.index(name)
        return len(BONUS_ORDER) + 1