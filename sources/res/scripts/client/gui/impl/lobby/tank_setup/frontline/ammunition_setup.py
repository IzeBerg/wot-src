from gui.impl.lobby.tank_setup.ammunition_setup.hangar import HangarAmmunitionSetupView
from gui.impl.gen import R

class FrontlineAmmunitionSetupView(HangarAmmunitionSetupView):

    def createToolTipContent(self, event, contentID):
        if contentID == R.views.frontline.lobby.tooltips.SkillOrderTooltip():
            from frontline.gui.impl.lobby.tooltips.skill_order_tooltip import SkillOrderTooltip
            return SkillOrderTooltip()
        if contentID == R.views.frontline.lobby.tooltips.LevelReservesTooltip():
            from frontline.gui.impl.lobby.tooltips.level_reserves_tooltip import LevelReservesTooltip
            return LevelReservesTooltip()
        if contentID == R.views.frontline.lobby.tooltips.NotEnoughPointsTooltip():
            from frontline.gui.impl.lobby.tooltips.not_enough_points_tooltip import NotEnoughPointsTooltip
            return NotEnoughPointsTooltip(event.getArgument('points'))
        return super(FrontlineAmmunitionSetupView, self).createToolTipContent(event, contentID)