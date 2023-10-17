import BigWorld
from helpers import isPlayerAvatar
from script_component.DynamicScriptComponent import DynamicScriptComponent
import Event, logging
from helpers.CallbackDelayer import CallbackDelayer
from helpers.EffectsList import effectsFromSection, EffectsListPlayer
from helpers import newFakeModel
from halloween_dyn_object_cache import HWEffects, getEffectSection
from halloween_common.halloween_constants import INVALID_PHASE
_logger = logging.getLogger(__name__)

class HWEnvironmentSwitcher(object):

    def __init__(self):
        self._isSwitchInProcess = False
        self._callbackDelayer = CallbackDelayer()
        self._fakeModel = None
        self._effectsPlayer = None
        section = getEffectSection(HWEffects.PHASE_SWITCH)
        self._effects = effectsFromSection(section)
        self._envSwitchDelay = section['envSwitchDelay'].asFloat
        return

    def onDestroy(self):
        self._effects = None
        self._callbackDelayer.destroy()
        self._cancelOngoingSwitcher()
        return

    def setupEnvironment(self, envName, isInstantSwitch=False):
        self._cancelOngoingSwitcher()
        if isInstantSwitch or self._effects is None:
            self._switchEnvironment(envName)
            return
        else:
            self._fakeModel = newFakeModel()
            BigWorld.player().addModel(self._fakeModel)
            self._effectsPlayer = EffectsListPlayer(self._effects.effectsList, self._effects.keyPoints, debugParent=self)
            self._effectsPlayer.play(self._fakeModel, callbackFunc=self._cancelOngoingSwitcher)
            self._callbackDelayer.delayCallback(self._envSwitchDelay, self._switchEnvironment, envName)
            return

    def _cancelOngoingSwitcher(self):
        self._callbackDelayer.clearCallbacks()
        if self._effectsPlayer:
            self._effectsPlayer.stop()
            self._effectsPlayer = None
        if self._fakeModel:
            BigWorld.player().delModel(self._fakeModel)
            self._fakeModel = None
        return

    def _switchEnvironment(self, envName):
        BigWorld.EnvironmentSwitcher(envName).enable(True)


class HWArenaPhasesComponent(DynamicScriptComponent):
    onPhaseChanged = Event.Event()
    onPhaseTimeChanged = Event.Event()
    onHideVehicleOnMinimap = Event.Event()

    def __init__(self):
        super(HWArenaPhasesComponent, self).__init__()
        self.envSwitcher = None
        return

    def onDestroy(self):
        if self.envSwitcher:
            self.envSwitcher.onDestroy()
            self.envSwitcher = None
        self.onPhaseChanged.clear()
        self.onPhaseTimeChanged.clear()
        super(HWArenaPhasesComponent, self).onDestroy()
        return

    def _onAvatarReady(self):
        if self.phasesCount:
            self.onPhaseChanged(self)
            lastPhase = self.activePhase == self.phasesCount
            self.onPhaseTimeChanged(self.timeLeft, self.timeLeft, lastPhase)
        self.envSwitcher = HWEnvironmentSwitcher()
        self._setupEnvironment(True)

    def set_activePhase(self, prev):
        _logger.info('HWArenaPhasesComponent set activePhase=%s', self.activePhase)
        if prev != self.activePhase:
            self.onPhaseChanged(self)

    def set_timeLeft(self, prev):
        lastPhase = self.activePhase == self.phasesCount
        self.onPhaseTimeChanged(self.timeLeft, prev, lastPhase)

    def set_activeEnvironment(self, prev):
        if not self._isAvatarReady:
            return
        self._setupEnvironment()

    def _setupEnvironment(self, isInstant=False):
        if self.envSwitcher is None or not self.activeEnvironment:
            return
        self.envSwitcher.setupEnvironment(self.activeEnvironment, isInstant)
        return

    def hideVehicleOnMinimap(self, vehicleID):
        self.onHideVehicleOnMinimap(vehicleID)

    def isLastPhase(self):
        return self.activePhase == self.phasesCount and self.activePhase != INVALID_PHASE

    @staticmethod
    def getInstance():
        if not isPlayerAvatar():
            return
        else:
            player = BigWorld.player()
            if not player:
                return
            if not player.arena or not player.arena.arenaInfo:
                return
            return getattr(player.arena.arenaInfo, 'HWArenaPhasesComponent', None)