import WWISE
from frameworks.wulf import ViewSettings, WindowFlags
from gui.impl.gen import R
from gui.impl.backport import BackportTooltipWindow, createTooltipData
from gui.impl.pub.lobby_window import LobbyNotificationWindow
from halloween.gui.impl.gen.view_models.views.lobby.reward_window_view_model import RewardWindowViewModel
from halloween.gui.impl.lobby.base_view import BaseView
from halloween.gui.impl.lobby.tooltips.video_tooltip import VideoTooltipView
from halloween.gui.sounds import playSound
from halloween.gui.sounds.sound_constants import RewardState, REWARD_SCREEN_ENTER, REWARD_SCREEN_EXIT
from halloween_common.halloween_constants import ArtefactsSettings
from helpers import dependency
from halloween.skeletons.halloween_artefacts_controller import IHalloweenArtefactsController
from gui.server_events.awards_formatters import AWARDS_SIZES
from halloween.gui.impl.gen.view_models.views.lobby.bonus_item_view_model import BonusItemViewModel
from halloween.gui.impl.lobby.hw_helpers.bonuses_formatters import HalloweenBonusesAwardsComposer, getImgName, getHWMetaAwardFormatter
from ids_generators import SequenceIDGenerator
_R_BACKPORT_TOOLTIP = R.views.common.tooltip_window.backport_tooltip_content.BackportTooltipContent()

class RewardWindowView(BaseView):
    __slots__ = ('__artefactId', )
    layoutID = R.views.halloween.lobby.RewardWindowView()
    _MAX_BONUSES_IN_VIEW = 5
    _hwArtifactsCtrl = dependency.descriptor(IHalloweenArtefactsController)

    def __init__(self, artefactId, layoutID=None):
        settings = ViewSettings(layoutID or self.layoutID, model=RewardWindowViewModel())
        super(RewardWindowView, self).__init__(settings)
        self.__idGen = SequenceIDGenerator()
        self.__bonusCache = {}
        self.__artefactId = artefactId

    def createToolTip(self, event):
        if event.contentID == _R_BACKPORT_TOOLTIP:
            tooltipId = event.getArgument('tooltipId')
            bonus = self.__bonusCache.get(tooltipId)
            if bonus:
                window = BackportTooltipWindow(createTooltipData(tooltip=bonus.tooltip, isSpecial=bonus.isSpecial, specialAlias=bonus.specialAlias, specialArgs=bonus.specialArgs), self.getParentWindow())
                window.load()
                return window
        return super(RewardWindowView, self).createToolTip(event)

    def createToolTipContent(self, event, contentID):
        if contentID == R.views.halloween.lobby.tooltips.VideoTooltip():
            return VideoTooltipView()
        return super(RewardWindowView, self).createToolTipContent(event, contentID)

    @property
    def viewModel(self):
        return super(RewardWindowView, self).getViewModel()

    def _onLoading(self):
        super(RewardWindowView, self)._onLoading()
        with self.viewModel.transaction() as (model):
            artefact = self._hwArtifactsCtrl.getArtefact(self.__artefactId)
            model.setDifficulty(artefact.difficulty)
            bonuses = artefact.bonusRewards
            rewards = model.getRewards()
            rewards.clear()
            formatter = HalloweenBonusesAwardsComposer(self._MAX_BONUSES_IN_VIEW, getHWMetaAwardFormatter(True))
            bonusRewards = formatter.getFormattedBonuses(bonuses, AWARDS_SIZES.BIG)
            for bonus in bonusRewards:
                tooltipId = ('{}').format(self.__idGen.next())
                self.__bonusCache[tooltipId] = bonus
                reward = BonusItemViewModel()
                reward.setUserName(str(bonus.userName))
                reward.setName(bonus.bonusName)
                reward.setValue(str(bonus.label))
                reward.setIcon(getImgName(bonus.getImage(AWARDS_SIZES.BIG)))
                reward.setOverlayType(bonus.getOverlayType(AWARDS_SIZES.SMALL))
                reward.setTooltipId(tooltipId)
                if bonus.bonusName == ArtefactsSettings.ARTEFACT:
                    reward.setTooltipContentId(str(R.views.halloween.lobby.tooltips.VideoTooltip()))
                rewards.addViewModel(reward)

            rewards.invalidate()

    def _initialize(self, *args, **kwargs):
        super(RewardWindowView, self)._initialize()
        playSound(REWARD_SCREEN_ENTER)
        WWISE.WW_setState(RewardState.GROUP, RewardState.GENERAL_ON)

    def _finalize(self):
        playSound(REWARD_SCREEN_EXIT)
        WWISE.WW_setState(RewardState.GROUP, RewardState.GENERAL_OFF)
        super(RewardWindowView, self)._finalize()

    def _subscribe(self):
        super(RewardWindowView, self)._subscribe()
        self.viewModel.onClose += self._onClose

    def _unsubscribe(self):
        super(RewardWindowView, self)._unsubscribe()
        self.viewModel.onClose -= self._onClose


class RewardWindow(LobbyNotificationWindow):

    def __init__(self, layoutID, artefactID, parent=None):
        super(RewardWindow, self).__init__(wndFlags=WindowFlags.WINDOW_FULLSCREEN | WindowFlags.WINDOW, content=RewardWindowView(artefactID, layoutID=layoutID), parent=parent)
        self._args = (
         layoutID, artefactID)

    def isParamsEqual(self, *args):
        return self._args == args