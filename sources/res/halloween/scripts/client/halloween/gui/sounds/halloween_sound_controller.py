import BattleReplay, SoundGroups, WWISE
from constants import CURRENT_REALM, IS_CHINA
from frameworks.wulf import WindowStatus
from gui.prb_control.entities.listener import IGlobalListener
from gui.Scaleform.daapi.view.lobby.hangar.Hangar import Hangar
from halloween.gui.halloween_gui_constants import VIEW_ALIAS
from halloween.gui.sounds import playSound
from halloween.skeletons.halloween_sound_controller import IHalloweenSoundController
from halloween.skeletons.halloween_controller import IHalloweenController
from halloween.gui.sounds.sound_constants import SoundLanguage, HW_ENTER_EVENT, HW_EXIT_EVENT, META_PREVIEW_EXIT
from helpers import dependency
from skeletons.gui.impl import IGuiLoader

class _StatusUpdateOperation(object):

    def execute(self):
        pass


class _StatusUpdateEvent(_StatusUpdateOperation):

    def __init__(self, event):
        self._event = event

    def execute(self):
        playSound(self._event)


class _StatusUpdateState(_StatusUpdateOperation):

    def __init__(self, group, value):
        self._group = group
        self._value = value

    def execute(self):
        WWISE.WW_setState(self._group, self._value)


_SOUNDS_WINDOW_STATUS_UPDATE = {(VIEW_ALIAS.VEHICLE_PREVIEW, WindowStatus.DESTROYING): _StatusUpdateEvent(META_PREVIEW_EXIT), 
   (VIEW_ALIAS.VEH_POST_PROGRESSION, WindowStatus.DESTROYING): _StatusUpdateState(Hangar.SOUND_STATE_PLACE, Hangar.SOUND_STATE_PLACE_GARAGE)}

class HalloweenSoundController(IHalloweenSoundController, IGlobalListener):
    _guiLoader = dependency.descriptor(IGuiLoader)
    _hwController = dependency.descriptor(IHalloweenController)

    def __init__(self, *args, **kwargs):
        super(HalloweenSoundController, self).__init__(*args, **kwargs)
        self._hangarEnterEventPlayed = False

    def onAvatarBecomePlayer(self):
        if BattleReplay.g_replayCtrl.isPlaying:
            self.__setEventVoiceoverLanguage()

    def onLobbyInited(self, event):
        self.startGlobalListening()
        self._guiLoader.windowsManager.onWindowStatusChanged += self.__onWindowStatusChanged
        if self._hwController.isEventHangar():
            self._playEnter()

    def onAccountBecomeNonPlayer(self):
        self.stopGlobalListening()
        self._guiLoader.windowsManager.onWindowStatusChanged -= self.__onWindowStatusChanged

    def onConnected(self):
        self.__setEventVoiceoverLanguage()

    def __setEventVoiceoverLanguage(self):
        if IS_CHINA:
            SoundGroups.g_instance.setSwitch(SoundLanguage.VOICEOVER_LOCALIZATION_SWITCH, SoundLanguage.VOICEOVER_CN)
        elif CURRENT_REALM in SoundLanguage.RU_VOICEOVER_REALM_CODES:
            SoundGroups.g_instance.setSwitch(SoundLanguage.VOICEOVER_LOCALIZATION_SWITCH, SoundLanguage.VOICEOVER_RU)
        else:
            SoundGroups.g_instance.setSwitch(SoundLanguage.VOICEOVER_LOCALIZATION_SWITCH, SoundLanguage.VOICEOVER_EN)

    def onPrbEntitySwitched(self):
        if self._hwController.isEventHangar():
            self._playEnter()
        else:
            self._playExit()

    def _playEnter(self):
        if not self._hangarEnterEventPlayed:
            self._hangarEnterEventPlayed = True
            playSound(HW_ENTER_EVENT)

    def _playExit(self):
        if self._hangarEnterEventPlayed:
            self._hangarEnterEventPlayed = False
            playSound(HW_EXIT_EVENT)

    def __onWindowStatusChanged(self, uniqueID, newStatus):
        window = self._guiLoader.windowsManager.getWindow(uniqueID)
        if not self._hwController.isEventHangar() or window is None or window.content is None:
            return
        content = window.content
        aliasOrLayoutID = getattr(content, 'alias') if hasattr(content, 'alias') else getattr(content, 'layoutID')
        sound = _SOUNDS_WINDOW_STATUS_UPDATE.get((aliasOrLayoutID, newStatus))
        if sound:
            sound.execute()
        return