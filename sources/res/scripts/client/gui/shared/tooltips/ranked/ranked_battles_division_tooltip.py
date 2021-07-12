from gui.impl import backport
from gui.impl.gen import R
from gui.shared.formatters import text_styles
from gui.shared.tooltips import TOOLTIP_TYPE
from gui.shared.tooltips import formatters
from gui.shared.tooltips.common import BlocksTooltipData
from helpers import dependency
from shared_utils import findFirst
from skeletons.gui.game_control import IRankedBattlesController
_TOOLTIP_MIN_WIDTH = 364
_TOOLTIP_ICON_SIZE = 56

class RankedDivisionTooltip(BlocksTooltipData):
    rankedController = dependency.descriptor(IRankedBattlesController)

    def __init__(self, ctx):
        super(RankedDivisionTooltip, self).__init__(ctx, TOOLTIP_TYPE.RANKED_DIVISION_INFO)
        self._setContentMargin(top=18, left=20, bottom=18, right=20)
        self._setMargins(afterBlock=13)
        self._setWidth(_TOOLTIP_MIN_WIDTH)

    def _packBlocks(self, divisionId, isCurrent, isLocked, isCompleted):
        items = super(RankedDivisionTooltip, self)._packBlocks()
        division = findFirst(lambda d: d.getUserID() == divisionId, self.rankedController.getDivisions())
        items.append(self._getTitleBlock(division))
        items.append(self._getDescriptionBlock(division, isLocked, isCompleted))
        items.append(self._getStatusBlock(division, isLocked, isCompleted))
        return items

    @staticmethod
    def _getDescriptionBlock(division, isLocked, isCompleted):
        descTitle = text_styles.middleTitle(backport.text(R.strings.ranked_battles.division.tooltip.desc.title()))
        descKey = 'current'
        if isLocked:
            descKey = 'locked'
        elif isCompleted:
            descKey = 'completed'
        if division.isQualification():
            descKey += 'Qual'
        elif division.isFinal():
            descKey += 'Final'
        descText = text_styles.standard(backport.text(R.strings.ranked_battles.division.tooltip.desc.dyn(descKey).text()))
        return formatters.packImageTextBlockData(title=descTitle, desc=descText, txtPadding=formatters.packPadding(left=10))

    @staticmethod
    def _getStatusBlock(division, isLocked, isCompleted):
        statusTitle = text_styles.warning(backport.text(R.strings.ranked_battles.division.tooltip.status.current()))
        statusText = None
        if division.isQualification():
            statusTitle = text_styles.warning(backport.text(R.strings.ranked_battles.division.tooltip.status.currentQual()))
        if isLocked:
            statusTitle = text_styles.critical(backport.text(R.strings.ranked_battles.division.tooltip.status.locked()))
            statusText = text_styles.standard(backport.text(R.strings.ranked_battles.division.tooltip.status.locked.desc()))
            if division.isPostQualification():
                statusText = text_styles.standard(backport.text(R.strings.ranked_battles.division.tooltip.status.locked.descQual()))
        if isCompleted:
            statusTitle = text_styles.statInfo(backport.text(R.strings.ranked_battles.division.tooltip.status.completed()))
            if division.isQualification():
                statusTitle = text_styles.statInfo(backport.text(R.strings.ranked_battles.division.tooltip.status.completedQual()))
        return formatters.packImageTextBlockData(title=statusTitle, desc=statusText, txtPadding=formatters.packPadding(left=10))

    def _getTitleBlock(self, division):
        divisionId = division.getUserID()
        divisionIcon = backport.image(R.images.gui.maps.icons.rankedBattles.divisions.c_56x56.dyn(divisionId)())
        desc = backport.text(R.strings.ranked_battles.division.tooltip.rankDescription(), ranksCount=len(division.getRanksIDs()))
        if division.isQualification():
            desc = backport.text(R.strings.ranked_battles.division.tooltip.battlesDescription(), battlesCount=self.rankedController.getTotalQualificationBattles())
        return formatters.packImageTextBlockData(title=text_styles.highTitle(backport.text(R.strings.ranked_battles.division.dyn(divisionId)())), desc=text_styles.main(desc), img=divisionIcon, imgPadding=formatters.packPadding(top=5), txtPadding=formatters.packPadding(left=10))