from enum import IntEnum
from gui.Scaleform.daapi.view.meta.EventTimerMeta import EventTimerMeta
from helpers import dependency
from skeletons.gui.battle_session import IBattleSessionProvider
from HWArenaPhasesComponent import HWArenaPhasesComponent

class _AlarmTime(IntEnum):
    FIRST = 60
    SECOND = 30
    LAST = 10


class _AlertState(IntEnum):
    DISABLED = 0
    ENABLED = 1


class EventTimer(EventTimerMeta):
    sessionProvider = dependency.descriptor(IBattleSessionProvider)
    _COLOR = '#ffffff'
    _HTML_TEMPLATE_PATH = 'html_templates:battleTimer'
    _ALERT_STATE_ENABLED = 1
    _ALERT_STATE_DISABLED = 0
    _ONE_MINUTE_SECONDS = 60

    def __init__(self):
        super(EventTimer, self).__init__()
        self._visible = False
        self._currentHint = None
        return

    def _populate(self):
        super(EventTimer, self)._populate()
        HWArenaPhasesComponent.onPhaseTimeChanged += self._onTimerUpdated

    def _dispose(self):
        self._visible = False
        HWArenaPhasesComponent.onPhaseTimeChanged -= self._onTimerUpdated
        super(EventTimer, self)._dispose()

    def _onTimerUpdated(self, seconds, prev, lastPhase):
        self._visible = seconds > 0
        if not self._visible:
            self._hideTimer()
            return
        m, s = divmod(int(seconds), self._ONE_MINUTE_SECONDS)
        timeString = ('<font color="{color}">{min:02d}:{sec:02d}</font>').format(color=self._COLOR, min=m, sec=s)
        if seconds == _AlarmTime.FIRST or seconds == _AlarmTime.SECOND or seconds <= _AlarmTime.LAST:
            self.as_playFxS()
        needAlarm = seconds <= _AlarmTime.FIRST
        timerState = _AlertState.ENABLED if needAlarm else _AlertState.DISABLED
        self.as_setTimerStateS(timerState.value)
        self.as_updateTimeS(timeString)

    def _hideTimer(self):
        self.as_updateTimeS('')
        self.as_updateTitleS('')