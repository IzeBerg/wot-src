from gui.shared.tooltips.builders import DataBuilder
from gui.shared.tooltips import common, contexts
from gui.Scaleform.genConsts.TOOLTIPS_CONSTANTS import TOOLTIPS_CONSTANTS
__all__ = ('getTooltipBuilders', )

class WotPlusBuilder(DataBuilder):
    __slots__ = ()

    def __init__(self, tooltipType, linkage):
        super(WotPlusBuilder, self).__init__(tooltipType, linkage, common.WotPlusTooltipContentWindowData(contexts.ToolTipContext(None)))
        return

    def build(self, manager, formatType, advanced_, *args, **kwargs):
        return self._provider


def getTooltipBuilders():
    return (
     WotPlusBuilder(TOOLTIPS_CONSTANTS.WOT_PLUS, None),)