import typing
from frameworks.wulf import ViewSettings, WindowFlags
from gui.impl.backport import createTooltipData, BackportTooltipWindow
from gui.impl.gen import R
from gui.impl.pub import ViewImpl
from gui.impl.pub.lobby_window import LobbyNotificationWindow
from gui.shared import g_eventBus, events
from halloween.gui import halloween_account_settings
from halloween.gui.halloween_account_settings import AccountSettingsKeys
from halloween.gui.impl.gen.view_models.views.lobby.decrypt_view_model import DecryptViewModel
from halloween.gui.impl.lobby import fillRewards
from halloween.gui.sounds import playSound
from halloween.gui.sounds.sound_constants import META_VOICEOVER_UNMUTE, META_VOICEOVER_BUTTON_CLICK_UNMUTE, META_VOICEOVER_MUTE, META_VOICEOVER_BUTTON_CLICK_MUTE, META_QUANTUM_OPEN_SOUND, META_QUANTUM_CLOSE_SOUND
from halloween.skeletons.halloween_artefacts_controller import IHalloweenArtefactsController
from halloween.skeletons.halloween_controller import IHalloweenController
from helpers import dependency
from ids_generators import SequenceIDGenerator
from skeletons.gui.impl import IGuiLoader
if typing.TYPE_CHECKING:
    from halloween.gui.game_control.halloween_artefacts_controller import Artefact
_R_BACKPORT_TOOLTIP = R.views.common.tooltip_window.backport_tooltip_content.BackportTooltipContent()

class DecryptView(ViewImpl):
    _guiLoader = dependency.descriptor(IGuiLoader)
    _hwArtefactsCtrl = dependency.descriptor(IHalloweenArtefactsController)
    _hwController = dependency.descriptor(IHalloweenController)
    _MAX_BONUSES_IN_VIEW = 5

    def __init__(self, artefactID, isRewardScreen=False):
        settings = ViewSettings(R.views.halloween.lobby.DecryptView())
        settings.model = DecryptViewModel()
        super(DecryptView, self).__init__(settings)
        self.__artefactID = artefactID
        self.__isRewardScreen = isRewardScreen
        self.__bonusCache = {}
        self.__idGen = SequenceIDGenerator()

    def createToolTip(self, event):
        if event.contentID == _R_BACKPORT_TOOLTIP:
            tooltipId = event.getArgument('tooltipId')
            bonus = self.__bonusCache.get(tooltipId)
            if bonus:
                window = BackportTooltipWindow(createTooltipData(tooltip=bonus.tooltip, isSpecial=bonus.isSpecial, specialAlias=bonus.specialAlias, specialArgs=bonus.specialArgs, isWulfTooltip=bonus.isWulfTooltip), self.getParentWindow(), event=event)
                window.load()
                return window
        return super(DecryptView, self).createToolTip(event)

    @property
    def viewModel(self):
        return super(DecryptView, self).getViewModel()

    def _onLoading(self, *args, **kwargs):
        super(DecryptView, self)._onLoading()
        self.__fillViewModel()
        playSound(META_QUANTUM_OPEN_SOUND.format(self._hwArtefactsCtrl.getIndex(self.__artefactID)))

    def _onShown(self):
        g_eventBus.handleEvent(events.ViewReadyEvent(self.layoutID))

    def _finalize(self):
        if self.__isRewardScreen:
            hangarView = self._guiLoader.windowsManager.getViewByLayoutID(R.views.halloween.lobby.HangarView())
            if hangarView is not None:
                hangarView.selectNextSlide()
        playSound(META_QUANTUM_CLOSE_SOUND.format(self._hwArtefactsCtrl.getIndex(self.__artefactID)))
        super(DecryptView, self)._finalize()
        return

    def _getEvents(self):
        return [
         (
          self.viewModel.onAffirmation, self.__onClose),
         (
          self.viewModel.onMuted, self.__onMuted)]

    def __onClose(self):
        self.destroyWindow()

    def __onMuted(self):
        isMuted = halloween_account_settings.getSettings(AccountSettingsKeys.ARTEFACT_VOICEOVER_MUTED)
        newStateMute = not isMuted
        halloween_account_settings.setSettings(AccountSettingsKeys.ARTEFACT_VOICEOVER_MUTED, newStateMute)
        self.viewModel.setIsMuted(newStateMute)
        if newStateMute:
            playSound(META_VOICEOVER_MUTE)
            playSound(META_VOICEOVER_BUTTON_CLICK_MUTE)
        else:
            playSound(META_VOICEOVER_UNMUTE)
            playSound(META_VOICEOVER_BUTTON_CLICK_UNMUTE)

    def __fillViewModel(self):
        artefact = self._hwArtefactsCtrl.getArtefact(self.__artefactID)
        if artefact is None:
            return
        else:
            with self.viewModel.transaction() as (tx):
                tx.setId(self.__artefactID)
                tx.setName(artefact.questConditions.name)
                tx.setIndex(self._hwArtefactsCtrl.getIndex(self.__artefactID))
                isMuted = halloween_account_settings.getSettings(AccountSettingsKeys.ARTEFACT_VOICEOVER_MUTED)
                tx.setIsMuted(isMuted)
                if isMuted:
                    playSound(META_VOICEOVER_MUTE)
                else:
                    playSound(META_VOICEOVER_UNMUTE)
                self.__bonusCache = fillRewards(artefact, tx.getRewards(), self._MAX_BONUSES_IN_VIEW, self.__idGen)
                for type in artefact.artefactTypes:
                    tx.getTypes().addString(type)

                tx.getTypes().invalidate()
            return


class DecryptWindow(LobbyNotificationWindow):

    def __init__(self, artefactID, isRewardScreen=None, parent=None):
        super(DecryptWindow, self).__init__(wndFlags=WindowFlags.WINDOW_FULLSCREEN | WindowFlags.WINDOW, content=DecryptView(artefactID, isRewardScreen), parent=parent)
        self._args = (
         artefactID, isRewardScreen)

    def isParamsEqual(self, *args):
        return self._args == args