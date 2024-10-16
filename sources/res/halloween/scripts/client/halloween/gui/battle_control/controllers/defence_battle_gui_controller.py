import typing
from Event import Event
from halloween.gui.battle_control.controllers.battle_gui_controller import HWBattleGUIController
from HWArenaPhasesComponent import HWArenaPhasesComponent

class EventDefenceBattleGoal(object):
    UNKNOWN = None
    DESTROY_ENEMIES = 'halloween.destroyEnemies'
    WAVE_FINISHED = 'halloween.defenceWaveFinished'
    LAST_WAVE_FINISHED = 'halloween.defenceLastWaveFinished'


class HWDefenceBattleGUIController(HWBattleGUIController):

    def __init__(self):
        super(HWDefenceBattleGUIController, self).__init__()
        self.onEnemiesInfoChanged = Event(self._eManager)
        self.onHealthBreakpointsChanged = Event(self._eManager)
        self.onEnemiesStatusChanged = Event(self._eManager)
        self._enemiesInfo = {}
        self._healthBreakpoints = []
        self._enemiesStatus = []

    def getEnemiesInfo(self):
        return self._enemiesInfo

    def _onPhaseTimeChanged(self, timeLeft, prev, lastPhase):
        pass

    def _getRelevantGoal(self):
        if not self._getAliveAllyVehicles() or self._enemiesInfo.get('totalEnemies', 0) <= 0:
            return EventDefenceBattleGoal.UNKNOWN
        if self._enemiesInfo.get('aliveEnemies', 0):
            return EventDefenceBattleGoal.DESTROY_ENEMIES
        component = HWArenaPhasesComponent.getInstance()
        if component and component.isLastPhase():
            return EventDefenceBattleGoal.LAST_WAVE_FINISHED
        return EventDefenceBattleGoal.WAVE_FINISHED

    def _getHintParams(self):
        return {'num': self._enemiesInfo.get('aliveEnemies', 0)}

    def updateEnemiesInfo(self, enemiesInfo):
        self._enemiesInfo = enemiesInfo
        self.onEnemiesInfoChanged(self._enemiesInfo)

    def updateHealthBreakpoints(self, healthBreakpoints):
        self._healthBreakpoints = []
        if self._enemiesInfo.get('totalHealth', 0) > 0:
            self._healthBreakpoints = [ round(float(value) / self._enemiesInfo['totalHealth'], 2) for value in healthBreakpoints ]
        self.onHealthBreakpointsChanged(self._healthBreakpoints)

    def updateEnemiesStatus(self, enemiesStatus):
        self._enemiesStatus = enemiesStatus
        self.onEnemiesStatusChanged(self._enemiesStatus)