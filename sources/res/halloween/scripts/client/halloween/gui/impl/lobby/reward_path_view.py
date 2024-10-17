import typing
from gui.impl.backport import BackportTooltipWindow, createTooltipData
from halloween.gui.impl.gen.view_models.views.lobby.reward_path_item_view_model import RewardPathItemViewModel
from halloween.gui.impl.lobby import getArtefactState, fillRewards
from halloween.gui.impl.lobby.base_view import BaseView
from halloween.gui.impl.lobby.tooltips.event_mission_tooltip import EventMissionsTooltip
from halloween.gui.sounds import playSound
from halloween.gui.sounds.sound_constants import REWARD_PATH_EXIT, REWARD_PATH_ENTER
from halloween.skeletons.halloween_controller import IHalloweenController
from ids_generators import SequenceIDGenerator
from shared_utils import first
from CurrentVehicle import g_currentPreviewVehicle
from frameworks.wulf import ViewSettings, ViewFlags, ViewEvent, View
from gui.impl import backport
from gui.impl.gen import R
from gui.impl.lobby.common.view_mixins import LobbyHeaderVisibility
from gui.shared import g_eventBus, events
from halloween.gui.impl.gen.view_models.views.lobby.reward_path_view_model import RewardPathViewModel
from halloween.gui.impl.gen.view_models.views.lobby.vehicle_title_view_model import VehicleTypes
from halloween.gui.impl.lobby.widgets.keys_view import KeysView
from halloween.gui.shared.event_dispatcher import showRewardPathView, showHangar, showVehiclePreview, showMetaIntroView, showIntroVideo, selectVehicleInHangarWithFade
from halloween.skeletons.halloween_artefacts_controller import IHalloweenArtefactsController
from helpers import dependency, int2roman
if typing.TYPE_CHECKING:
    from halloween.gui.game_control.halloween_artefacts_controller import Artefact
_R_BACKPORT_TOOLTIP = R.views.common.tooltip_window.backport_tooltip_content.BackportTooltipContent()

class RewardPathView(BaseView, LobbyHeaderVisibility):
    _hwController = dependency.descriptor(IHalloweenController)
    _hwArtefactsCtrl = dependency.descriptor(IHalloweenArtefactsController)
    _MAX_BONUSES_IN_VIEW = 5

    def __init__(self, layoutID=R.views.halloween.lobby.RewardPathView(), selectedArtefactID=None):
        settings = ViewSettings(layoutID)
        settings.flags = ViewFlags.LOBBY_SUB_VIEW
        settings.model = RewardPathViewModel()
        super(RewardPathView, self).__init__(settings)
        self.__bonusCache = {}
        self.__idGen = SequenceIDGenerator()
        self.__selectedArtefactID = selectedArtefactID

    @property
    def viewModel(self):
        return super(RewardPathView, self).getViewModel()

    def createToolTip(self, event):
        if event.contentID == _R_BACKPORT_TOOLTIP:
            tooltipId = event.getArgument('tooltipId')
            bonus = self.__bonusCache.get(tooltipId)
            if bonus:
                window = BackportTooltipWindow(createTooltipData(tooltip=bonus.tooltip, isSpecial=bonus.isSpecial, specialAlias=bonus.specialAlias, specialArgs=bonus.specialArgs, isWulfTooltip=bonus.isWulfTooltip), self.getParentWindow(), event=event)
                window.load()
                return window
        return super(RewardPathView, self).createToolTip(event)

    def createToolTipContent(self, event, contentID):
        if contentID == R.views.halloween.lobby.tooltips.EventMissionTooltip():
            artefactID = event.getArgument('artefactID', '')
            return EventMissionsTooltip(selectedArtefactID=artefactID, isHangar=False)
        return super(RewardPathView, self).createToolTipContent(event, contentID)

    def _getEvents(self):
        return [
         (
          self.viewModel.onPreview, self.__onPreview),
         (
          self.viewModel.onViewLoaded, self.__onViewLoaded),
         (
          self.viewModel.onClose, self.__onClose),
         (
          self.viewModel.onShowIntro, self.__onShowIntro),
         (
          self.viewModel.onAbout, self.__onAbout),
         (
          self.viewModel.goToMission, self.__goToMission)]

    def _onLoading(self, *args, **kwargs):
        super(RewardPathView, self)._onLoading()
        self.suspendLobbyHeader(self.uniqueID)
        self.setChildView(resourceID=R.views.halloween.lobby.widgets.KeysView(), view=KeysView())
        self.__fillGiftVehicle()
        self.__fillArtefacts()

    def _onLoaded(self, *args, **kwargs):
        super(RewardPathView, self)._onLoaded(*args, **kwargs)
        if g_currentPreviewVehicle is not None:
            g_currentPreviewVehicle.selectNoVehicle()
        return

    def _initialize(self):
        super(RewardPathView, self)._initialize()
        playSound(REWARD_PATH_ENTER)
        showMetaIntroView(forceOpen=False, parent=self.getParentWindow())

    def _finalize(self):
        self.resumeLobbyHeader(self.uniqueID)
        playSound(REWARD_PATH_EXIT)
        super(RewardPathView, self)._finalize()

    def __onShowIntro(self):
        showIntroVideo()

    def __onAbout(self):
        showMetaIntroView()

    def __goToMission(self, args):
        artefactID = args.get('artefactID', None)
        if artefactID is not None:
            showHangar(artefactID=artefactID)
        return

    def __fillArtefacts(self):
        with self.viewModel.transaction() as (tx):
            artefacts = tx.getArtefacts()
            if self.__selectedArtefactID is not None:
                tx.setSelectedArtefactID(self.__selectedArtefactID)
            currentProgress = self._hwArtefactsCtrl.getCurrentArtefactProgress()
            maxProgress = self._hwArtefactsCtrl.getMaxArtefactsProgress()
            tx.setIsCompleted(currentProgress >= maxProgress)
            tx.setProgress(maxProgress - currentProgress)
            self.__bonusCache = {}
            for artefact in self._hwArtefactsCtrl.artefactsSorted():
                artefactVM = RewardPathItemViewModel()
                artefactVM.setId(artefact.artefactID)
                artefactVM.setIndex(self._hwArtefactsCtrl.getIndex(artefact.artefactID))
                artefactVM.setState(getArtefactState(artefact.artefactID))
                artefactVM.getTypes().clear()
                for type in artefact.artefactTypes:
                    artefactVM.getTypes().addString(type)

                artefactVM.getRewards().clear()
                self.__bonusCache.update(fillRewards(artefact, artefactVM.getRewards(), self._MAX_BONUSES_IN_VIEW, self.__idGen, skipBonuses=[
                 'slots']))
                artefacts.addViewModel(artefactVM)

            artefacts.invalidate()
        return

    def __fillGiftVehicle(self):
        vehicle = self._hwArtefactsCtrl.getMainGiftVehicle()
        if vehicle is not None:
            with self.viewModel.transaction() as (tx):
                vehGift = tx.mainGiftVehicle
                vehGift.setName(vehicle.userName)
                vehGift.setLevel(int2roman(vehicle.level))
                vehGift.setNation(vehicle.nationName)
                vehGift.setIsPremium(vehicle.isPremium)
                vehGift.setVehicleType(VehicleTypes(vehicle.type) if vehicle.type != '' else VehicleTypes.NONE)
        return

    def __showRewardPathViewCb(self):
        showRewardPathView(selectedArtefactID=self.__selectedArtefactID)

    def __onPreview(self):
        vehicle = self._hwArtefactsCtrl.getMainGiftVehicle()
        if vehicle is not None:
            if not vehicle.isInInventory:
                style = self._hwArtefactsCtrl.getMainGiftStyle()
                showVehiclePreview(itemCD=vehicle.intCD, previewBackCb=self.__showRewardPathViewCb, backBtnLabel=backport.text(R.strings.halloween_lobby.common.toRewardPath()), outfit=style.getOutfit(first(style.seasons), vehicleCD=vehicle.descriptor.makeCompactDescr()) if style else None, isKingReward=True)
            else:
                selectVehicleInHangarWithFade(vehicle.intCD)
        return

    def __onClose(self):
        showHangar(artefactID=self.__selectedArtefactID)

    def __onViewLoaded(self):
        g_eventBus.handleEvent(events.ViewReadyEvent(self.layoutID))