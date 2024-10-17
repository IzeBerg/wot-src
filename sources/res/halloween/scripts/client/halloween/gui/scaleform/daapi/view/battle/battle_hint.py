import copy, BattleReplay, typing
from halloween.gui.halloween_gui_constants import BATTLE_CTRL_ID, HALLOWEEN_BATTLE_HINTS_QUEUE_ID
from halloween.gui.scaleform.daapi.view.meta.BattleHintMeta import BattleHintMeta
from halloween.gui.scaleform.daapi.view.meta.BattleHintProgressMeta import BattleHintProgressMeta
from halloween.gui.scaleform.daapi.view.meta.BattleHintProgressDefenceMeta import BattleHintProgressDefenceMeta
from gui.battle_control.controllers.battle_hints.component import BattleHintComponent
from helpers import dependency
from skeletons.gui.battle_session import IBattleSessionProvider

class BattleHint(BattleHintComponent, BattleHintMeta):
    guiSessionProvider = dependency.descriptor(IBattleSessionProvider)

    def __init__(self):
        super(BattleHint, self).__init__(battleHintsQueueParams=HALLOWEEN_BATTLE_HINTS_QUEUE_ID)

    @property
    def hwBattleGuiCtrl(self):
        return self.guiSessionProvider.dynamic.getControllerByID(BATTLE_CTRL_ID.HW_BATTLE_GUI_CTRL)

    def _populate(self):
        super(BattleHint, self)._populate()
        if self.hwBattleGuiCtrl:
            self.hwBattleGuiCtrl.onBattleGoalChanged += self._onBattleGoalChanged

    def _dispose(self):
        super(BattleHint, self)._dispose()
        if self.hwBattleGuiCtrl:
            self.hwBattleGuiCtrl.onBattleGoalChanged -= self._onBattleGoalChanged
        if BattleReplay.g_replayCtrl.isPlaying:
            self._hideHint()

    def _showHint(self, model, params):
        vo = model.createVO(params)
        if vo:
            self.as_showHintS(vo)

    def _hideHint(self):
        self.as_hideHintS()

    def _cancelFadeOut(self):
        self.as_cancelFadeOutS()

    def _onBattleGoalChanged(self, goalName):
        self.as_clearPinnableHintS()


class ProgressBarBattleHint(BattleHint, BattleHintProgressMeta):

    def _populate(self):
        super(ProgressBarBattleHint, self)._populate()
        if self.hwBattleGuiCtrl:
            self.hwBattleGuiCtrl.onSoulCollectorProgress += self._onCollectorSoulsChanged

    def _dispose(self):
        if self.hwBattleGuiCtrl:
            self.hwBattleGuiCtrl.onSoulCollectorProgress -= self._onCollectorSoulsChanged
        super(ProgressBarBattleHint, self)._dispose()

    def _hideHint(self):
        super(ProgressBarBattleHint, self)._hideHint()
        self._updateProgressBar()

    def _normalizeSoulsLeft(self, soulsLeft, maxSoulsCount):
        if maxSoulsCount > 0:
            return round(maxSoulsCount - soulsLeft) / float(maxSoulsCount) * 100
        return 0

    def _getCollectorSoulsAndCapacity(self):
        if self.hwBattleGuiCtrl:
            souls, capacity = self.hwBattleGuiCtrl.getCurrentCollectorSoulsInfo()
            if souls is not None and capacity is not None:
                return (souls, capacity)
        return (0, 0)

    def _updateProgressBar(self):
        souls, capacity = self._getCollectorSoulsAndCapacity()
        soulsLeft = max(0, capacity - souls)
        normalizedSoulsLeft = self._normalizeSoulsLeft(soulsLeft, capacity)
        self.as_updateProgressS(soulsLeft, normalizedSoulsLeft)

    def _onCollectorSoulsChanged(self, *args):
        self._updateProgressBar()


class DefenceProgressBarBattleHint(BattleHint, BattleHintProgressDefenceMeta):
    DEAD_ENEMY_STATUS_POSTFIX = '_dead'
    DEFAULT_ENEMY_STATUS = {'role': 'unknown', 'isDead': False}
    STATUS_SORTING_ORDER = ['boss', 'alpha', 'charger', 'heavyTank', 'hunter', 'mediumTank', 'sentry', 'turret',
     'AT-SPG', 'bomber_alpha', 'bomber', 'catcher', 'runner', 'lightTank', 'SPG', 'unknown']

    def _populate(self):
        super(DefenceProgressBarBattleHint, self)._populate()
        if self.hwBattleGuiCtrl:
            self.hwBattleGuiCtrl.onEnemiesInfoChanged += self._onEnemiesInfoChanged
            self.hwBattleGuiCtrl.onHealthBreakpointsChanged += self._onHealthBreakpointsChanged
            self.hwBattleGuiCtrl.onEnemiesStatusChanged += self._onEnemiesStatusChanged

    def _dispose(self):
        if self.hwBattleGuiCtrl:
            self.hwBattleGuiCtrl.onEnemiesInfoChanged -= self._onEnemiesInfoChanged
            self.hwBattleGuiCtrl.onHealthBreakpointsChanged -= self._onHealthBreakpointsChanged
            self.hwBattleGuiCtrl.onEnemiesStatusChanged -= self._onEnemiesStatusChanged
        super(DefenceProgressBarBattleHint, self)._dispose()

    def _hideHint(self):
        super(DefenceProgressBarBattleHint, self)._hideHint()
        self._updateProgressBar(self._getEnemiesInfo())

    def _normalizeProgressValue(self, currentValue, maxValue):
        if maxValue > 0:
            return round(float(maxValue - currentValue) / float(maxValue), 2) * 100
        return 0

    def _getEnemiesInfo(self):
        if self.hwBattleGuiCtrl:
            return self.hwBattleGuiCtrl.getEnemiesInfo()
        return {}

    def _updateProgressBar(self, enemiesInfo):
        enemiesAlive = enemiesInfo.get('aliveEnemies', 0)
        currentHealth = enemiesInfo.get('currentHealth', 0)
        totalHealth = enemiesInfo.get('totalHealth', 0)
        lostHealth = max(0, totalHealth - currentHealth)
        normalizedProgressValue = self._normalizeProgressValue(lostHealth, totalHealth)
        self.as_updateProgressS(enemiesAlive, normalizedProgressValue, currentHealth)

    def _onEnemiesInfoChanged(self, enemiesInfo):
        self._updateProgressBar(enemiesInfo)

    def _onHealthBreakpointsChanged(self, healthBreakpoints):
        self.as_updateHealthPointsS(healthBreakpoints)

    def _onEnemiesStatusChanged(self, enemiesStatus):
        enemiesStatusList = self._formatEnemiesStatus(enemiesStatus)
        self.as_updateVehiclesS(enemiesStatusList)

    def _formatEnemiesStatus(self, enemiesStatus):
        enemiesStatusFull = copy.deepcopy(enemiesStatus)
        missingStatusCount = self._getEnemiesInfo().get('totalEnemies', 0) - len(enemiesStatusFull)
        if missingStatusCount > 0:
            enemiesStatusFull.extend([self.DEFAULT_ENEMY_STATUS] * missingStatusCount)
        enemiesStatusFull = sorted(enemiesStatusFull, key=lambda status: (
         status['isDead'], self.STATUS_SORTING_ORDER.index(status['role'])))
        return [ status['role'] + self.DEAD_ENEMY_STATUS_POSTFIX if status['isDead'] else status['role'] for status in enemiesStatusFull
               ]