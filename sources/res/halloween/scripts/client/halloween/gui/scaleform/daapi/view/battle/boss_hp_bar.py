import BigWorld
from PlayerEvents import g_playerEvents
from gui.battle_control import avatar_getter
from gui.impl import backport
from halloween_common.halloween_constants import ARENA_BONUS_TYPE_TO_LEVEL
from halloween.gui.scaleform.daapi.view.meta.BossHPBarMeta import BossHPBarMeta
from HWArenaInfoBossHealthBarComponent import getArenaInfoBossHealthBarComponent

class HWBossHPBar(BossHPBarMeta):

    def _populate(self):
        super(HWBossHPBar, self)._populate()
        g_playerEvents.onRoundFinished += self.__onRoundFinished
        healthBarComponent = getArenaInfoBossHealthBarComponent()
        if not healthBarComponent:
            return
        healthBarComponent.onActivated += self.__onActivated

    def _dispose(self):
        g_playerEvents.onRoundFinished -= self.__onRoundFinished
        healthBarComponent = getArenaInfoBossHealthBarComponent()
        if healthBarComponent:
            healthBarComponent.onBossHealthChanged -= self.__onBossHealthChanged
            healthBarComponent.onActivated -= self.__onActivated
        super(HWBossHPBar, self)._dispose()

    def __onActivated(self):
        healthBarComponent = getArenaInfoBossHealthBarComponent()
        self.__showBossHPBar(True)
        arena = avatar_getter.getArena()
        difficultyLevel = ARENA_BONUS_TYPE_TO_LEVEL.get(arena.bonusType, 1)
        self.as_setMaxLivesS(healthBarComponent.maxLives, difficultyLevel)
        healthBarComponent.onBossHealthChanged += self.__onBossHealthChanged
        curHealth, maxHealth = healthBarComponent.getBossCurrentLifeHealthValues()
        self.__updateBossHPBar(healthBarComponent.livesLeft, curHealth, maxHealth)

    def __showBossHPBar(self, isEnabled):
        self.as_setVisibleS(isEnabled)

    def __onBossHealthChanged(self):
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