from gui.shared.tooltips import ToolTipBaseData
from gui.Scaleform.genConsts.TOOLTIPS_CONSTANTS import TOOLTIPS_CONSTANTS
from gui.impl.backport.backport_tooltip import DecoratedTooltipWindow
from gui.impl.lobby.ranked.tooltips.ranked_roles_tooltip_view import RankedRolesTooltipView

class RankedRolesTooltipContentWindowData(ToolTipBaseData):

    def __init__(self, context):
        super(RankedRolesTooltipContentWindowData, self).__init__(context, TOOLTIPS_CONSTANTS.RANKED_BATTLES_ROLES)

    def getDisplayableData(self, roleID, *args, **kwargs):
        return DecoratedTooltipWindow(RankedRolesTooltipView(roleID), useDecorator=False)