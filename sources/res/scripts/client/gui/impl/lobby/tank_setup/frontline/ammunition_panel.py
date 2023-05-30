from gui.impl.gen import R
from gui.impl.lobby.tank_setup.ammunition_panel.hangar_view import HangarAmmunitionPanelView

class FrontlineAmmunitionPanelView(HangarAmmunitionPanelView):

    def createToolTipContent(self, event, contentID):
        if event.contentID == R.views.frontline.lobby.tooltips.SkillOrderTooltip():
            from frontline.gui.impl.lobby.tooltips.skill_order_tooltip import SkillOrderTooltip
            return SkillOrderTooltip()
        return super(FrontlineAmmunitionPanelView, self).createToolTipContent(event, contentID)