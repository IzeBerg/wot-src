from frameworks.wulf import WindowFlags, WindowLayer, ViewSettings, ViewFlags
from gui.impl.auxiliary.rewards_helper import getRewardTooltipContent
from gui.impl.backport import BackportTooltipWindow
from gui.impl.gen import R
from gui.impl.gen.view_models.views.lobby.wot_anniversary.interesting_fact_and_bonus_view_model import InterestingFactAndBonusViewModel
from gui.impl.pub import ViewImpl
from gui.impl.pub.lobby_window import LobbyNotificationWindow
from gui.server_events.bonuses import getNonQuestBonuses
from gui.shared import events, EVENT_BUS_SCOPE
from gui.wot_anniversary.wot_anniversary_bonuses_packers import packBonusModelAndTooltipData
from gui.wot_anniversary.wot_anniversary_helpers import getQuestDayNumber, getFactGfImagePath, showMainView, showWotAnniversaryIntroWindow, isAnniversaryIntroShowed
from gui.wot_anniversary.wot_anniversary_sound import WOT_ANNIVERSARY_INTERESTING_FACT_AND_BONUS_SOUND
from helpers import dependency
from skeletons.account_helpers.settings_core import ISettingsCore
from skeletons.gui.game_control import IWotAnniversaryController
_R_BACKPORT_TOOLTIP = R.views.common.tooltip_window.backport_tooltip_content.BackportTooltipContent()

class InterestingFactAndBonusView(ViewImpl):
    __wotAnniversaryCtrl = dependency.descriptor(IWotAnniversaryController)
    __settingsCore = dependency.descriptor(ISettingsCore)
    _COMMON_SOUND_SPACE = WOT_ANNIVERSARY_INTERESTING_FACT_AND_BONUS_SOUND
    __slots__ = ('__tooltipItems', )

    def __init__(self, *args, **kwargs):
        settings = ViewSettings(R.views.lobby.wot_anniversary.InterestingFactAndBonusView())
        settings.flags = ViewFlags.VIEW
        settings.model = InterestingFactAndBonusViewModel()
        settings.args = args
        settings.kwargs = kwargs
        self.__tooltipItems = {}
        super(InterestingFactAndBonusView, self).__init__(settings)

    @property
    def viewModel(self):
        return super(InterestingFactAndBonusView, self).getViewModel()

    def _initialize(self, *args, **kwargs):
        self.__wotAnniversaryCtrl.onSettingsChanged += self.__onSettingsChange
        self.viewModel.onOpenEventInfo += self.__onOpenEventInfo

    def _finalize(self):
        self.__wotAnniversaryCtrl.onSettingsChanged -= self.__onSettingsChange
        self.viewModel.onOpenEventInfo -= self.__onOpenEventInfo
        self.__tooltipItems.clear()

    def _onLoading(self, questID, rawAwards, *args, **kwargs):
        super(InterestingFactAndBonusView, self)._onLoading(*args, **kwargs)
        self.__fillModel(questID, rawAwards)

    def _getListeners(self):
        return (
         (
          events.WotAnniversaryEvent.ON_MAIN_VIEW_OPENED, self.__onClose, EVENT_BUS_SCOPE.LOBBY),)

    def createToolTip(self, event):
        if event.contentID == _R_BACKPORT_TOOLTIP:
            tooltipData = self.__getBackportTooltipData(event)
            window = BackportTooltipWindow(tooltipData, self.getParentWindow()) if tooltipData is not None else None
            if window is not None:
                window.load()
            return window
        return super(InterestingFactAndBonusView, self).createToolTip(event)

    def createToolTipContent(self, event, contentID):
        tooltipData = self.__getBackportTooltipData(event)
        return getRewardTooltipContent(event, tooltipData)

    def __onSettingsChange(self):
        if not self.__wotAnniversaryCtrl.isAvailableAndActivePhase():
            self.destroyWindow()

    def __getBackportTooltipData(self, event):
        tooltipId = event.getArgument('tooltipId')
        if tooltipId is None:
            return
        else:
            return self.__tooltipItems.get(tooltipId)

    def __fillModel(self, questID, rawAwards):
        dayNumber = getQuestDayNumber(questID)
        totalDays = self.__wotAnniversaryCtrl.getTotalDaysNumber()
        facts = self.__wotAnniversaryCtrl.getInterestingFacts()[:dayNumber]
        bonuses = []
        for key, value in rawAwards.iteritems():
            bonuses.extend(getNonQuestBonuses(key, value, ctx=None))

        with self.viewModel.transaction() as (model):
            factsUrls = model.getCardsUrls()
            for fact in facts:
                factsUrls.addString(getFactGfImagePath(fact.bigSizeResourceId))

            model.setCurrentDay(dayNumber)
            model.setTotalDays(totalDays)
            packBonusModelAndTooltipData(bonuses, model.getRewards(), self.__tooltipItems)
        return

    def __onOpenEventInfo(self):
        self.destroyWindow()
        if not isAnniversaryIntroShowed():
            showWotAnniversaryIntroWindow(closeCallback=showMainView)
        else:
            showMainView()

    def __onClose(self, _):
        self.destroyWindow()


class InterestingFactAndBonusViewWindow(LobbyNotificationWindow):
    __slots__ = ('__args', )

    def __init__(self, questID, rawAwards, parent=None):
        super(InterestingFactAndBonusViewWindow, self).__init__(wndFlags=WindowFlags.WINDOW, layer=WindowLayer.WINDOW, content=InterestingFactAndBonusView(questID, rawAwards), parent=parent)
        self.__args = (
         questID, rawAwards)

    def load(self):
        super(InterestingFactAndBonusViewWindow, self).load()
        self.center()

    def isParamsEqual(self, *args):
        return self.__args == args