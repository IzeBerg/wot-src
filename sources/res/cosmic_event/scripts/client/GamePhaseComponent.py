from typing import TYPE_CHECKING
import BigWorld
from script_component.DynamicScriptComponent import DynamicScriptComponent
from gui.shared import g_eventBus, EVENT_BUS_SCOPE
from cosmic_event.gui.shared.events import ProgressBarEvent
if TYPE_CHECKING:
    from typing import Optional
    from gui.shared.events import HasCtxEvent

class GamePhaseComponent(DynamicScriptComponent):

    def _onAvatarReady(self):
        self._sendEvent(ProgressBarEvent.PHASE_COUNT_CHANGED, {'phaseCount': self.phaseCount})
        self._sendEvent(ProgressBarEvent.PHASE_CHANGED, self._getCreatedCtx())

    def set_phaseStartTime(self, _):
        self._sendEvent(ProgressBarEvent.PHASE_CHANGED, self._getCreatedCtx())

    def set_phaseCount(self, _):
        self._sendEvent(ProgressBarEvent.PHASE_COUNT_CHANGED, {'phaseCount': self.phaseCount})

    @property
    def phaseTimeLeft(self):
        timeLeft = self.phaseDuration - (int(BigWorld.serverTime()) - self.phaseStartTime)
        if not timeLeft < 0:
            return timeLeft
        return 0

    @staticmethod
    def _sendEvent(event, ctx):
        g_eventBus.handleEvent(ProgressBarEvent(event, ctx=ctx or {}), scope=EVENT_BUS_SCOPE.BATTLE)

    def _getCreatedCtx(self):
        return {'phaseIdx': self.phaseIdx, 
           'phaseType': self.phaseType, 
           'phaseDuration': self.phaseDuration, 
           'phaseTimeLeft': self.phaseTimeLeft, 
           'previousPhaseType': self.previousPhaseType}