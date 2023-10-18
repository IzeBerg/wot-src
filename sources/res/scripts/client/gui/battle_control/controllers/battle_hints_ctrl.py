import time, logging
from collections import namedtuple
import BigWorld, SoundGroups, constants, BattleReplay
from gui.battle_control.view_components import ViewComponentsController
from gui.battle_control.battle_constants import BATTLE_CTRL_ID
from gui.shared import battle_hints
from shared_utils import findFirst
_logger = logging.getLogger(__name__)
HintRequest = namedtuple('HintRequest', ('hint', 'data', 'requestTime', 'component'))

class BattleHintsQueue(object):

    def __init__(self, hintMinShowTime=0.0):
        super(BattleHintsQueue, self).__init__()
        self.__currentHint = None
        self.__currentHintComponent = None
        self.__hintStartTime = 0
        self.__hintRequests = []
        self.__hideCallback = None
        self.__hintMinShowTime = hintMinShowTime
        return

    def clear(self):
        self.__cancelHintCallback()
        self.__currentHint = None
        self.__currentHintComponent = None
        self.__hintStartTime = 0
        self.__hintRequests = []
        self.__hideCallback = None
        return

    def showHint(self, hint, data, component):
        currentHint = self.__currentHint
        if currentHint:
            requestTime = time.time()
            self.__hintRequests.append(HintRequest(hint, data, requestTime, component))
            if hint.priority > currentHint.priority:
                showTimeLeft = self.__hintMinShowTime - (time.time() - self.__hintStartTime)
                if showTimeLeft <= 0:
                    self.__hideCurrentHint()
                else:
                    self.__cancelHintCallback()
                    self.__hideCallback = BigWorld.callback(showTimeLeft, self.__hideCurrentHint)
        else:
            self.__showHint(hint, data, component)

    def hideHint(self, hint=None):
        if hint is None or self.__currentHint == hint:
            self.__hideCurrentHint()
        else:
            _logger.debug('Failed to hide hint name=%s', hint.name)
        return

    def removeHintFromQueue(self, hint):
        if not self.__hintRequests:
            return
        self.__hintRequests = [ hr for hr in self.__hintRequests if hr.hint != hint ]

    def __showHint(self, hint, data, component):
        _logger.debug('Show battle hint hintName=%s, priority=%d', hint.name, hint.priority)
        component.playSoundFx(hint)
        component.playSoundNotifications(hint, data)
        component.showHint(hint, data)
        self.__currentHintComponent = component
        self.__currentHint = hint
        self.__hintStartTime = time.time()
        duration = hint.duration
        if duration is not None:
            self.__cancelHintCallback()
            self.__hideCallback = BigWorld.callback(duration, self.__hideCurrentHint)
        return

    def __hideCurrentHint(self):
        self.__cancelHintCallback()
        self.__currentHintComponent.hideHint()
        self.__currentHintComponent = None
        self.__currentHint = None
        self.__showDelayedHint()
        return

    def __cancelHintCallback(self):
        if self.__hideCallback is not None:
            BigWorld.cancelCallback(self.__hideCallback)
            self.__hideCallback = None
        return

    def __showDelayedHint(self):
        currentTime = time.time()
        self.__hintRequests = [ r for r in self.__hintRequests if currentTime - r.requestTime < r.hint.maxWaitTime ]
        delayedHints = self.__hintRequests
        if not delayedHints:
            return
        maxPriorityHint = max(delayedHints, key=lambda r: r.hint.priority)
        delayedHints.remove(maxPriorityHint)
        self.__showHint(maxPriorityHint.hint, maxPriorityHint.data, maxPriorityHint.component)


class BattleHintComponent(object):

    def showHint(self, hint, data):
        self._showHint(hint, data)

    def hideHint(self):
        self._hideHint()

    def playSoundFx(self, hint):
        soundFX = self._getSoundFx(hint)
        if soundFX is not None:
            SoundGroups.g_instance.playSound2D(soundFX)
        return

    def playSoundNotifications(self, hint, data):
        sound = self._getSoundNotification(hint, data)
        if sound is None:
            return
        else:
            player = BigWorld.player()
            if player is None:
                return
            if hasattr(player, 'soundNotifications') and player.soundNotifications is not None:
                player.soundNotifications.play(sound)
            return

    def _getSoundNotification(self, hint, data):
        return hint.soundNotification

    def _getSoundFx(self, hint):
        return hint.soundFx

    def _showHint(self, hint, data):
        raise NotImplementedError

    def _hideHint(self):
        raise NotImplementedError


class BattleHintsController(ViewComponentsController):
    _DEFAULT_HINT_NAME = 'default'
    _HINT_MIN_SHOW_TIME = 2.0

    def __init__(self, hintsData):
        super(BattleHintsController, self).__init__()
        self.__hintsData = {hint.name:hint for hint in hintsData}
        self._hintsQueue = BattleHintsQueue(self._HINT_MIN_SHOW_TIME)

    def getControllerID(self):
        return BATTLE_CTRL_ID.BATTLE_HINTS

    def startControl(self, *args):
        pass

    def stopControl(self):
        self._hintsQueue.clear()

    def showHint(self, hintName, data=None):
        if BattleReplay.g_replayCtrl.isTimeWarpInProgress:
            return
        component, hint = self.__getComponentAndHint(hintName)
        if hint and component:
            _logger.debug('Request battle hint hintName=%s, priority=%d', hint.name, hint.priority)
            self._hintsQueue.showHint(hint, data, component)
        else:
            _logger.error('Failed to show hint name=%s', hintName)

    def hideHint(self, hintName):
        component, hint = self.__getComponentAndHint(hintName)
        if hint and component:
            self._hintsQueue.hideHint(hint)
        else:
            _logger.error('Failed to hide hint name=%s', hintName)

    def removeHintFromQueue(self, hintName):
        component, hint = self.__getComponentAndHint(hintName)
        if hint and component:
            self._hintsQueue.removeHintFromQueue(hint)
        else:
            _logger.error('Failed to remove hint from queue=%s', hintName)

    def __getComponentAndHint(self, hintName):
        component = None
        hint = self.__hintsData.get(hintName)
        if hint is None and constants.IS_DEVELOPMENT:
            hint = self.__hintsData.get(self._DEFAULT_HINT_NAME)
            hint = hint._replace(rawMessage=hintName)
        if hint:
            alias = hint.componentAlias
            component = findFirst(lambda comp: comp.getAlias() == alias, self._viewComponents)
            if not component:
                _logger.error('Unknown component alias=%s', alias)
        else:
            _logger.error('Unknown hint name=%s', hintName)
        return (component, hint)


def createBattleHintsController():
    return BattleHintsController(battle_hints.makeHintsData())