import WWISE
from frameworks.wulf import ViewSettings, WindowFlags
from gui.impl.backport import BackportTooltipWindow, createTooltipData
from gui.impl.gen import R
from gui.impl.pub.lobby_window import LobbyNotificationWindow
from halloween.gui.impl.gen.view_models.views.lobby.king_reward_congrats_view_model import KingRewardCongratsViewModel
from halloween.gui.impl.lobby import fillRewards
from halloween.gui.impl.lobby.base_view import BaseView
from halloween.gui.sounds import playSound
from halloween.gui.sounds.sound_constants import KING_REWARD_WINDOW_ENTER, KING_REWARD_WINDOW_EXIT, KingRewardState
from halloween.gui.shared.event_dispatcher import selectVehicleInHangarWithFade
from halloween.skeletons.halloween_artefacts_controller import IHalloweenArtefactsController
from helpers import dependency, int2roman
from ids_generators import SequenceIDGenerator
from skeletons.gui.impl import IGuiLoader
_R_BACKPORT_TOOLTIP = R.views.common.tooltip_window.backport_tooltip_content.BackportTooltipContent()

class KingRewardCongratsView(BaseView):
    layoutID = R.views.halloween.lobby.KingRewardCongratsView()
    _MAX_BONUSES_IN_VIEW = 5
    _guiLoader = dependency.descriptor(IGuiLoader)
    _hwArtifactsCtrl = dependency.descriptor(IHalloweenArtefactsController)

    def __init__(self, layoutID, artefactID):
        settings = ViewSettings(layoutID or self.layoutID, model=KingRewardCongratsViewModel())
        super(KingRewardCongratsView, self).__init__(settings)
        self.__artefactID = artefactID
        self.__idGen = SequenceIDGenerator()
        self.__bonusCache = {}

    def createToolTip(self, event):
        if event.contentID == _R_BACKPORT_TOOLTIP:
            tooltipId = event.getArgument('tooltipId')
            bonus = self.__bonusCache.get(tooltipId)
            if bonus:
                window = BackportTooltipWindow(createTooltipData(tooltip=bonus.tooltip, isSpecial=bonus.isSpecial, specialAlias=bonus.specialAlias, specialArgs=bonus.specialArgs, isWulfTooltip=bonus.isWulfTooltip), self.getParentWindow(), event=event)
                window.load()
                return window
        return super(KingRewardCongratsView, self).createToolTip(event)

    @property
    def viewModel(self):
        return super(KingRewardCongratsView, self).getViewModel()

    def _onLoading(self):
        super(KingRewardCongratsView, self)._onLoading()
        with self.viewModel.transaction() as (model):
            artefact = self._hwArtifactsCtrl.getArtefact(self.__artefactID)
            vehicle = self._hwArtifactsCtrl.getMainGiftVehicle()
            if vehicle:
                model.setVehicleUserName(vehicle.userName)
                model.setVehicleLevel(int2roman(vehicle.level))
                model.setVehicleType(vehicle.type)
                model.setVehicleIsPremium(vehicle.isPremium)
            rewards = model.getRewards()
            rewards.clear()
            self.__bonusCache.update(fillRewards(artefact, rewards, self._MAX_BONUSES_IN_VIEW, self.__idGen))
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
        self.viewModel.onToOutroClick += self._onToOutro
        self.viewModel.onToGarageClick += self._onToGarage

    def _unsubscribe(self):
        super(KingRewardCongratsView, self)._unsubscribe()
        self.viewModel.onClose -= self._onClose
        self.viewModel.onToOutroClick -= self._onToOutro
        self.viewModel.onToGarageClick -= self._onToGarage

    def _onToOutro(self):
        hangarView = self._guiLoader.windowsManager.getViewByLayoutID(R.views.halloween.lobby.HangarView())
        if hangarView is not None:
            hangarView.selectSlideByArtefact(self.__artefactID)
        self.destroyWindow()
        return

    def _onToGarage(self):
        mainVehicle = self._hwArtifactsCtrl.getMainGiftVehicle()
        selectVehicleInHangarWithFade(mainVehicle.intCD)
        self.destroyWindow()


class KingRewardCongratsWindow(LobbyNotificationWindow):

    def __init__(self, layoutID, artefactID, parent=None):
        super(KingRewardCongratsWindow, self).__init__(wndFlags=WindowFlags.WINDOW_FULLSCREEN | WindowFlags.WINDOW, content=KingRewardCongratsView(layoutID, artefactID), parent=parent)
        self._args = (
         layoutID, artefactID)

    def isParamsEqual(self, *args):
        return self._args == args