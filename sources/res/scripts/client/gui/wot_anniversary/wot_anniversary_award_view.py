from frameworks.wulf import ViewFlags, ViewSettings, WindowFlags, WindowLayer
from gui.impl.auxiliary.rewards_helper import getRewardTooltipContent
from gui.impl.backport import BackportTooltipWindow
from gui.impl.gen import R
from gui.impl.gen.view_models.views.lobby.wot_anniversary.wot_anniversary_rewards_view_model import WotAnniversaryRewardsViewModel
from gui.impl.pub import ViewImpl
from gui.impl.pub.lobby_window import LobbyNotificationWindow
from gui.server_events.bonuses import getMergedBonusesFromDicts
from gui.shared.event_dispatcher import showHangar
from gui.wot_anniversary.wot_anniversary_bonuses_packers import packBonusModelAndTooltipData, composeBonuses
from gui.wot_anniversary.wot_anniversary_sound import WOT_ANNIVERSARY_REWARD_SCREEN_SOUND
from helpers import dependency
from skeletons.gui.game_control import IWotAnniversaryController
_R_BACKPORT_TOOLTIP = R.views.common.tooltip_window.backport_tooltip_content.BackportTooltipContent()

class WotAnniversaryAwardView(ViewImpl):
    __wotAnniversaryCtrl = dependency.descriptor(IWotAnniversaryController)
    _COMMON_SOUND_SPACE = WOT_ANNIVERSARY_REWARD_SCREEN_SOUND
    __slots__ = ('__tooltipItems', )

    def __init__(self, *args, **kwargs):
        settings = ViewSettings(R.views.lobby.wot_anniversary.RewardScreen())
        settings.flags = ViewFlags.VIEW
        settings.model = WotAnniversaryRewardsViewModel()
        settings.args = args
        settings.kwargs = kwargs
        self.__tooltipItems = {}
        super(WotAnniversaryAwardView, self).__init__(settings)

    @property
    def viewModel(self):
        return super(WotAnniversaryAwardView, self).getViewModel()

    def _initialize(self, *args, **kwargs):
        self.viewModel.onClosed += self.__onClosed
        self.__wotAnniversaryCtrl.onSettingsChanged += self.__onSettingsChange

    def _finalize(self):
        self.viewModel.onClosed -= self.__onClosed
        self.__wotAnniversaryCtrl.onSettingsChanged -= self.__onSettingsChange
        self.__tooltipItems.clear()

    def _onLoading(self, rawAwards, *args, **kwargs):
        super(WotAnniversaryAwardView, self)._onLoading(*args, **kwargs)
        self.__fillModel(rawAwards)

    def createToolTip(self, event):
        if event.contentID == _R_BACKPORT_TOOLTIP:
            tooltipData = self.__getBackportTooltipData(event)
            window = BackportTooltipWindow(tooltipData, self.getParentWindow()) if tooltipData is not None else None
            if window is not None:
                window.load()
            return window
        return super(WotAnniversaryAwardView, self).createToolTip(event)

    def createToolTipContent(self, event, contentID):
        tooltipData = self.__getBackportTooltipData(event)
        return getRewardTooltipContent(event, tooltipData)

    def __getBackportTooltipData(self, event):
        tooltipId = event.getArgument('tooltipId')
        if tooltipId is None:
            return
        else:
            return self.__tooltipItems.get(tooltipId)

    def __onClosed(self):
        self.destroyWindow()

    def __fillModel(self, rawAwards):
        mainBonuses, bonuses = composeBonuses(getMergedBonusesFromDicts(rawAwards))
        with self.viewModel.transaction() as (model):
            packBonusModelAndTooltipData(mainBonuses, model.getMainRewards(), self.__tooltipItems)
            if bonuses:
                packBonusModelAndTooltipData(bonuses, model.getRewards(), self.__tooltipItems)

    def __onSettingsChange(self):
        if not self.__wotAnniversaryCtrl.isAvailable():
            self.destroyWindow()
            showHangar()


class WotAnniversaryAwardWindow(LobbyNotificationWindow):
    __slots__ = ('__args', )

    def __init__(self, rawAwards, parent=None):
        super(WotAnniversaryAwardWindow, self).__init__(wndFlags=WindowFlags.WINDOW | WindowFlags.WINDOW_FULLSCREEN, layer=WindowLayer.FULLSCREEN_WINDOW, content=WotAnniversaryAwardView(rawAwards), parent=parent)
        self.__args = (
         rawAwards,)

    def isParamsEqual(self, *args):
        return self.__args == args