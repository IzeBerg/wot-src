import BigWorld
from PlayerEvents import g_playerEvents
from gui.battle_control import avatar_getter
from gui.impl import backport
from halloween.gui.halloween_gui_constants import BATTLE_CTRL_ID
from halloween_common.halloween_constants import ARENA_BONUS_TYPE_TO_LEVEL
from halloween.gui.scaleform.daapi.view.meta.BossHPBarMeta import BossHPBarMeta
from HWArenaInfoBossHealthBarComponent import getArenaInfoBossHealthBarComponent
from helpers import dependency
from skeletons.gui.battle_session import IBattleSessionProvider

class HWBossHPBar(BossHPBarMeta):
    sessionProvider = dependency.descriptor(IBattleSessionProvider)

    @property
    def hwBattleGuiCtrl(self):
        return self.sessionProvider.dynamic.getControllerByID(BATTLE_CTRL_ID.HW_BATTLE_GUI_CTRL)

    def _populate(self):
        super(HWBossHPBar, self)._populate()
        g_playerEvents.onRoundFinished += self.__onRoundFinished
        hwBattleGuiCtrl = self.hwBattleGuiCtrl
        if hwBattleGuiCtrl:
            hwBattleGuiCtrl.onBossHealthChanged += self.__onBossHealthChanged
            hwBattleGuiCtrl.onBossHealthActivated += self.__onActivated

    def _dispose(self):
        g_playerEvents.onRoundFinished -= self.__onRoundFinished
        hwBattleGuiCtrl = self.hwBattleGuiCtrl
        if hwBattleGuiCtrl:
            hwBattleGuiCtrl.onBossHealthChanged -= self.__onBossHealthChanged
            hwBattleGuiCtrl.onBossHealthActivated -= self.__onActivated
        super(HWBossHPBar, self)._dispose()

    def __onActivated(self):
        healthBarComponent = getArenaInfoBossHealthBarComponent()
        curHealth, maxHealth = healthBarComponent.getBossCurrentLifeHealthValues()
        self.__showBossHPBar(True)
        arena = avatar_getter.getArena()
        difficultyLevel = ARENA_BONUS_TYPE_TO_LEVEL.get(arena.bonusType, 1)
        self.as_setMaxLivesS(healthBarComponent.maxLives, difficultyLevel)
        self.__updateBossHPBar(healthBarComponent.livesLeft, curHealth, maxHealth)

    def __showBossHPBar(self, isEnabled):
        self.as_setVisibleS(isEnabled)

    def __onBossHealthChanged(self, newHealth, prevHealth, bossVehicleID, attackerID, attackReasonID):
        healthBarComponent = getArenaInfoBossHealthBarComponent()
        curHealth, maxHealth = healthBarComponent.getBossCurrentLifeHealthValues()
        if curHealth <= 0:
            self.__showBossHPBar(False)
        else:
            self.__updateBossHPBar(healthBarComponent.livesLeft, curHealth, maxHealth)

    def __updateBossHPBar(self, lives, health, maxHealth):
        progress = 100 - int(health * 100 / maxHealth)
        progress = max(0, min(progress, 100))
        health = backport.getNiceNumberFormat(health)
        maxHealth = backport.getNiceNumberFormat(maxHealth)
        values = ('{0} / {1}').format(health, maxHealth)
        self.as_setLivesS(lives)
        self.as_setBossHPS(values, progress)

    def __onRoundFinished(self, winnerTeam, *args):
        if winnerTeam != BigWorld.player().team:
            self.__showBossHPBar(False)