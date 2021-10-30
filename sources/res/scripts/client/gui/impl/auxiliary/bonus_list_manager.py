from gui.impl.auxiliary.rewards_helper import getRewardRendererModelPresenter
from gui.impl.backport import createTooltipData, BackportTooltipWindow, TooltipData
from gui.impl.gen import R
from gui.impl.gen.view_models.views.lobby.blueprints.blueprint_screen_tooltips import BlueprintScreenTooltips
from gui.Scaleform.genConsts.TOOLTIPS_CONSTANTS import TOOLTIPS_CONSTANTS

class BonusListManager(object):
    __slots__ = ('__tooltipsData', )

    def __init__(self):
        self.__tooltipsData = {}

    def clear(self):
        self.__tooltipsData = {}

    def setBonuses(self, bonuses, model, lastCongratsIndex=-1):
        rewardsList = model.getRewards()
        rewardsList.clear()
        for index, reward in enumerate(bonuses):
            formatter = getRewardRendererModelPresenter(reward)
            showCongrats = index is lastCongratsIndex
            rewardRender = formatter.getModel(reward, index, showCongrats=showCongrats)
            rewardsList.addViewModel(rewardRender)
            compensationReason = reward.get('compensationReason', None)
            ttTarget = compensationReason if compensationReason is not None else reward
            self.__tooltipsData[index] = TooltipData(tooltip=ttTarget.get('tooltip', None), isSpecial=ttTarget.get('isSpecial', False), specialAlias=ttTarget.get('specialAlias', ''), specialArgs=ttTarget.get('specialArgs', None))

        rewardsList.invalidate()
        return

    def createToolTip(self, event, parentWindow):
        if event.contentID == R.views.common.tooltip_window.backport_tooltip_content.BackportTooltipContent():
            tooltipData = self.__getBackportTooltipData(event)
            if tooltipData is not None:
                return BackportTooltipWindow(tooltipData, parentWindow)
            return
        return

    def __getBackportTooltipData(self, event):
        tooltipId = event.getArgument('tooltipId')
        if tooltipId is None:
            return
        else:
            if tooltipId in self.__tooltipsData:
                return self.__tooltipsData[tooltipId]
            if tooltipId == BlueprintScreenTooltips.TOOLTIP_BLUEPRINT:
                vehicleCD = event.getArgument('vehicleCD')
                return createTooltipData(isSpecial=True, specialAlias=TOOLTIPS_CONSTANTS.BLUEPRINT_INFO, specialArgs=(
                 vehicleCD, True))
            if tooltipId == BlueprintScreenTooltips.TOOLTIP_BLUEPRINT_CONVERT_COUNT:
                vehicleCD = event.getArgument('vehicleCD')
                return createTooltipData(isSpecial=True, specialAlias=TOOLTIPS_CONSTANTS.BLUEPRINT_CONVERT_INFO, specialArgs=[
                 vehicleCD])
            return