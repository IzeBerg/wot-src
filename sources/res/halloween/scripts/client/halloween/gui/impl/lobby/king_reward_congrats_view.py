import WWISE
from frameworks.wulf import ViewSettings, WindowFlags
from gui.shared.event_dispatcher import selectVehicleInHangar
from halloween.gui.game_control.halloween_artefacts_controller import compareBonuses
from halloween.gui.shared.event_dispatcher import showMetaView
from gui.impl.backport import BackportTooltipWindow, createTooltipData
from gui.impl.gen import R
from gui.impl.pub.lobby_window import LobbyNotificationWindow
from gui.server_events.awards_formatters import AWARDS_SIZES
from halloween.gui.impl.gen.view_models.views.lobby.bonus_item_view_model import BonusItemViewModel
from halloween.gui.impl.gen.view_models.views.lobby.king_reward_congrats_view_model import KingRewardCongratsViewModel
from halloween.gui.impl.lobby.base_view import BaseView
from halloween.gui.impl.lobby.hw_helpers.bonuses_formatters import HalloweenBonusesAwardsComposer, getHWMetaAwardFormatter, getImgName
from halloween.gui.sounds import playSound
from halloween.gui.sounds.sound_constants import KING_REWARD_WINDOW_ENTER, KING_REWARD_WINDOW_EXIT, KingRewardState
from halloween.skeletons.halloween_artefacts_controller import IHalloweenArtefactsController
from halloween_common.halloween_constants import ArtefactsSettings
from helpers import dependency
from ids_generators import SequenceIDGenerator
from skeletons.gui.impl import IGuiLoader
_R_BACKPORT_TOOLTIP = R.views.common.tooltip_window.backport_tooltip_content.BackportTooltipContent()

class KingRewardCongratsView(BaseView):
    __slots__ = ('__isVideoInLastArtefact', )
    layoutID = R.views.halloween.lobby.KingRewardCongratsView()
    _MAX_BONUSES_IN_VIEW = 5
    _guiLoader = dependency.descriptor(IGuiLoader)
    _hwArtifactsCtrl = dependency.descriptor(IHalloweenArtefactsController)

    def __init__(self, layoutID, artefactID, isVideoInLastArtefact=False):
        settings = ViewSettings(layoutID or self.layoutID, model=KingRewardCongratsViewModel())
        super(KingRewardCongratsView, self).__init__(settings)
        self.__artefactID = artefactID
        self.__isVideoInLastArtefact = isVideoInLastArtefact
        self.__idGen = SequenceIDGenerator()
        self.__bonusCache = {}

    def createToolTip(self, event):
        if event.contentID == _R_BACKPORT_TOOLTIP:
            tooltipId = event.getArgument('tooltipId')
            bonus = self.__bonusCache.get(tooltipId)
            if bonus:
                window = BackportTooltipWindow(createTooltipData(tooltip=bonus.tooltip, isSpecial=bonus.isSpecial, specialAlias=bonus.specialAlias, specialArgs=bonus.specialArgs), self.getParentWindow())
                window.load()
                return window
        return super(KingRewardCongratsView, self).createToolTip(event)

    @property
    def viewModel(self):
        return super(KingRewardCongratsView, self).getViewModel()

    def _onLoading(self):
        super(KingRewardCongratsView, self)._onLoading()
        with self.viewModel.transaction() as (model):
            model.setIsVideoInLastArtefact(self.__isVideoInLastArtefact)
            artefact = self._hwArtifactsCtrl.getArtefact(self.__artefactID)
            bonuses = artefact.bonusRewards
            rewards = model.getRewards()
            rewards.clear()
            formatter = HalloweenBonusesAwardsComposer(self._MAX_BONUSES_IN_VIEW, getHWMetaAwardFormatter())
            bonusRewards = formatter.getFormattedBonuses(bonuses, AWARDS_SIZES.BIG)
            for bonus in sorted(bonusRewards, cmp=compareBonuses, key=lambda b: b.bonusName):
                tooltipId = ('{}').format(self.__idGen.next())
                self.__bonusCache[tooltipId] = bonus
                if self._hwArtifactsCtrl.getIsHiddenBonusStyle(bonus):
                    continue
                reward = BonusItemViewModel()
                reward.setUserName(str(bonus.userName))
                reward.setName(bonus.bonusName)
                reward.setValue(str(bonus.label))
                reward.setLabel(str(bonus.label))
                reward.setIcon(getImgName(bonus.getImage(AWARDS_SIZES.BIG)))
                reward.setOverlayType(bonus.getOverlayType(AWARDS_SIZES.SMALL))
                reward.setTooltipId(tooltipId)
                if bonus.bonusName == ArtefactsSettings.ARTEFACT:
                    reward.setTooltipContentId(str(R.views.halloween.lobby.tooltips.VideoTooltip()))
                rewards.addViewModel(reward)

            rewards.invalidate()

    def _initialize(self, *args, **kwargs):
        super(KingRewardCongratsView, self)._initialize()
        playSound(KING_REWARD_WINDOW_ENTER)
        WWISE.WW_setState(KingRewardState.GROUP, KingRewardState.GENERAL_ON)

    def _finalize(self):
        playSound(KING_REWARD_WINDOW_EXIT)
        WWISE.WW_setState(KingRewardState.GROUP, KingRewardState.GENERAL_OFF)
        super(KingRewardCongratsView, self)._finalize()

    def _subscribe(self):
        super(KingRewardCongratsView, self)._subscribe()
        self.viewModel.onClose += self._onClose
        self.viewModel.onAccept += self._onAccept
        self.viewModel.onShowClick += self._onShowClick

    def _unsubscribe(self):
        super(KingRewardCongratsView, self)._unsubscribe()
        self.viewModel.onClose -= self._onClose
        self.viewModel.onAccept -= self._onAccept
        self.viewModel.onShowClick -= self._onShowClick

    def _onAccept(self):
        metaView = self._guiLoader.windowsManager.getViewByLayoutID(R.views.halloween.lobby.MetaView())
        if metaView is not None:
            metaView.selectArtefact(self.__artefactID)
        else:
            showMetaView(self.__artefactID)
        self.destroyWindow()
        return

    def _onShowClick(self):
        mainVehicle = self._hwArtifactsCtrl.getMainGiftVehicle()
        selectVehicleInHangar(mainVehicle.intCD)
        self.destroyWindow()


class KingRewardCongratsWindow(LobbyNotificationWindow):

    def __init__(self, layoutID, artefactID, isVideoInLastArtefact, parent=None):
        super(KingRewardCongratsWindow, self).__init__(wndFlags=WindowFlags.WINDOW_FULLSCREEN | WindowFlags.WINDOW, content=KingRewardCongratsView(layoutID, artefactID, isVideoInLastArtefact), parent=parent)
        self._args = (
         layoutID, artefactID)

    def isParamsEqual(self, *args):
        return self._args == args