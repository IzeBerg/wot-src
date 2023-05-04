from debug_utils import LOG_DEBUG
from gui.shared.tooltips import TOOLTIP_TYPE, ToolTipData, ToolTipAttrField

class SkillTooltipData(ToolTipData):

    def __init__(self, context):
        super(SkillTooltipData, self).__init__(context, TOOLTIP_TYPE.SKILL)
        LOG_DEBUG('SkillTooltipData')
        self.fields = (
         ToolTipAttrField(self, 'name', 'userName'),
         ToolTipAttrField(self, 'shortDescr', 'shortDescription'),
         ToolTipAttrField(self, 'descr', 'description'),
         ToolTipAttrField(self, 'level'),
         ToolTipAttrField(self, 'type'),
         ToolTipAttrField(self, 'count'))


class BuySkillTooltipData(SkillTooltipData):

    def __init__(self, context):
        super(BuySkillTooltipData, self).__init__(context)
        self.fields = self.fields + (
         ToolTipAttrField(self, 'header'),)